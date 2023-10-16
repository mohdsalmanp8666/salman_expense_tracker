import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/providers/login_provider.dart';
import 'package:salman_expense_tracker/views/authentication/authentications_widgets.dart';
import 'package:salman_expense_tracker/views/authentication/login_screen_widgets.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var read_login_provider = context.read<LoginProvider>();
    var watch_login_provider = context.watch<LoginProvider>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(flex: 2, child: Image.asset('assets/images/img1.jpg')),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: customTextStyle(34, FontWeight.w600,
                          textColor: primaryColor),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Add your phone number. We'll send you a verification code",
                      textAlign: TextAlign.center,
                      style: customTextStyle(body, FontWeight.w300),
                    ),
                    const SizedBox(height: 35),
                    Flexible(
                      child: TextField(
                        controller:
                            Provider.of<LoginProvider>(context, listen: false)
                                .phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // ? Hint Text
                          hintText: "Enter your phone number",
                          // ? Border
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // ? Prefix

                          prefixIcon: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                "+91",
                                style: customTextStyle(body, FontWeight.w400,
                                    textColor: Colors.black),
                              ),
                            ),
                          ),
                          errorText:
                              Provider.of<LoginProvider>(context).phoneError
                                  ? "Check your phone number"
                                  : null,
                        ),
                        onChanged: (value) {
                          Provider.of<LoginProvider>(context, listen: false)
                              .updateError((value.isNotEmpty) ? false : true);
                        },

                        // ? Cursor
                        cursorColor: primaryColor,
                        onTapOutside: ((event) =>
                            FocusScope.of(context).unfocus()),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Provider.of<AuthProvider>(context).loading == true
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          )
                        : Container(),
                    CustomButton(
                      buttonName: "Send OTP",
                      func: () {
                        if (read_login_provider.checkValues() == true) {
                          print(
                              "+91${read_login_provider.phoneController.text.trim()}");
                          Provider.of<AuthProvider>(context, listen: false)
                              .signInWithPhone(context,
                                  "+91${read_login_provider.phoneController.text.trim()}");
                        }
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),

              // // * Login Form
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 25),
              // child: Flexible(
              //   child: TextField(
              //     controller: phoneController,
              //     decoration: InputDecoration(
              //       // ? Hint Text
              //       // ? Border
              //       border: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: Colors.black.withOpacity(0.5)),
              //         borderRadius: BorderRadius.circular(16),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: Colors.black.withOpacity(0.5)),
              //         borderRadius: BorderRadius.circular(16),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor),
              //         borderRadius: BorderRadius.circular(16),
              //       ),
              //       // ? Prefix
              //       prefixIcon: Container(
              //         padding: const EdgeInsets.all(5),
              //         child: InkWell(
              //           onTap: () {},
              //           child: Text("data"),
              //         ),
              //       ),
              //     ),
              //     // ? Cursor
              //     cursorColor: primaryColor,
              //     onTapOutside: ((event) => FocusScope.of(context).unfocus()),
              //   ),
              // ),
              // ),
              // Container(),
            ],
          ),
        ),
      ),
    );
  }
}
