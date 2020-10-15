import 'dart:io';
import 'package:flutter/material.dart';
import 'package:folio/screens/nointernetscreen.dart';

class Userprovider extends ChangeNotifier {
  String _email, _uid;
  void setemail(String useremail) {
    _email = useremail;
  }

  void setuid(String userid) {
    _uid = userid;
  }

  String get email {
    return _email;
  }

  String get id {
    return _uid;
  }

  Future<bool> connection() async {
    bool isconnescted;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isconnescted = true;
      }
    } on SocketException catch (_) {
      isconnescted = false;
    }
    return isconnescted;
  }

  void customnavigator(
      Widget screen, BuildContext context, bool repalce) async {
    final x = await connection();
    if (repalce) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => x == false ? Nointernetscreen() : screen));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => x == false ? Nointernetscreen() : screen));
    }
  }

  void noconnection(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Nointernetscreen()));
  }
}
