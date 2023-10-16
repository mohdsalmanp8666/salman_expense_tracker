import 'package:flutter/material.dart';

class CustomCountryCodeSelector extends StatelessWidget {
  const CustomCountryCodeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ListTile(
                leading: Text("+91"),
                title: Text("India"),
              );
            }),
      ),
    );
  }
}
