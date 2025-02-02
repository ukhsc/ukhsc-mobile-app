import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/router.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

class OverlayMessage {
  static OverlayEntry? _currentEntry;

  static void show(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _show(message);
    });
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }

  static void _show(String message) {
    hide();

    final entry = OverlayEntry(builder: (context) => _buildContent(message));
    _currentEntry = entry;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), hide);
  }

  static Widget _buildContent(String message) {
    return HookBuilder(
      builder: (context) {
        final theme = useTheme();

        return Positioned(
          bottom: 0,
          left: theme.spaces.md,
          right: theme.spaces.md,
          child: AppSafeArea(
            child: Material(
              color: theme.colors.primary,
              borderRadius: BorderRadius.all(theme.radii.small),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spaces.md,
                  vertical: theme.spaces.md,
                ),
                child: Text(
                  message,
                  style: theme.text.common.bodyLarge.copyWith(
                    color: theme.colors.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
