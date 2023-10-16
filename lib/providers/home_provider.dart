import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/models/transaction_model.dart';

class HomeProvider with ChangeNotifier {
  // * Bottom Navigation
  int index = 0;

  setIndex(i) {
    index = i;
    notifyListeners();
  }

  bool loading = false;

  List<TransactionModel> items = [];

  int totalIncome = 0;
  int totalExpense = 0;
  int currentBalance = 0;

  addTransaction(TransactionModel tr) {
    items.add(tr);
    // pref.save('transactions', items);
    if (tr.transactionType == "Income") {
      addIncome(tr.amount!.toInt());
    } else {
      addExpense(tr.amount!.toInt());
    }
    notifyListeners();
  }

  addIncome(int amount) {
    totalIncome = totalIncome + amount;
    currentBalance = currentBalance + amount;
    // pref.save("totalIncome", totalIncome);
    // pref.save("currentBalance", currentBalance);
  }

  addExpense(int amount) {
    totalExpense = totalExpense + amount;
    currentBalance = currentBalance - amount;
    // pref.save('totalExpense', totalExpense);
    // pref.save("currentBalance", currentBalance);
  }
}
