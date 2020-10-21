import 'package:flutter/material.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/screens/updatescreen.dart';

class Updatedinfocard extends StatelessWidget {
  final String data, hint, id, label, collection, email;

  Updatedinfocard(
      {Key key,
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
      child: Container(
        child: Row(
          children: [
            Card(
              elevation: 20,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Center(
                        child: Text(
                          data,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: k_backgroundcolor,
                ),
                onPressed: () {
                  if (!id.isEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Updatescreen(
                                  hint: hint,
                                  id: id,
                                  label: label,
                                  collection: collection,
                                )));
                  }
                })
          ],
        ),
      ),
    );
  }
}
