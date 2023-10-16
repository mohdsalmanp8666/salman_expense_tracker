import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/models/user_model.dart';
import 'package:salman_expense_tracker/providers/shared_pref.dart';
import 'package:salman_expense_tracker/views/authentication/otp_screen.dart';
import 'package:salman_expense_tracker/views/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  SharedPref pref = SharedPref();

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  Future setSignIn() async {
    await pref.setBool('is_signedin', true);
  }

  bool _loading = false;
  bool get loading => _loading;

  String _uid = "";
  String get uid => _uid;

  String _otpCode = "";
  String get otpCode => _otpCode;
  setOtpValue(String otp) {
    _otpCode = otp;
    notifyListeners();
  }

  bool _otpError = false;
  bool get otpError => _otpError;
  toggleOTPError(bool status) {
    _otpError = status;
    notifyListeners();
  }

// * Firebase Initialization
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }
  void toggleLoading(bool status) {
    _loading = status;
    notifyListeners();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('is_signedin') ?? false;
    notifyListeners();
  }

  // * Sign In With Phone
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      toggleLoading(true);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          toggleLoading(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {}
  }

  // * Verify OTO
  void verifyOTP({
    required String verificationId,
    required Function onSuccess,
  }) async {
    toggleLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _otpCode);
      User user = (await _firebaseAuth.signInWithCredential(credential)).user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        // * We can go forward
        _uid = user.uid;
        onSuccess();
        toggleLoading(false);
      } else {
        toggleLoading(false);
      }
    } on FirebaseAuthException catch (e) {}
  }

  // * Database Operations
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  createUser({
    required BuildContext context,
    required UserPersonalDetails userDetails,
    required File img,
    required Function onSuccess,
  }) async {
    toggleLoading(true);
    try {
      // ? Uploading Image to firebase storage
      storeFiletoStorage("profilePic/$uid", img).then((value) {
        userDetails.profilePic = value;
        userDetails.createdAt =
            DateTime.now().microsecondsSinceEpoch.toString();
        userDetails.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = UserModel(uid: _uid, details: userDetails);

      // ? Adding in database
      await _firestore
          .collection('users')
          .doc(_uid)
          .set(userDetails.toMap())
          .then((value) {
        onSuccess();
        toggleLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      toggleLoading(false);
    }
  }

  // * Uploading profile pic to storage
  Future<String> storeFiletoStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = uploadTask.snapshot;
    String downloadUrl = await snapshot.ref.getDownloadURL().toString();
    return downloadUrl;
  }

  // * Storing data locally
  Future saveDataLocally() async {
    await pref.save("user_model", userModel);
  }
}
