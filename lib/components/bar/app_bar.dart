import 'package:flutter/material.dart' show kToolbarHeight;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'app_title.dart';

class AppBar extends HookWidget implements PreferredSizeWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: theme.spaces.md,
          bottom: theme.spaces.md,
          left: theme.spaces.xl,
        ),
        child: Row(
          children: [
            AppTitle(),
            // TODO: Add offline indicator
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
