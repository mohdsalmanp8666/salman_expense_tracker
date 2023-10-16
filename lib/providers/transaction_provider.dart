import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

class TransactionProvider with ChangeNotifier {
  TextEditingController amountController = TextEditingController();
  bool amountError = false;
  TextEditingController transactionName = TextEditingController();
  bool nameError = false;

  var dateTime = Moment.now();

  updateTime(DateTime? d) {
    dateTime = d!.toLocal().toMoment();
    notifyListeners();
  }

  checkValues(BuildContext context) {
    if (amountController.text.isEmpty) {
      amountError = true;
      notifyListeners();
    } else if (transactionName.text.isEmpty) {
      nameError = true;
      notifyListeners();
    } else {
      return true;
    }
  }

  clearValues() {
    amountController.clear();
    transactionName.clear();
    notifyListeners();
  }

  clearErrors() {
    amountError = false;
    nameError = false;
    notifyListeners();
  }
}
