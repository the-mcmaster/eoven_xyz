import 'package:flutter/material.dart';
import 'package:flutter_app/lib.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    attemptUrlLaunch("blogs.e-oven.xyz");

    Navigator.pushReplacementNamed(context, "/");

    return Placeholder();
  }
}
