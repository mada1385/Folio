import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/Roundbutton.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/logic/user.dart';
import 'package:folio/screens/folio.dart';
import 'package:folio/screens/nointernetscreen.dart';
import 'package:folio/screens/regestraiton.dart';
import 'package:folio/screens/portfoliossceen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final email = TextEditingController();
  bool emailvalidate = false;
  final password = TextEditingController();
  bool passwordvalidate = false, isconnescted = true;
  String eemail = null, epassword = null;
  String hint = "email";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connection();
    initDynamicLinks();
  }

  // void connection() async {
  //   isconnescted = await Provider.of<Userprovider>(context).connection();
  // }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print("deep link" + deepLink.path);
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

  @override
  Widget build(BuildContext context) {
    return
        // isconnescted == false
        //     ? Nointernetscreen(
        //         screen: Loginpage(),
        //       )
        //     :
        Scaffold(
      resizeToAvoidBottomInset: false,
      body: ConnectivityWidgetWrapper(
        // offlineWidget: Nointernetscreen(),
        // disableInteraction: true,
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(gradient: k_gradient),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 250,
                  ),
                ),
                Tiltle(),
                Maintextfield(
                  controller: email,
                  validate: emailvalidate,
                  hint: "emial",
                  error: eemail,
                ),
                Maintextfield(
                  controller: password,
                  validate: passwordvalidate,
                  hint: "password",
                  obsucure: true,
                  error: epassword,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 75),
                        child: GestureDetector(
                            child: Text(
                          "forgot password ?",
                          style: TextStyle(color: k_primarycolor),
                        )))
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Roundbutton(
                  func: () async {
                    setState(() {
                      email.text.isEmpty
                          ? emailvalidate = true
                          : emailvalidate = false;
                      password.text.isEmpty
                          ? passwordvalidate = true
                          : passwordvalidate = false;
                    });

                    if (!email.text.isEmpty && !password.text.isEmpty) {
                      if (EmailValidator.validate(email.text)) {
                        final loginuser =
                            User(email: email.text, password: password.text);
                        final loggeduser = await loginuser.login();
                        if (loggeduser != null) {
                          // if (loggeduser == "success") {
                          print(loggeduser);
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString("email", loggeduser);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        useremail: loggeduser,
                                      )));
                          Provider.of<Userprovider>(context, listen: false)
                              .setemail(email.text);
                          // }
                          // else {
                          //   Scaffold.of(context).showSnackBar(SnackBar(
                          //     content: Text(loggeduser.toString()),
                          //   ));
                          // }
                        }
                      }
                    }
                    if (!EmailValidator.validate(email.text)) {
                      emailvalidate = true;
                      eemail = "email is not valid";
                    }
                  },
                  label: "login",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        "__________ or sign in with__________",
                        style: TextStyle(color: k_primarycolor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // SizedBox(width: 100,),
                          GestureDetector(
                            child:
                                Image.asset("asset/facebook.png", height: 30),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            child: Image.asset("asset/google3.png", height: 25),
                          ),
                        ],
                      ),
                      //  Signin(label: "facebook",logo: Image.asset("asset/5943.png",height: 30 ,), ),
                      //  SizedBox(height: 7.5,),
                      //  Signin(label: "Google",logo: Image.asset("asset/google.png",height: 30 ,),),
                      // SignInButton(
                      //   Buttons.Facebook,
                      //   text: "facebook",
                      //   onPressed: () {},
                      // ),
                      // SignInButton(
                      //   Buttons.Google,
                      //   text: "Google",
                      //   onPressed: () {},
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "dont have account?",
                            style: TextStyle(color: k_primarycolor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Regstration()));
                            },
                            child: Text(
                              "sign up now",
                              style: TextStyle(
                                  color: k_primarycolor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      )
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Signin extends StatelessWidget {
//   final Image logo;
//   final String label;
//   final Function func;
//   Signin({this.label, this.logo, this.func});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: func,
//       child: Container(
//         color: Colors.white,
//         constraints: BoxConstraints(
//           maxWidth: 220,
//           maxHeight: 36.0,
//         ),
//         child: Center(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 13,
//                 ),
//                 child: logo,
//               ),
//               Text(
//                 label,
//                 // "facebook",
//                 style: TextStyle(
//                   fontFamily: 'Roboto',
//                   color: k_primarycolor,
//                   fontSize: 12,
//                   backgroundColor: Color.fromRGBO(0, 0, 0, 0),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
