import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/foliocard.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/profilecard.dart';
import 'package:folio/screens/addportfolio.dart';
import 'package:folio/screens/login.dart';
import 'package:folio/screens/nointernetscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'folio.dart';

class DetailsPage extends StatefulWidget {
  final String useremail;
  final GlobalKey<ScaffoldState> globalKey;

  DetailsPage({Key key, this.useremail, this.globalKey}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';
  final _store = Firestore.instance;
  String name = " ";
  String job = "";
  String sharelink;
  String photourl;
  String id;
  File _image;
  CollectionReference userref = Firestore.instance.collection("user");
  final picref = FirebaseStorage().ref().child("Images").child("image.jpg");
  bool isconnescted = true;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    getuser();
    getid();

    setemail();
  }

  void setemail() {
    Provider.of<Userprovider>(context, listen: false)
        .setemail(widget.useremail);
  }

  void updateuserphoto() {
    if (_image != null) {
      picref.putFile(_image).onComplete.then((data) {
        data.ref.getDownloadURL().then((url) {
          userref.document(id).updateData({
            "photo": url,
          });
        }).catchError((err) {});
      }).catchError((err) {});
    }
  }

  Future<void> getid() async {
    var messges = await _store
        .collection("user")
        .where('email', isEqualTo: widget.useremail)
        .getDocuments();
    for (var massege in messges.documents) {
      setState(() {
        id = massege.documentID;
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    updateuserphoto();
  }

  share(BuildContext context, String link) {
    final RenderBox box = context.findRenderObject();

    Share.share(link,
        subject: "check my folio",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print(deepLink.queryParameters["title"]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Folioscreen(
                      useremail: deepLink.queryParameters["title"],
                    )));
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("xyy" + deepLink.path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Folioscreen(
                    useremail: "deepLink.path" + "@gmail.com",
                  )));
    }
  }

  void getuser() async {
    try {
      String username;
      var messges = await _store
          .collection("user")
          .where('email', isEqualTo: widget.useremail)
          .getDocuments();
      for (var massege in messges.documents) {
        setState(() {
          name = massege.data["full_name"];
          job = massege.data["jobtitle"];
          photourl = massege.data["photo"];
        });
      }
    } catch (e) {
      print(e);
    }

    // return username;
  }

  void setphoto(String userid) async {
    try {
      Firestore.instance
          .collection("user")
          .document(userid)
          .updateData({"photo": "photo"});
    } catch (e) {
      print(e);
    }

    // return username;
  }

  Future<void> getlink() async {
    var messges = await _store
        .collection("user")
        .where('email', isEqualTo: widget.useremail)
        .getDocuments();
    for (var massege in messges.documents) {
      setState(() {
        sharelink = massege.data["url"];
      });
    }
    // return username;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: k_gradientfolio),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: Colors.white,
            // ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Tiltle(),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  await getlink();
                  share(context, sharelink);
                },
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  final x = auth.signOut();
                  if (x != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Loginpage()));
                    SharedPreferences x = await SharedPreferences.getInstance();
                    x.remove("email");
                  }
                },
                color: Colors.white,
              )
            ],
          ),
          body: ConnectivityWidgetWrapper(
            // disableInteraction: true,
            // offlineWidget: Nointernetscreen(),
            child: ListView(children: [
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
                      Row(
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: k_backgroundcolor,
                          maxRadius: 100,
                          backgroundImage: _image != null
                              ? FileImage(_image)
                              : photourl != null
                                  ? NetworkImage(photourl)
                                  : AssetImage(
                                      "asset/nopic.jpg",
                                    )),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                size: 30.0,
                                color: k_backgroundcolor,
                              ),
                              onPressed: () async {
                                await getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 250.0,
                  left: 25.0,
                  right: 25.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Updatedinfocard(
                        data: name,
                        hint: "update name",
                        collection: "user",
                        label: "full_name",
                        id: id,
                      ),
                      Updatedinfocard(
                        data: job,
                        hint: "update name",
                        collection: "user",
                        label: "jobtitle",
                        id: id,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     // color: k_backgroundcolor,
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     border: Border.all(color: k_backgroundcolor),
                      //   ),
                      //   child: Center(
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 100, vertical: 15),
                      //       child: Text(name),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     // color: k_backgroundcolor,
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     border: Border.all(color: k_backgroundcolor),
                      //   ),
                      //   child: Center(
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 100, vertical: 15),
                      //       child: Text(job),
                      //     ),
                      //   ),
                      // ),
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
                                final description =
                                    portfolio.data["description"];
                                final date = portfolio.data["date"];
                                final technologies =
                                    portfolio.data["technologies"];
                                final email = portfolio.data["email"];
                                final url = portfolio.data["urls"];
                                final id = portfolio.documentID;

                                // final alignment = messagesender == loggedInUser.email ?  TextAlign.end :  TextAlign.start  ;
                                final portfoliocard = Foliocard(
                                  url: url,
                                  tittle: tittle,
                                  date: date,
                                  description: description,
                                  technology: technologies,
                                  id: id,
                                );

                                chatlist.add(portfoliocard);
                              }
                              final addnew = Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Container(
                                  // color: k_backgroundcolor,
                                  // elevation: 20,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: k_backgroundcolor,
                                          size: 70,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Addportoflioscreen()));
                                        }),
                                  ),
                                ),
                              );
                              chatlist.add(addnew);
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
                )
              ]),
            ]),
          )),
    );
  }

//   Widget _buildInfoCard(String cardTitle, String info, String unit) {
//     return InkWell(
//         onTap: () {
//           selectCard(cardTitle);
//         },
//         child: AnimatedContainer(
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeIn,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color:
//                   cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
//               border: Border.all(
//                   color: cardTitle == selectedCard
//                       ? Colors.transparent
//                       : Colors.grey.withOpacity(0.3),
//                   style: BorderStyle.solid,
//                   width: 0.75),
//             ),
//             height: 100.0,
//             width: 100.0,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 15.0),
//                     child: Text(cardTitle,
//                         style: TextStyle(
//                           fontFamily: 'Montserrat',
//                           fontSize: 12.0,
//                           color: cardTitle == selectedCard
//                               ? Colors.white
//                               : Colors.grey.withOpacity(0.7),
//                         )),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(info,
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontSize: 14.0,
//                                 color: cardTitle == selectedCard
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontWeight: FontWeight.bold)),
//                         Text(unit,
//                             style: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontSize: 12.0,
//                               color: cardTitle == selectedCard
//                                   ? Colors.white
//                                   : Colors.black,
//                             ))
//                       ],
//                     ),
//                   )
//                 ])));
//   }

//   selectCard(cardTitle) {
//     setState(() {
//       selectedCard = cardTitle;
//     });
//   }
// }
}
