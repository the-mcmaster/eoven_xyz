import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    Widget buildBlogOption(String linkText, String url) {
      return RichText(text: TextSpan(text: linkText, recognizer: TapGestureRecognizer()..onTap = () {
        attemptUrlLaunch(url);
      }));
    }

    return Container(
      color: colors.primary,
      child: ListView(
        children: [
          buildBlogOption("Le Vie de ma Site ", "https://www.youtube.com"),
        ],
      ),
    );
  }
}
