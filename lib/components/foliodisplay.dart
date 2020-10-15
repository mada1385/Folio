import 'package:flutter/material.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/screens/updatescreen.dart';

class Foliosisplaycard extends StatelessWidget {
  final String data, hint, id, label, collection, email, cardlabel;

  Foliosisplaycard(
      {Key key,
      this.cardlabel,
      this.data,
      this.hint,
      this.id,
      this.label,
      this.collection,
      this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 20,
              child: Container(
                width: double.infinity,
                // height: 200,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: k_backgroundcolor, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                ),
                // width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        data,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 50,
                top: 12,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  color: Colors.white,
                  child: Text(
                    cardlabel,
                    style: TextStyle(
                      color: k_backgroundcolor,
                      fontSize: 15,
                    ),
                  ),
                )),
          ],
        )

        //  Container(
        //   child: Card(
        //     elevation: 20,
        //     child: Container(
        //       width: double.infinity,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 20),
        //           child: Center(
        //             child: Text(
        //               data,
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        );
  }
}
