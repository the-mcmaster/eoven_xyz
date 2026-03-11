import 'package:flutter/material.dart';
import 'package:flutter_app/lib.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    const double horizontal = 12;

    return Container(
      color: colors.primary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(horizontal, 50, horizontal, 10),
        child: Column(
          children: [
            paragraph(colors, "404", fontSize: 40, fontWeight: FontWeight.bold, alignment: MainAxisAlignment.center,),
            paragraph(
              colors,
              "You have accessed an unused, inaccessible, or incorrect webpage.",
              fontStyle: FontStyle.italic,
              alignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
