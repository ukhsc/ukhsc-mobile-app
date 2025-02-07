import 'package:flutter/material.dart' show kToolbarHeight;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'app_title.dart';

class AppBar extends HookWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  const AppBar({super.key, this.onTap});

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
            MouseRegion(
              hitTestBehavior: HitTestBehavior.translucent,
              child: GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.translucent,
                child: AppTitle(),
              ),
            ),
            // TODO: Add offline indicator
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
