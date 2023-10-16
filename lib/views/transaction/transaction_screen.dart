import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/models/transaction_model.dart';
import 'package:salman_expense_tracker/providers/home_provider.dart';
import 'package:salman_expense_tracker/providers/transaction_provider.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';

class TransactionScreen extends StatelessWidget {
  final String transactionType;
  const TransactionScreen({super.key, this.transactionType = "Income"});

  @override
  Widget build(BuildContext context) {
    var readProvider = context.read<TransactionProvider>();
    var watchProvider = context.watch<TransactionProvider>();

    return Scaffold(
      // * AppBar
      appBar: AppBar(
        backgroundColor:
            transactionType == "Income" ? successColor : dangerColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              readProvider.clearValues();
              readProvider.clearErrors();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            )),
        title: Text(
          transactionType,
          // "Income",
          style:
              customTextStyle(h3, FontWeight.normal, textColor: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: transactionType == "Income" ? successColor : dangerColor,
        child: Column(
          children: [
            // * Amount TextField
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "How much?",
                        style: customTextStyle(h4, FontWeight.w400,
                            textColor: Colors.white.withOpacity(0.5)),
                      ),
                      TextField(
                        controller: readProvider.amountController,
                        onTapOutside: ((event) =>
                            FocusScope.of(context).unfocus()),
                        keyboardType: TextInputType.number,
                        style: customTextStyle(largeHeading, FontWeight.w500,
                            textColor: Colors.white),
                        showCursor: false,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            readProvider.clearErrors();
                          }
                        },
                        decoration: InputDecoration(
                          errorText: watchProvider.amountError == true
                              ? "Please enter Amount"
                              : null,
                          prefixIcon: const Icon(
                            Icons.attach_money_outlined,
                            size: h1,
                            color: Colors.white,
                          ),
                          hintText: "0",
                          hintStyle: customTextStyle(
                              largeHeading, FontWeight.w500,
                              textColor: const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.5)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                      // Text("How much?"),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // * Category Field
                        // * Transaction Name
                        TextField(
                          maxLines: 1,
                          controller: readProvider.transactionName,
                          onTapOutside: ((event) =>
                              FocusScope.of(context).unfocus()),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              readProvider.clearErrors();
                            }
                          },
                          decoration: InputDecoration(
                            errorText: watchProvider.nameError == true
                                ? transactionType == "Income"
                                    ? "Please enter Transaction Name (E.g: Salary, Weekly Pay, etc.)"
                                    : "Please enter Transaction Name (E.g: Shopping, etc.)"
                                : null,
                            hintText: "Transaction Title",
                            hintStyle: customTextStyle(body, FontWeight.w300,
                                textColor: Colors.black.withOpacity(0.5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        // * Current Time and date
                        GestureDetector(
                          onTap: () async {
                            readProvider
                                .updateTime(await showOmniDateTimePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now(),
                            ));
                          },
                          child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 25),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(16)),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${watchProvider.dateTime}",
                              style: customTextStyle(h4, FontWeight.w400,
                                  textColor: Colors.black),
                            ),
                          ),
                        ),
                        // DatePickerDialog(initialDate: Date, firstDate: firstDate, lastDate: lastDate)
                        // * Save Button
                        Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 25),
                          child: ElevatedButton(
                              onPressed: () {
                                var r = readProvider.checkValues(context);
                                if (r == true) {
                                  context
                                      .read<HomeProvider>()
                                      .addTransaction(TransactionModel(
                                        transactionName:
                                            readProvider.transactionName.text,
                                        amount: int.parse(
                                            readProvider.amountController.text),
                                        transactionType: transactionType,
                                        date: readProvider.dateTime.toString(),
                                      ));

                                  readProvider.clearValues();
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              child: Text(
                                "Save",
                                style: customTextStyle(h3, FontWeight.normal,
                                    textColor: Colors.white),
                              )),
                        ),
                        // Container(child: ,)
                      ],
                    ),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
