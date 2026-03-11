import 'package:flutter/material.dart';
import 'package:flutter_app/lib.dart';

class LinkedinPage extends StatefulWidget {
  const LinkedinPage({required this.url, super.key});
  final String url;

  @override
  State<LinkedinPage> createState() => _LinkedinPageState();
}

class _LinkedinPageState extends State<LinkedinPage> {
  @override
  Widget build(BuildContext context) {
    attemptUrlLaunch(widget.url);

    Navigator.pushReplacementNamed(context, '/');

    return Placeholder();
  }
}
