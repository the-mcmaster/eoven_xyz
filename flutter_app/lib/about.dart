import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Here is the AppBar'),
        leading: IconButton(
          onPressed: () => print("the leading button was pressed"),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
        ),
        actions: [
          IconButton(
            onPressed: () => print("action 1 selected: about"),
            icon: HugeIcon(icon: HugeIcons.strokeRoundedShareKnowledge),
          ),
          IconButton(
            onPressed: () => print("action 2 selected: blogs"),
            icon: HugeIcon(icon: HugeIcons.strokeRoundedBooks02),
          ),
          IconButton(
            onPressed: () => print("action 3 selected: github"),
            icon: HugeIcon(icon: HugeIcons.strokeRoundedGithub01),
          )
        ],
      ),
      body: const MarkdownBody(
        selectable: true,
        data:
            "# Hello there! I am markdown in Flutter. \n\n I am a seperate line.",
      ),
    );
  }
}
