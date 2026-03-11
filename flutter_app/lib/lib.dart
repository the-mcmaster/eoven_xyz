import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> attemptUrlLaunch(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

Widget paragraph(
  ColorScheme colors,
  String data, {
  int indent = 0,
  double fontSize = 20,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  MainAxisAlignment alignment = MainAxisAlignment.start,
  TextAlign textAlign = TextAlign.center,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
    child: Row(
      mainAxisAlignment: alignment,
      children: [
        Flexible(
          child: Text(
            " " * indent + data,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: fontSize,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              color: colors.onPrimary,
            ),
          ),
        ),
      ],
    ),
  );
}