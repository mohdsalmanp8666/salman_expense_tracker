import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/onBoarding/OnBoardingProvider.dart';
import 'package:salman_expense_tracker/views/onBoarding/onboarding_widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var readProvider = context.read<OnBoardingProvider>();
    var watchProvider = context.watch<OnBoardingProvider>();
    return Scaffold(
      body: Column(
        children: [
          // * PageView method for animated pages
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: readProvider.pageController,
              onPageChanged: (value) => readProvider.updateIndex(value),
              itemCount: 2,
              itemBuilder: ((context, index) {
                return PageContent(
                  imgName: index == 0 ? 'img1' : 'img2',
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // * PageView Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IndicatorPill(
                      status: watchProvider.pageIndex == 0 ? true : false,
                    ),
                    const SizedBox(width: 15),
                    IndicatorPill(
                      status: watchProvider.pageIndex == 1 ? true : false,
                    ),
                  ],
                ),
                // * Get Started Button
                MainButton(
                  index: watchProvider.pageIndex,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
