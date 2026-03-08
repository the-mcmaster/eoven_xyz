import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    const double sideMargins = 16;

    return Container(
      color: colors.primary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(sideMargins, 10, sideMargins, 10),
        child: Column(
          children: [
            textEntry(colors, "Eric Ovenden",
                fontSize: 40, fontWeight: FontWeight.bold),
            textEntry(
              colors,
              "A page dedicated to displaying interests, hobbies, and skills.",
              withPadding: EdgeInsets.fromLTRB(200, 50, 200, 8),
            ),
            textEntry(
              colors,
              "This website is still under construction",
              fontStyle: FontStyle.italic,
              withPadding: EdgeInsets.fromLTRB(200, 8, 200, 8),
            ),
          ],
        ),
      ),
    );
  }
}
