import 'dart:async';

import 'package:flutter/material.dart' show kToolbarHeight;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ukhsc_mobile_app/core/services/network_state_service.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'app_title.dart';

class AppBar extends StatefulHookConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  const AppBar({super.key, this.onTap});

  @override
  ConsumerState<AppBar> createState() => _AppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends ConsumerState<AppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final networkState = ref.watch(networkConnectivityProvider);
    final isOnline = networkState.valueOrNull;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.spaces.md,
          horizontal: theme.spaces.xl,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              hitTestBehavior: HitTestBehavior.translucent,
              child: GestureDetector(
                onTap: widget.onTap,
                behavior: HitTestBehavior.translucent,
                child: AppTitle(),
              ),
            ),
            if (isOnline != null && !isOnline) OfflineIndicator(),
          ],
        ),
      ),
    );
  }
}

class OfflineIndicator extends HookWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final hideText = useState(false);

    useEffect(() {
      final timer = Timer(Duration(seconds: 3), () {
        hideText.value = true;
      });

      return timer.cancel;
    }, [hideText]);

    return Row(
      spacing: theme.spaces.sm,
      children: [
        if (!hideText.value) Text('離線模式', style: theme.text.common.bodyMedium),
        Icon(Icons.wifi_off_outlined,
            size: 20,
            color:
                hideText.value ? theme.colors.iconColor : Colors.red.shade400),
      ],
    );
  }
}
