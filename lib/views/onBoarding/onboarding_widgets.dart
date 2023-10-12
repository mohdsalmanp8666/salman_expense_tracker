import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/onBoarding/OnBoardingProvider.dart';
import 'package:salman_expense_tracker/views/common/styles.dart';

class PageContent extends StatelessWidget {
  final String imgName;
  const PageContent({
    super.key,
    required this.imgName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$imgName.jpg',
            filterQuality: FilterQuality.high,
          ),
          // Text("Find the best path to nearest pharmacy")
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
              : Navigator.popAndPushNamed(context, '/homeScreen');
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
