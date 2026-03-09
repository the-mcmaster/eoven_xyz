import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/page_layout.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  final ValueListenable<AppBarButtonCenters?> appBarCentersListenable;

  const HomePage({
    super.key,
    required this.appBarCentersListenable,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _topBarKey = GlobalKey();
  double? _topBarGlobalLeft;

  void _measureTopBar() {
    final box = _topBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) {
      return;
    }

    final offset = box.localToGlobal(Offset.zero);
    if (_topBarGlobalLeft != offset.dx) {
      setState(() {
        _topBarGlobalLeft = offset.dx;
      });
    }
  }

  EdgeInsets _paragraphPad(double width) {
    return EdgeInsets.fromLTRB(width, 50, width, 0);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.sizeOf(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureTopBar();
    });

    const double desiredHomeWidth = 900;
    const double desiredParagraphPadding = 50;
    double minHomeWidth = (screenSize.width > desiredHomeWidth)
        ? screenSize.width
        : desiredHomeWidth;
    double paragraphPadding = (screenSize.width - desiredHomeWidth >
            2 * desiredParagraphPadding)
        ? (screenSize.width - desiredHomeWidth - 2 * desiredParagraphPadding) /
            2
        : (screenSize.width - desiredHomeWidth > 0)
            ? screenSize.width - desiredHomeWidth
            : 0;

    Widget paragraphEntry(String data) {
      return textEntry(
        colors,
        data,
        withPadding: _paragraphPad(paragraphPadding),
      );
    }

    const double topBarHeight = 72;
    const double iconSize = 32;

    Widget buildTopBar(AppBarButtonCenters? centers) {
      // Fallback: simple evenly spaced row if we don't have measurements yet.
      if (centers == null || _topBarGlobalLeft == null) {
        return SizedBox(
          key: _topBarKey,
          height: topBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HugeIcon(icon: HugeIcons.strokeRoundedShareKnowledge),
              HugeIcon(icon: HugeIcons.strokeRoundedBooks02),
              HugeIcon(icon: HugeIcons.strokeRoundedGithub01),
            ],
          ),
        );
      }

      final linkedinLocalCenter = centers.linkedin - _topBarGlobalLeft!;
      final blogsLocalCenter = centers.blogs - _topBarGlobalLeft!;
      final reposLocalCenter = centers.repos - _topBarGlobalLeft!;

      return SizedBox(
        key: _topBarKey,
        height: topBarHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: linkedinLocalCenter - iconSize / 2,
              top: (topBarHeight - iconSize) / 2,
              child: IconButton(
                iconSize: iconSize,
                color: colors.onPrimary,
                hoverColor: colors.tertiary,
                icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowUpDouble),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/linkedin'),
              ),
            ),
            Positioned(
              left: blogsLocalCenter - iconSize / 2,
              top: (topBarHeight - iconSize) / 2,
              child: IconButton(
                iconSize: iconSize,
                color: colors.onPrimary,
                hoverColor: colors.tertiary,
                icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowUpDouble),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/blogs'),
              ),
            ),
            Positioned(
              left: reposLocalCenter - iconSize / 2,
              top: (topBarHeight - iconSize) / 2,
              child: IconButton(
                iconSize: iconSize,
                color: colors.onPrimary,
                hoverColor: colors.tertiary,
                icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowUpDouble),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/repos'),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: colors.primary,
      width: minHomeWidth,
      child: Column(
        children: [
          ValueListenableBuilder<AppBarButtonCenters?>(
            valueListenable: widget.appBarCentersListenable,
            builder: (context, centers, _) {
              return buildTopBar(centers);
            },
          ),
          textEntry(
            colors,
            "Eric Ovenden",
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          paragraphEntry(
            "This website hosts my software portfolio, blog posts, and my linkedin.",
          ),
        ],
      ),
    );
  }
}
