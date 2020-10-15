import 'package:flutter/material.dart';
import 'package:folio/components/roundbutton.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/screens/login.dart';
import 'package:folio/screens/portfoliossceen.dart';
import 'dart:io';
import 'package:provider/provider.dart';
// import 'package:folio/';

class Nointernetscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: k_gradient),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Tiltle(),
              centerTitle: true,
            ),
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "asset/noI.png",
                  height: 400,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )));
  }
}
