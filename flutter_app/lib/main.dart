import 'package:flutter/material.dart';
import 'package:flutter_app/404.dart';
import 'package:flutter_app/linkedin_page.dart';
import 'package:flutter_app/blogs.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/page_layout.dart';
import 'package:flutter_app/repos.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

Future<void> attemptUrlLaunch(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

Padding textEntry(
  ColorScheme colors,
  String data, {
  double fontSize = 20,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  EdgeInsets withPadding = const EdgeInsets.all(0),
}) {
  return Padding(
    padding: withPadding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            data,
            style: TextStyle(
              fontSize: fontSize,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              color: colors.onPrimary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAppBarOptions(
  BuildContext context,
  String description,
  Widget icon,
  void Function() onPressed, {
  Key? key,
}) {
  ColorScheme colors = Theme.of(context).colorScheme;

  return IconButton(
    key: key,
    color: colors.onPrimary,
    hoverColor: colors.tertiary,
    onPressed: onPressed,
    icon: Row(
      children: [
        icon,
        if (MediaQuery.sizeOf(context).width > 600)
          Text(
            description,
            style: TextStyle(
              color: colors.onPrimary,
            ),
          ),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 1. The state that controls the theme
  ThemeMode _themeMode = ThemeMode.dark;
  final ValueNotifier<AppBarButtonCenters?> _appBarCenters =
      ValueNotifier<AppBarButtonCenters?>(null);

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void dispose() {
    _appBarCenters.dispose();
    super.dispose();
  }

  PageLayout _buildPage(Widget body) {
    return PageLayout(
      body: body,
      onToggleTheme: _toggleTheme,
      themeMode: _themeMode,
      onAppBarCentersUpdated: (centers) {
        _appBarCenters.value = centers;
      },
    );
  }

  PageRouteBuilder buildRoute(
    BuildContext context,
    RouteSettings settings,
    Widget body, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => _buildPage(body),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: duration,
    );
  }

  ThemeData defaultTheme({required ThemeMode withMode}) {
    ThemeData light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      colorScheme: const ColorScheme.light(
        surface: Colors.white,
        onSurface: Colors.black,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Color(0xFF444444),
        onSecondary: Color(0xFFDDDDDD),
        tertiary: Color.fromARGB(255, 194, 130, 26),
        onTertiary: Color(0xFF111111),
      ),
    );

    ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
        onSurface: Colors.white,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Color(0xFFBBBBBB),
        onSecondary: Color(0xFFDDDDDD),
        tertiary: Color.fromARGB(255, 26, 177, 194),
        onTertiary: Color(0xFFEEEEEE),
      ),
    );

    return withMode == ThemeMode.light ? light : dark;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme(withMode: _themeMode),
      darkTheme: defaultTheme(withMode: ThemeMode.dark),
      themeMode: _themeMode,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return buildRoute(
            context,
            settings,
            HomePage(appBarCentersListenable: _appBarCenters),
          );
        }

        if (settings.name == '/linkedin') {
          return buildRoute(
            context,
            settings,
            LinkedinPage(url: "https://www.linkedin.com/in/eric-ovenden"),
          );
        }

        if (settings.name == '/blogs') {
          return buildRoute(
            context,
            settings,
            BlogsPage(),
          );
        }

        if (settings.name == '/repos') {
          return buildRoute(
            context,
            settings,
            ReposPage(url: "https://github.com/the-mcmaster"),
          );
        }

        return buildRoute(
          context,
          settings,
          Error404(),
        );
      },
    );
  }
}
