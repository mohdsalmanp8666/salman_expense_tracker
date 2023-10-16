import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/providers/home_provider.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';
import 'package:salman_expense_tracker/views/home/home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<void> getData() async {
    //   var provider = Provider.of<HomeProvider>(context, listen: false);
    //   await provider.getValues();
    // }
    var read_homeProvider = context.read<HomeProvider>();
    var watch_homeProvider = context.watch<HomeProvider>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: primaryColor,
      //   foregroundColor: primaryTextColor,
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF6E5),
        centerTitle: true,
        title: Text(
          "Expense Tracker",
          style: customTextStyle(h2, FontWeight.w500, letterSpacing: 1.5),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: watch_homeProvider.index,
        onTap: (value) => read_homeProvider.setIndex(value),
        selectedItemColor: primaryColor,
        selectedLabelStyle:
            customTextStyle(body, FontWeight.w300, textColor: primaryColor),
        unselectedItemColor: Colors.black.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_outlined), label: "Transactions"),
        ],
      ),
      body: SafeArea(
        child: watch_homeProvider.index == 1
            ? Container(
                color: Colors.white,
                child: (read_homeProvider.items.isEmpty)
                    ? const NoTransactionText()
                    : Column(
                        children: [
                          transactionsText("All Transactions"),
                          Expanded(
                            child: ListView.builder(
                                itemCount: read_homeProvider.items.length,
                                itemBuilder: (context, index) {
                                  var length = read_homeProvider.items.length;
                                  var data = watch_homeProvider
                                      .items[(length - 1) - index];

                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          data.transactionName.toString(),
                                          style: customTextStyle(
                                              h5, FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          "${data.date}",
                                          style: customTextStyle(
                                              body, FontWeight.w400,
                                              textColor: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        trailing: Text(
                                          data.transactionType == "Income"
                                              ? "+\$${data.amount}"
                                              : "-\$${data.amount}",
                                          style: customTextStyle(
                                              h5, FontWeight.w600,
                                              textColor: data.transactionType ==
                                                      "Income"
                                                  ? successColor
                                                  : dangerColor),
                                        ),
                                      ));
                                }),
                          ),
                        ],
                      ),
              )
            :
            // * Home Screen Content
            Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF6E5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: Column(
                      children: [
                        // * Account balance
                        AccountBalance(
                            balance: watch_homeProvider.currentBalance),
                        // * Income and Expenses Button
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTile(
                                bgColor: successColor,
                                title: "Income",
                                amount: watch_homeProvider.totalIncome,
                              ),
                              ButtonTile(
                                bgColor: dangerColor,
                                title: "Expenses",
                                amount: watch_homeProvider.totalExpense,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // * Transactions
                  transactionsText("Recent Transactions"),
                  Expanded(
                    child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                      if (value.items.isEmpty) {
                        return const NoTransactionText();
                      }
                      return ListView.builder(
                          itemCount: read_homeProvider.items.isEmpty
                              ? 0
                              : read_homeProvider.items.length > 5
                                  ? 5
                                  : read_homeProvider.items.length,
                          itemBuilder: (context, index) {
                            var length = read_homeProvider.items.length;
                            var data =
                                watch_homeProvider.items[(length - 1) - index];

                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    data.transactionName.toString(),
                                    style: customTextStyle(h5, FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    "${data.date}",
                                    style: customTextStyle(
                                        body, FontWeight.w400,
                                        textColor:
                                            Colors.black.withOpacity(0.5)),
                                  ),
                                  trailing: Text(
                                    data.transactionType == "Income"
                                        ? "+\$${data.amount}"
                                        : "-\$${data.amount}",
                                    style: customTextStyle(h5, FontWeight.w600,
                                        textColor:
                                            data.transactionType == "Income"
                                                ? successColor
                                                : dangerColor),
                                  ),
                                ));
                          });
                    }),
                  ),
                ],
              ),
      ),
    );
  }

  Container transactionsText(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 25, top: 25, bottom: 10),
      child: Text(
        "$title: ",
        style: customTextStyle(h4, FontWeight.w500),
      ),
    );
  }
}
