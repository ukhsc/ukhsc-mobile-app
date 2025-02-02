import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/error/lib.dart';
import 'package:ukhsc_mobile_app/core/router.dart';
import '../misc/overlay_message.dart';
import 'error_dialog.dart';

class ErrorHandlerWrap extends HookConsumerWidget {
  final Widget child;
  const ErrorHandlerWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogOpened = useState(false);

    ref.listen(errorServiceProvider, (pre, next) {
      final event = next.lastEvent;
      if (event == null) return;

      if (event.severity == ErrorSeverity.panic) {
        if (dialogOpened.value) return;
        dialogOpened.value = true;
        _showDialog(
          event,
          onDismissed: () {
            dialogOpened.value = false;
          },
        );
      } else if (event.severity == ErrorSeverity.warning) {
        if (event.message != null) {
          OverlayMessage.show(event.message!);
        }
      }
    });

    return child;
  }

  void _showDialog(AppErrorEvent event,
      {required final VoidCallback onDismissed}) async {
    bool canShow = navigatorKey.currentContext != null &&
        (navigatorKey.currentState?.mounted ?? false);
    if (!canShow) return;

    event = event.copyWith(action: () {
      event.action?.call();
      onDismissed.call();
    });

    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => ErrorDialog(event: event),
    );
  }
}
