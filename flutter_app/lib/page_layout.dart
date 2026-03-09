import 'package:flutter/material.dart';
import 'package:flutter_app/404.dart';
import 'package:flutter_app/blogs.dart';
import 'package:flutter_app/linkedin_page.dart';
import 'package:flutter_app/main.dart';
import 'package:hugeicons/hugeicons.dart';

class AppBarButtonCenters {
  final double linkedin;
  final double blogs;
  final double repos;

  const AppBarButtonCenters({
    required this.linkedin,
    required this.blogs,
    required this.repos,
  });
}

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
  final ValueChanged<AppBarButtonCenters>? onAppBarCentersUpdated;

  PageLayout({
    super.key,
    required this.body,
    required this.onToggleTheme,
    required this.themeMode,
    this.onAppBarCentersUpdated,
  });

  final GlobalKey _linkedinKey = GlobalKey();
  final GlobalKey _blogsKey = GlobalKey();
  final GlobalKey _reposKey = GlobalKey();

  void _notifyButtonCenters() {
    if (onAppBarCentersUpdated == null) return;

    final linkedinBox =
        _linkedinKey.currentContext?.findRenderObject() as RenderBox?;
    final blogsBox =
        _blogsKey.currentContext?.findRenderObject() as RenderBox?;
    final reposBox =
        _reposKey.currentContext?.findRenderObject() as RenderBox?;

    if (linkedinBox == null || blogsBox == null || reposBox == null) {
      return;
    }

    final linkedinOffset = linkedinBox.localToGlobal(Offset.zero);
    final blogsOffset = blogsBox.localToGlobal(Offset.zero);
    final reposOffset = reposBox.localToGlobal(Offset.zero);

    final centers = AppBarButtonCenters(
      linkedin: linkedinOffset.dx + linkedinBox.size.width / 2,
      blogs: blogsOffset.dx + blogsBox.size.width / 2,
      repos: reposOffset.dx + reposBox.size.width / 2,
    );

    onAppBarCentersUpdated!(centers);
  }

  @override
  Widget build(BuildContext context) {
    // Now 'context' is UNDER MaterialApp, so Theme.of and Navigator will work!
    ColorScheme colors = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyButtonCenters();
    });

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
              "Repos",
              HugeIcon(icon: HugeIcons.strokeRoundedGithub01),
              () => Navigator.pushReplacementNamed(context, '/repos',
                  result: MyCustomRoute(builder: (context) => Error404())),
              key: _reposKey,
            ),
            buildAppBarOptions(
              context,
              "Blog Posts",
              HugeIcon(icon: HugeIcons.strokeRoundedBooks02),
              () => Navigator.pushReplacementNamed(context, '/blogs',
                  result: MyCustomRoute(builder: (context) => BlogsPage())),
              key: _blogsKey,
            ),
            buildAppBarOptions(
              context,
              "Linkedin",
              HugeIcon(icon: HugeIcons.strokeRoundedShareKnowledge),
              () => Navigator.pushReplacementNamed(context, '/linkedin',
                  result: MyCustomRoute(builder: (context) => LinkedinPage(url: "https://www.linkedin.com/in/eric-ovenden"))),
              key: _linkedinKey,
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
