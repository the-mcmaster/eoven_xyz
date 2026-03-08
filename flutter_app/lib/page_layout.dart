import 'package:flutter/material.dart';
import 'package:flutter_app/404.dart';
import 'package:flutter_app/about.dart';
import 'package:flutter_app/blogs.dart';
import 'package:flutter_app/main.dart';
import 'package:hugeicons/hugeicons.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class PageLayout extends StatelessWidget {
  final Widget body;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const PageLayout(
      {super.key,
      required this.body,
      required this.onToggleTheme,
      required this.themeMode});

  @override
  Widget build(BuildContext context) {
    // Now 'context' is UNDER MaterialApp, so Theme.of and Navigator will work!
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.secondary,
        leading: IconButton(
          color: colors.onPrimary,
          hoverColor: colors.tertiary,
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildAppBarOptions(
              context,
              "About",
              HugeIcon(icon: HugeIcons.strokeRoundedShareKnowledge),
              () => Navigator.pushReplacementNamed(context, '/about',
                  result: MyCustomRoute(builder: (context) => AboutPage())),
            ),
            buildAppBarOptions(
              context,
              "Blog Posts",
              HugeIcon(icon: HugeIcons.strokeRoundedBooks02),
              () => Navigator.pushReplacementNamed(context, '/blogs',
                  result: MyCustomRoute(builder: (context) => BlogsPage())),
            ),
            buildAppBarOptions(
              context,
              "Repos",
              HugeIcon(icon: HugeIcons.strokeRoundedGithub01),
              () => Navigator.pushReplacementNamed(context, '/repos',
                  result: MyCustomRoute(builder: (context) => Error404())),
            ),
          ],
        ),
        actions: [
          buildAppBarOptions(
            context,
            "Theme",
            HugeIcon(
              icon: colors.brightness == Brightness.light
                  ? HugeIcons.strokeRoundedSunset
                  : HugeIcons.strokeRoundedSunrise,
            ),
            onToggleTheme,
          )
        ],
      ),
      body: body,
    );
  }
}
