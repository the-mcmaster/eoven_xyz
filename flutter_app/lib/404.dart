import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

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
            textEntry(colors, "404", fontSize: 40, fontWeight: FontWeight.bold),
            textEntry(
              colors,
              "You have accessed an unused, inaccessible, or incorrect webpage.",
              fontStyle: FontStyle.italic,
              withPadding: EdgeInsets.fromLTRB(horizontal, 50, horizontal, 8),
            )
          ],
        ),
      ),
    );
  }
}
