import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/roundtext.dart';
import 'package:folio/screens/folioscreen.dart';
import 'package:folio/screens/portfolioscreen.dart';
import 'package:folio/components/deletesheet.dart';

class Foliocard extends StatelessWidget {
  final List url;
  final String tittle, date, description, technology, id, label;
  final bool display;

  Foliocard(
      {Key key,
      this.display = false,
      this.label,
      this.id,
      this.url,
      this.tittle,
      this.date,
      this.description,
      this.technology})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Deletetask(
              () async {
                await Firestore.instance
                    .collection("images")
                    .document(id)
                    .delete();
              },
            ),
            isScrollControlled: true,
          );
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => display
                      ? Foliodetailscreen(
                          date: date,
                          description: description,
                          technologies: technology,
                          tittle: tittle,
                          url: url,
                          id: id,
                        )
                      : Portfolioscreen(
                          date: date,
                          description: description,
                          technologies: technology,
                          tittle: tittle,
                          url: url,
                          id: id,
                        )));
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    url[0],
                    width: 100,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Roundtext(tittle: tittle),
                ),
              ],
            ),
            elevation: 20,
            borderOnForeground: true,

            // color: k_backgroundcolor,
          ),
        ),
      ),
    );
  }
}
