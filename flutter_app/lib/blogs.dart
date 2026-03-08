import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.sizeOf(context);

    double desiredButtonWidth = 1000;
    double buttonPadding = (screenSize.width > desiredButtonWidth)
        ? (screenSize.width - desiredButtonWidth) / 2
        : 0;

    Widget buildBlogOption(String linkText, String url) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: colors.secondary,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 450, 0),
                    child: RichText(
                      text: TextSpan(
                        style:
                            TextStyle(color: colors.onPrimary, fontSize: 16.0),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1',
                            style: TextStyle(
                              fontSize: 40,
                              color: colors.onSecondary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchUrl(
                                    'https://flutter.dev'); // Call the launch function
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 450, 0),
                    child: RichText(
                      text: TextSpan(
                        style:
                            TextStyle(color: colors.onPrimary, fontSize: 16.0),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'website',
                            style: TextStyle(
                              fontSize: 40,
                              color: colors.onPrimary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchUrl(
                                    'https://flutter.dev'); // Call the launch function
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: colors.primary,
      child: ListView(
        children: [
          buildBlogOption("Le Vie de ma Site ", "www.youtube.com"),
        ],
      ),
    );
  }
}
