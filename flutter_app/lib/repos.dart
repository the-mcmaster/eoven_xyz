import 'package:flutter/material.dart';
import 'package:flutter_app/lib.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({required this.url, super.key});

  final String url;
  
  @override
  State<ReposPage> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  @override
  Widget build(BuildContext context) {
    attemptUrlLaunch(widget.url);

    Navigator.pushReplacementNamed(context, '/');
    
    return const Placeholder();
  }
}