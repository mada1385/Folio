import 'package:flutter/material.dart';

class Roundtext extends StatelessWidget {
  const Roundtext({
    Key key,
    @required this.tittle,
  }) : super(key: key);

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          child: Text(tittle),
        ),
      ),
    );
  }
}
