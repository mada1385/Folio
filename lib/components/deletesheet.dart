import 'package:flutter/material.dart';
import 'package:folio/constants/colors.dart';

class Deletetask extends StatelessWidget {
  final Function onpressed;
  Deletetask(this.onpressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
          height: 100,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: k_gradient,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                onPressed: onpressed,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 50,
                ),
                color: Colors.transparent,
              ),
            ),
          )),
    );
  }
}
