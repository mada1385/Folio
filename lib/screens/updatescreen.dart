import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/components/roundbutton.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/screens/portfoliossceen.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:folio/screens/nointernetscreen.dart';

class Updatescreen extends StatefulWidget {
  final String hint, id, label, collection, email;

  Updatescreen({
    Key key,
    this.email,
    this.collection,
    this.hint,
    this.id,
    this.label,
  }) : super(key: key);

  @override
  _UpdatescreenState createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  final userref = Firestore.instance;

  String eupdate = null;
  final cupdate = TextEditingController();

  String update;
  bool vupdate = false;
  Future<Void> updateinfo(String data, label, collection) async {
    await Firestore.instance
        .collection(collection)
        .document(widget.id)
        .updateData({
      label: data,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      // disableInteraction: true,
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: k_gradient),
          child: SafeArea(
            child: SizedBox.expand(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    // TextField(
                    //   onChanged: (val) {
                    //     setState(() {
                    //       update = val;
                    //       print(val);
                    //     });
                    //   },
                    // ),
                    Maintextfield(
                      controller: cupdate,
                      validate: vupdate,
                      hint: widget.hint,
                      error: eupdate,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Roundbutton(
                      label: "update",
                      func: () async {
                        print(cupdate.text);
                        print(widget.label);
                        print(widget.collection);
                        print(widget.id);

                        await updateinfo(
                            cupdate.text, widget.label, widget.collection);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      useremail:
                                          Provider.of<Userprovider>(context)
                                              .email,
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
