import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:hugeicons/hugeicons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget _buildAction(
    String description, Widget icon, void Function() onPressed) {
  return Row(
    children: [
      Card(
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
      Text(description),
    ],
  );
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> actions = [
    _buildAction("About", HugeIcon(icon: HugeIcons.strokeRoundedShareKnowledge),
        () => print("action 1 selected: about")),
    _buildAction("Blog Posts", HugeIcon(icon: HugeIcons.strokeRoundedBooks02),
        () => print("action 1 selected: blogs")),
    _buildAction("Repos", HugeIcon(icon: HugeIcons.strokeRoundedGithub01),
        () => print("action 1 selected: github")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => print("the leading button was pressed"),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions,
        ),
      ),
      body: const MarkdownBody(
        selectable: true,
        data:
            "# Hello there! I am markdown in Flutter. \n\n I am a seperate line.",
      ),
    );
  }
}
