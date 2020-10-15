import 'package:flutter/material.dart';
import 'package:folio/constants/colors.dart';

const k_title = Padding(
    padding: EdgeInsets.only(left: 10),
    child: const Text(
      'Folio',
      style: logoWhiteStyle,
    ));

class Goldtext extends StatelessWidget {
  final String string;
  final FontWeight fontWeight;
  final double fontsize;

  const Goldtext({@required this.string, this.fontsize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          string,
          style: TextStyle(
              color: k_primarycolor,
              fontWeight: fontsize == null ? FontWeight.w100 : fontWeight,
              fontSize: fontsize == null ? 35 : fontsize),
        ));
  }
}
