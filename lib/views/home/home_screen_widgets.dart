import 'package:flutter/material.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';
import 'package:salman_expense_tracker/views/transaction/transaction_screen.dart';

class NoTransactionText extends StatelessWidget {
  const NoTransactionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Text(
          "No transactions to display!",
          style: customTextStyle(h5, FontWeight.w400),
        ),
      ),
    );
  }
}

class ButtonTile extends StatelessWidget {
  final Color bgColor;
  final String title;
  final int amount;

  const ButtonTile({
    super.key,
    required this.bgColor,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TransactionScreen(
                    transactionType: title,
                  ))),
      child: Container(
        height: 100,
        width: (MediaQuery.of(context).size.width - 60) * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                title == "Income"
                    ? Icons.add_circle_outline
                    : Icons.remove_circle_outline,
                color: bgColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: customTextStyle(body, FontWeight.w400,
                          textColor: Colors.white),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "\$$amount",
                        overflow: TextOverflow.clip,
                        style: customTextStyle(h3, FontWeight.w600,
                            textColor: Colors.white),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class AccountBalance extends StatelessWidget {
  final int balance;
  const AccountBalance({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            "Account Balance (Savings)",
            style: customTextStyle(body, FontWeight.w400),
          ),
          const SizedBox(height: 5),
          Text(
            "\$$balance",
            style: customTextStyle(largeHeading, FontWeight.w500,
                textColor: balance == 0
                    ? Colors.black
                    : balance < 0
                        ? dangerColor
                        : successColor),
          ),
        ],
      ),
    );
  }
}
