import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salman_expense_tracker/firebase_options.dart';
import 'package:salman_expense_tracker/providers/auth_provider.dart';
import 'package:salman_expense_tracker/providers/home_provider.dart';
import 'package:salman_expense_tracker/providers/OnBoardingProvider.dart';
import 'package:salman_expense_tracker/providers/login_provider.dart';
import 'package:salman_expense_tracker/providers/register_provider.dart';
import 'package:salman_expense_tracker/providers/transaction_provider.dart';
import 'package:salman_expense_tracker/views/authentication/login_screen.dart';
import 'package:salman_expense_tracker/views/authentication/otp_screen.dart';
import 'package:salman_expense_tracker/views/home/home_screen.dart';
import 'package:salman_expense_tracker/views/onBoarding/onboarding_screen.dart';
import 'package:salman_expense_tracker/views/transaction/transaction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Future<SharedPreferences> pref = SharedPreferences.getInstance();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'Demo Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/onBoardingScreen',
        routes: {
          '/onBoardingScreen': (context) => const OnBoardingScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          '/homeScreen': (context) => const HomeScreen(),
          '/addTransaction': (context) => const TransactionScreen(),
        },
      ),
    );
  }
}
