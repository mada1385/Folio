import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/foliodisplay.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/profilecard.dart';
import 'package:folio/screens/imagge.dart';

class Foliodetailscreen extends StatelessWidget {
  final String tittle, date, description, technologies, id, label;
  final List url;

  Foliodetailscreen(
      {Key key,
      this.id,
      this.label,
      this.tittle,
      this.date,
      this.description,
      this.technologies,
      this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> lsitofphotos() {
      List<Widget> scroll = List<Widget>();

      for (var photo in url) {
        scroll.add(GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Imagescreen(
                          url: photo,
                        )));
          },
          child: Card(
            elevation: 20,
            child: Container(
              child: Image.network(photo.toString()),
            ),
          ),
        ));
      }
      return scroll;
    }

    return Container(
      decoration: BoxDecoration(gradient: k_gradientfolio),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Tiltle(),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                              viewportFraction: .7,
                              aspectRatio: 1.3,
                              autoPlay: true,
                              enlargeCenterPage: true),
                          items: lsitofphotos(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        tittle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: k_backgroundcolor,
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Theme(
                              data: ThemeData(accentColor: k_backgroundcolor),
                              child: ListView(
                                children: <Widget>[
                                  // SizedBox(
                                  //   height: 20,
                                  // ),

                                  // Foliosisplaycard(
                                  //   cardlabel: "tittle",
                                  //   collection: "images",
                                  //   hint: "update id",
                                  //   label: "full_name",
                                  //   data: tittle,
                                  //   id: id,
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Foliosisplaycard(
                                    cardlabel: "date",
                                    collection: "images",
                                    hint: "update id",
                                    label: "date",
                                    data: date,
                                    id: id,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Foliosisplaycard(
                                    cardlabel: "description",
                                    collection: "images",
                                    hint: "description",
                                    label: "full_name",
                                    data: description,
                                    id: id,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Foliosisplaycard(
                                    cardlabel: "technology",
                                    collection: "images",
                                    hint: "description",
                                    label: "full_name",
                                    data: technologies,
                                    id: id,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
