import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/screens/login.dart';
import 'package:folio/screens/nointernetscreen.dart';
import 'package:folio/screens/portfoliossceen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences p = await SharedPreferences.getInstance();
  String x = p.get("email");
  return runApp(ChangeNotifierProvider(
    create: (context) => Userprovider(),
    child: ConnectivityAppWrapper(
      app: MaterialApp(
        home: x == null
            ? Loginpage()
            : DetailsPage(
                useremail: x,
              ),
      ),
    ),
  )
      // Nointernetscreen()
      );
}
