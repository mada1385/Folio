import 'dart:ffi';
import 'dart:math';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:folio/components/Roundbutton.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/user.dart';
import 'package:folio/screens/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Regstration extends StatefulWidget {
  @override
  _RegstrationState createState() => _RegstrationState();
}

class _RegstrationState extends State<Regstration> {
  final name = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      jobtittle = TextEditingController(),
      confirmpassword = TextEditingController();
  Uri url, urls;

  bool vname = false,
      vemail = false,
      vpassword = false,
      vjobtittle = false,
      vconfirmpassword = false,
      opassword = true,
      ocpassword = true;
  String ename = null,
      eemail = null,
      epassword = null,
      ejobtittle = null,
      econfirmpassword = null;
  String errortext;

  Future<Void> createlink(String email) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://folio2.page.link',
      link: Uri.parse('https://www.compound.com/post?title=$email'),
      androidParameters: AndroidParameters(
        packageName: 'com.mada.folio',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    setState(() {
      urls = shortLink.shortUrl;
    });

    // } else {
    url = await parameters.buildUrl();
    // if (short) {

    print(urls.toString());
    print(url.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: k_gradient),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  Tiltle(),
                  // Padding(
                  //     padding: EdgeInsets.only(right: 90, left: 78), child: k_title),
                  Maintextfield(
                    hint: "username",
                    controller: name,
                    validate: vname,
                    error: ename,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Maintextfield(
                    hint: "mail",
                    controller: email,
                    validate: vemail,
                    error: eemail,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Maintextfield(
                    hint: "jobtittle",
                    controller: jobtittle,
                    validate: vjobtittle,
                    error: ejobtittle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Maintextfield(
                    hint: "password",
                    controller: password,
                    validate: vpassword,
                    obsucure: opassword,
                    error: epassword,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Maintextfield(
                    hint: "confirmpassword",
                    controller: confirmpassword,
                    validate: vconfirmpassword,
                    obsucure: ocpassword,
                    error: econfirmpassword,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Roundbutton(
                      label: "signup",
                      func: () async {
                        setState(() {
                          name.text.isEmpty ? vname = true : vname = false;

                          email.text.isEmpty ? vemail = true : vemail = false;

                          password.text.isEmpty
                              ? vpassword = true
                              : vpassword = false;

                          jobtittle.text.isEmpty
                              ? vjobtittle = true
                              : vjobtittle = false;

                          password.text.isEmpty
                              ? vpassword = true
                              : vpassword = false;

                          confirmpassword.text.isEmpty
                              ? vconfirmpassword = true
                              : vconfirmpassword = false;
                        });
                        if (!name.text.isEmpty &&
                            !email.text.isEmpty &&
                            !jobtittle.text.isEmpty &&
                            !password.text.isEmpty &&
                            !confirmpassword.text.isEmpty) {
                          if (EmailValidator.validate(email.text)) {
                            if (password.text == confirmpassword.text) {
                              await createlink(email.text);
                              print(url);
                              User newuser = User(
                                  email: email.text,
                                  jobtitle: jobtittle.text,
                                  name: name.text,
                                  password: password.text);

                              final logged = await newuser.register(urls);
                              if (logged != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Loginpage()));
                              }
                            }
                          }
                        }
                        if (password.text != confirmpassword.text) {
                          vconfirmpassword = true;
                          econfirmpassword = "password is not matching";
                          print(econfirmpassword);
                        }
                        if (!EmailValidator.validate(email.text)) {
                          vemail = true;
                          eemail = "email is not valid";
                        }
                      }

                      // () async {

                      // }
                      ),

                  // newuser.database();

                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
