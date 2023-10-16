import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';

class CustomButton extends StatelessWidget {
  final void Function()? func;
  final String buttonName;
  const CustomButton({
    Key? key,
    required this.func,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton(
          onPressed: func,
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Text(
            buttonName,
            style: customTextStyle(h3, FontWeight.w400,
                textColor: primaryTextColor),
          )),
    );
  }
}
