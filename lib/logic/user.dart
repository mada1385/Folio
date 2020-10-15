// import 'dart:html';

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class User {
  String useremail;
  User({
    this.name,
    this.jobtitle,
    this.email,
    this.password,
  });

  final String name;
  final String email;
  String id;
  final String jobtitle;
  final String password;
  // final File photo ;
  CollectionReference users = Firestore.instance.collection('user');

  Future<void> addUser(Uri url) {
    print("adduser" + url.toString());

    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': name, // John Doe
          'email': email, // Stokes and Sons
          'jobtitle': jobtitle, // 42
          'email': email,
          "url": url.toString(),
          "photo": null
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  FirebaseUser currentUser;

  // void loadCurrentUser() {
  //   FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
  //     // call setState to rebuild the view
  //     this.currentUser = user;
  //   });
  // }

  // String getemail() {
  //   loadCurrentUser();
  //   if (currentUser != null) {
  //     return currentUser.email;
  //   } else {
  //     return "no current user";
  //   }
  // }

  Future login() async {
    String user;
    try {
      final signup = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        user = email;
        print("sucsses");
      });

      if (signup != null) {
        user = email;
        // print(user);
      }
    } catch (e) {
      // user = "failed";
      return e;
    }
    return user;
  }

  Future<Void> createDynamicLink(bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://folio2.page.link',
      link: Uri.parse('https://dynamic.link.example/$email'),
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

    Uri url, urls;
    // if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    urls = shortLink.shortUrl;
    // } else {
    url = await parameters.buildUrl();
    print(urls.toString());
    print(url.toString());
  }

  Future register(Uri x) async {
    String user = "sucsses";

    try {
      final signup = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (signup != null) {
        useremail = email;
        print("register" + x.toString());
        addUser(x);
      }
    } catch (e) {
      print(e);
      return e;
    }
    return user;
  }
}
