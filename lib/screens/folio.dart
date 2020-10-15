import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/foliocard.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';

class Folioscreen extends StatefulWidget {
  final String useremail;

  Folioscreen({Key key, this.useremail}) : super(key: key);

  @override
  _FolioscreenState createState() => _FolioscreenState();
}

class _FolioscreenState extends State<Folioscreen> {
  void initState() {
    getuser();
    // print("hello");
    super.initState();
  }

  void getuser() async {
    String username;
    var messges = await _store
        .collection("user")
        .where('email', isEqualTo: widget.useremail)
        .getDocuments();
    for (var massege in messges.documents) {
      setState(() {
        name = massege.data["full_name"];
        job = massege.data["jobtitle"];
        pic = massege.data["photo"];
      });
    }
    // return username;
  }

  final _store = Firestore.instance;

  String name = " ";

  String job = "";
  String pic = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: k_gradientfolio),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Tiltle(),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: ListView(children: [
            Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Positioned(
                  top: 75.0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height - 100.0,
                      width: MediaQuery.of(context).size.width)),
              Positioned(
                  top: 30.0,
                  left: (MediaQuery.of(context).size.width / 2) - 100.0,
                  child:
                      // CircleAvatar(
                      //   backgroundColor: Colors.amber,
                      //   radius: 70,
                      // ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: pic != null
                                      ? NetworkImage(pic)
                                      : AssetImage("asset/nopic.jpg"),
                                  fit: BoxFit.cover)),
                          height: 200.0,
                          width: 200.0)),
              Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // color: k_backgroundcolor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: k_backgroundcolor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: k_backgroundcolor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        job,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("images")
                          .where('email', isEqualTo: widget.useremail)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                                backgroundColor: k_backgroundcolor),
                          );
                        } else {
                          final portfolios = snapshot.data.documents;
                          List<Widget> chatlist = [];

                          for (int i = 0; i < 1; i++) {
                            for (var portfolio in portfolios) {
                              final tittle = portfolio.data["full_name"];
                              final description = portfolio.data["description"];
                              final date = portfolio.data["date"];
                              final technologies =
                                  portfolio.data["technologies"];
                              final email = portfolio.data["email"];
                              final url = portfolio.data["urls"];
                              // final id = portfolio.id ;

                              // final alignment = messagesender == loggedInUser.email ?  TextAlign.end :  TextAlign.start  ;

                              final portfoliocard = Foliocard(
                                url: url,
                                tittle: tittle,
                                date: date,
                                description: description,
                                technology: technologies,
                                display: true,
                              );

                              chatlist.add(portfoliocard);
                            }
                          }

                          return Container(
                            // width: 100,
                            height: 350,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // reverse: true,
                              children: chatlist,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),

                //  Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Text("widget.foodName",
                //         style: TextStyle(
                //             fontFamily: 'Montserrat',
                //             fontSize: 22.0,
                //             fontWeight: FontWeight.bold)),
                //     SizedBox(height: 20.0),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Text("widget.foodPrice",
                //             style: TextStyle(
                //                 fontFamily: 'Montserrat',
                //                 fontSize: 20.0,
                //                 color: Colors.grey)),
                //         Container(
                //             height: 25.0, color: Colors.grey, width: 1.0),
                //         Container(
                //           width: 125.0,
                //           height: 40.0,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(17.0),
                //               color: Color(0xFF7A9BEE)),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: <Widget>[
                //               InkWell(
                //                 onTap: () {},
                //                 child: Container(
                //                   height: 25.0,
                //                   width: 25.0,
                //                   decoration: BoxDecoration(
                //                       borderRadius:
                //                           BorderRadius.circular(7.0),
                //                       color: Color(0xFF7A9BEE)),
                //                   child: Center(
                //                     child: Icon(
                //                       Icons.remove,
                //                       color: Colors.white,
                //                       size: 20.0,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Text('2',
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontFamily: 'Montserrat',
                //                       fontSize: 15.0)),
                //               InkWell(
                //                 onTap: () {},
                //                 child: Container(
                //                   height: 25.0,
                //                   width: 25.0,
                //                   decoration: BoxDecoration(
                //                       borderRadius:
                //                           BorderRadius.circular(7.0),
                //                       color: Colors.white),
                //                   child: Center(
                //                     child: Icon(
                //                       Icons.add,
                //                       color: Color(0xFF7A9BEE),
                //                       size: 20.0,
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //     SizedBox(height: 20.0),
                //     Container(
                //         height: 150.0,
                //         child: ListView(
                //           scrollDirection: Axis.horizontal,
                //           children: <Widget>[
                //             _buildInfoCard('WEIGHT', '300', 'G'),
                //             SizedBox(width: 10.0),
                //             _buildInfoCard('CALORIES', '267', 'CAL'),
                //             SizedBox(width: 10.0),
                //             _buildInfoCard('VITAMINS', 'A, B6', 'VIT'),
                //             SizedBox(width: 10.0),
                //             _buildInfoCard('AVAIL', 'NO', 'AV')
                //           ],
                //         )),
                //     SizedBox(height: 20.0),
                //     Padding(
                //       padding: EdgeInsets.only(bottom: 5.0),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(10.0),
                //                 topRight: Radius.circular(10.0),
                //                 bottomLeft: Radius.circular(25.0),
                //                 bottomRight: Radius.circular(25.0)),
                //             color: Colors.black),
                //         height: 50.0,
                //         child: Center(
                //           child: Text('\$52.00',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontFamily: 'Montserrat')),
                //         ),
                //       ),
                //     )
                //   ],
                // )
              )
            ])
          ])),
    );
  }
}
