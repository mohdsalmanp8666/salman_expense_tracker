import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier {
  int pageIndex = 0;

  PageController pageController = PageController();
  updateIndex(int i) {
    pageIndex = i;
    notifyListeners();
  }

  scrollPage(int i) {
    pageController
        .
        // jumpToPage(i);
        animateToPage(i,
            duration: const Duration(milliseconds: 350), curve: Curves.linear);
    updateIndex(i);
  }
}
