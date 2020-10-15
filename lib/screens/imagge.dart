import 'package:flutter/material.dart';

class Imagescreen extends StatelessWidget {
  final String url;

  Imagescreen({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox.expand(
        child: Container(
          child: Image.network(url),
        ),
      ),
    ));
  }
}
