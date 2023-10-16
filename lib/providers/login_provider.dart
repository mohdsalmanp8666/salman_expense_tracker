import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/providers/shared_pref.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController phoneController = TextEditingController();
  // bool phoneError = false;
  bool _phoneError = false;
  bool get phoneError => _phoneError;

  checkValues() {
    if (phoneController.text.isEmpty) {
      updateError(true);
      return false;
    } else {
      if (phoneController.text.length < 10) {
        updateError(true);
        return false;
      }
      updateError(false);
      return true;
    }
  }

  updateError(bool status) {
    _phoneError = status;
    notifyListeners();
  }
}
