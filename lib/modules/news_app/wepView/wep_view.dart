import 'package:flutter/material.dart';

class webViews extends StatelessWidget {
  final String url;

  const webViews({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Center(
          child: Text('Wib View'),
        )));
  }
}
