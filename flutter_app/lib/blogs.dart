import 'package:flutter/material.dart';
import 'package:flutter_app/lib.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({required this.url, super.key});
  final String url;

  @override
  State<BlogsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    attemptUrlLaunch(widget.url);

    Navigator.pushReplacementNamed(context, "/");

    return Placeholder();
  }
}
