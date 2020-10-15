import 'package:flutter/material.dart';
import 'package:folio/constants/colors.dart';

class Maintextfield extends StatelessWidget {
  Maintextfield({
    Key key,
    @required this.controller,
    @required this.validate,
    @required this.hint,
    this.error,
    // this.error = 'this feild Can\'t Be Empty',
    this.obsucure = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool validate, obsucure;
  final String hint;
  final String error;
  // List errors = [
  //   "this field can\'t be empty",
  //   "password is not matching",
  //   "email format is not valid"
  // ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 80, left: 80),
      child: TextField(
        obscureText: obsucure,
        controller: controller,
        decoration: InputDecoration(
            errorText: validate
                ? error == null ? "this field can\'t be empty" : error
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: k_backgroundcolor),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: k_backgroundcolor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: k_backgroundcolor),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey,
            )),
      ),
    );
  }
}
