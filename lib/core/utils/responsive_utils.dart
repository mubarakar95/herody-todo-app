import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    return getScreenWidth(context) >= 600 && getScreenWidth(context) < 900;
  }

  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= 900;
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) {
      return const EdgeInsets.all(16.0);
    } else if (width < 900) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) {
      return 1;
    } else if (width < 900) {
      return 2;
    } else {
      return 3;
    }
  }
}
