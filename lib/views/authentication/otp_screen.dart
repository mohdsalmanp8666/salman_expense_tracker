import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/views/authentication/authentications_widgets.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';
import 'package:salman_expense_tracker/views/register/register_screen.dart';

class OTPScreen extends StatelessWidget {
  final String verificationId;

  const OTPScreen({
    super.key,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    String _otpCode = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(verificationId),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            Expanded(flex: 1, child: Image.asset('assets/images/img1.jpg')),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    "OTP Verification",
                    style: customTextStyle(34, FontWeight.w600,
                        textColor: primaryColor),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "A verification code is sent to your number.\nEnter the OTP.",
                    textAlign: TextAlign.center,
                    style: customTextStyle(body, FontWeight.w300),
                  ),
                  const SizedBox(height: 35),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color:
                                Provider.of<AuthProvider>(context).otpError ==
                                        true
                                    ? Colors.red.shade600
                                    : primaryColor),
                      ),
                      textStyle: const TextStyle(
                          fontSize: h2, fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .toggleOTPError(true);
                      } else {
                        Provider.of<AuthProvider>(context, listen: false)
                            .toggleOTPError(false);
                        Provider.of<AuthProvider>(context, listen: false)
                            .setOtpValue(value);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  // * Loading Status for OTP Verification
                  Provider.of<AuthProvider>(context).loading == true
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Container(),
                  // * Error Message for Invalid OTP
                  Provider.of<AuthProvider>(context).otpError == true
                      ? Container(
                          // height: 70,
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invalid OTP!",
                                style: customTextStyle(body, FontWeight.w400,
                                    textColor: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () => Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .toggleOTPError(false),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        )
                      : Container(),
                  // * Verify OTP Button
                  CustomButton(
                      func: () {
                        if (Provider.of<AuthProvider>(context, listen: false)
                            .otpCode
                            .isEmpty) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .toggleOTPError(true);
                        } else {
                          Provider.of<AuthProvider>(context, listen: false)
                              .verifyOTP(
                                  verificationId: verificationId,
                                  onSuccess: () {
                                    // Provider.of<AuthProvider>(context,
                                    //         listen: false)
                                    //     .toggleLoading(false);
                                    // * Checking if the user exists in our DB
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .checkExistingUser()
                                        .then((value) async {
                                      if (value == true) {
                                        // * Means User present in out Database
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/homeScreen',
                                            (route) => false);
                                      } else {
                                        // * New User

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const RegistrationScreen()),
                                            (route) => false);
                                      }
                                    });
                                  });
                        }
                      },
                      buttonName: "Verify OTP"),
                  const SizedBox(height: 30),
                  Text(
                    "Didn't receive any code?",
                    style: customTextStyle(h5, FontWeight.w300),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Resend New Code",
                    style: customTextStyle(h5, FontWeight.w500,
                        textColor: primaryColor),
                  ),
                  // const SizedBox(height: 30),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
