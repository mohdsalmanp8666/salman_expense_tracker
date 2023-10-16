import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/providers/home/home_provider.dart';
import 'package:salman_expense_tracker/providers/onBoarding/OnBoardingProvider.dart';
import 'package:salman_expense_tracker/providers/transaction_providers/transaction_provider.dart';
import 'package:salman_expense_tracker/views/home/home_screen.dart';
import 'package:salman_expense_tracker/views/onBoarding/onboarding_screen.dart';
import 'package:salman_expense_tracker/views/transaction/transaction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'Demo Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/homeScreen',
        routes: {
          '/onBoardingScreen': (context) => const OnBoardingScreen(),
          '/homeScreen': (context) => const HomeScreen(),
          '/addTransaction': (context) => const TransactionScreen(),
        },
      ),
    );
  }
}
