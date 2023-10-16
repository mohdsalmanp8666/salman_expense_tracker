import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/models/user_model.dart';
import 'package:salman_expense_tracker/providers/shared_pref.dart';
import 'package:salman_expense_tracker/views/common/utils.dart';

class RegisterProvider with ChangeNotifier {
  File? _image;
  File? get image => _image;
  bool _imageError = false;
  bool get imageError => _imageError;
  toggleImageError(bool status) {
    _imageError = status;
    notifyListeners();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  bool _nameError = false;
  bool get nameError => _nameError;
  toggleNameError(bool status) {
    _nameError = status;
    notifyListeners();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  bool _emailError = false;
  bool get emailError => _emailError;
  toggleEmailError(bool status) {
    _emailError = status;
    notifyListeners();
  }

  selectImage(BuildContext context) async {
    _image = await pickImage(context);
    notifyListeners();
  }

  checkValues() {
    if (_image == null) {
      toggleImageError(true);
    }
    if (_nameController.text.isEmpty) {
      toggleNameError(true);
    }
    if (_emailController.text.isEmpty) {
      toggleEmailError(true);
    }
    if (_image != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      // * Move Ahead
      toggleImageError(false);
      toggleNameError(false);
      toggleEmailError(false);
      return true;
    }
    return false;
  }


}
