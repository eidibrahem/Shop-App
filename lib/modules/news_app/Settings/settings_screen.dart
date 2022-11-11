import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SettingsScreen",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
            color: Colors.brown[400]
        ),
      ),
    );
  }
}
