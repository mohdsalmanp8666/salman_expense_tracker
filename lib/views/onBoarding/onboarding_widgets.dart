import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/OnBoardingProvider.dart';
import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';

class PageContent extends StatelessWidget {
  final String imgName;
  final String title;
  const PageContent({
    super.key,
    required this.imgName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/$imgName.jpg',
            filterQuality: FilterQuality.high,
          ),
          Container(
              margin: const EdgeInsets.only(top: 50, bottom: 25),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(),
              alignment: Alignment.center,
              child: Text(
                title,
                style: customTextStyle(h3, FontWeight.w300),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final int index;
  const MainButton({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var readProvider = context.read<OnBoardingProvider>();
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: () {
          (index == 0)
              ? readProvider.scrollPage(1)
              : Navigator.popAndPushNamed(
                  context,
                  Provider.of<AuthProvider>(context, listen: false)
                              .isSignedIn ==
                          true
                      ? '/homeScreen'
                      : '/loginScreen');
          // (index == 0)
          //     ? readProvider.scrollPage(1)
          //     : Navigator.popAndPushNamed(context, '/loginScreen');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        child: Text(
          index == 0 ? "Next" : "Get Started",
          style: const TextStyle(fontSize: 20, color: primaryTextColor),
        ),
      ),
    );
  }
}

class IndicatorPill extends StatelessWidget {
  final bool status;
  const IndicatorPill({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: status == true ? 25 : 15,
      height: status == true ? 25 : 15,
      decoration: BoxDecoration(
          color: status == true ? primaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(25)),
    );
  }
}
