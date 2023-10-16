import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/models/user_model.dart';
import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/providers/register_provider.dart';
import 'package:salman_expense_tracker/views/authentication/authentications_widgets.dart';

import 'package:salman_expense_tracker/views/common/styles.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var read_register_provider = context.read<RegisterProvider>();
    var watch_register_provider = context.watch<RegisterProvider>();
    // TextEditingController nameController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Registeration Screen"),
        ),
        body: SafeArea(
          child: Provider.of<AuthProvider>(context).loading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          read_register_provider.selectImage(context);
                        },
                        borderRadius: BorderRadius.circular(45),
                        // ignore: unnecessary_null_comparison
                        child: watch_register_provider.image == null
                            ? const CircleAvatar(
                                backgroundColor: secondaryColor,
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: primaryColor,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(read_register_provider.image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            // Name Field
                            CustomTextField(
                                hintText: "Name",
                                icon: Icons.account_circle_outlined,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                isError: watch_register_provider.nameError,
                                controller:
                                    read_register_provider.nameController),
                            CustomTextField(
                                hintText: "Email",
                                icon: Icons.email_outlined,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                isError: watch_register_provider.emailError,
                                controller:
                                    read_register_provider.emailController),
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomButton(
                              func: () {
                                if (read_register_provider.checkValues() ==
                                    true) {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .createUser(
                                    context: context,
                                    userDetails: UserPersonalDetails(
                                      name: read_register_provider
                                          .nameController.text
                                          .trim(),
                                      email: read_register_provider
                                          .emailController.text
                                          .trim(),
                                      phoneNumber: "",
                                      profilePic: "",
                                      createdAt: "",
                                    ),
                                    img: read_register_provider.image!,
                                    onSuccess: () {
                                      final ap = Provider.of<AuthProvider>(
                                          context,
                                          listen: false);

                                      ap.saveDataLocally().then((value) {
                                        ap.setSignIn().then((value) =>
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/homeScreen',
                                                (route) => false));
                                      });
                                    },
                                  );
                                }
                              },
                              buttonName: "Register")),
                      Container(),
                    ],
                  ),
                ),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  final int maxLines;
  final bool isError;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.inputType,
    required this.maxLines,
    required this.controller,
    required this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        maxLines: 1,
        controller: controller,
        keyboardType: inputType,
        textCapitalization: inputType == TextInputType.name
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
            hintText: "Please Enter $hintText",
            errorText: isError == true ? "Please check your $hintText" : null,
            prefixIcon: Icon(icon),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(16),
            )),
        style: customTextStyle(h4, FontWeight.w400, textColor: Colors.black),
      ),
    );
  }
}
