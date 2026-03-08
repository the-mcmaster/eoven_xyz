import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.primary,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              textEntry(colors, "The Whole Point", fontSize: 32, fontWeight: FontWeight.bold),
              textEntry(colors, "The simple pleasures in my life are learning, building, and explaining.", fontStyle: FontStyle.italic, withPadding: EdgeInsets.fromLTRB(200, 8, 200, 8)),
            ],
          )),
    );
  }
}
