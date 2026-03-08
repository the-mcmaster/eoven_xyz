import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EdgeInsets _paragraphPad(double width) {
    return EdgeInsets.fromLTRB(width, 50, width, 0);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.sizeOf(context);

    const double desiredHomeWidth = 900;
    const double desiredParagraphPadding = 50;
    double minHomeWidth = (screenSize.width > desiredHomeWidth)
        ? screenSize.width
        : desiredHomeWidth;
    double paragraphPadding = (screenSize.width - desiredHomeWidth >
            2 * desiredParagraphPadding)
        ? (screenSize.width - desiredHomeWidth - 2 * desiredParagraphPadding) /
            2
        : (screenSize.width - desiredHomeWidth > 0)
            ? screenSize.width - desiredHomeWidth
            : 0;

    Widget paragraphEntry(String data) {
      return textEntry(
        colors,
        data,
        withPadding: _paragraphPad(paragraphPadding),
      );
    }

    return Container(
      color: colors.primary,
      width: minHomeWidth,
      child: Column(
        children: [
          textEntry(
            colors,
            "Eric Ovenden",
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          paragraphEntry(
            "A page dedicated to displaying interests, hobbies, and skills. This website showcases my blog posts, software projects, and some external links.",
          ),
          paragraphEntry(
            "The button icons at the top of the screen can navigate to my other pages.",
          ),
          textEntry(
            colors,
            "This website is still very much under construction.",
            fontStyle: FontStyle.italic,
            withPadding: _paragraphPad(paragraphPadding),
          ),
        ],
      ),
    );
  }
}
