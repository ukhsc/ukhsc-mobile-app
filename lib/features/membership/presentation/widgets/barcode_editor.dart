import 'package:flutter/material.dart'
    show InputDecoration, OutlineInputBorder, TextField;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/lib.dart';
import 'package:ukhsc_mobile_app/features/membership/presentation/provider.dart';

class BarcodeEditor extends StatefulHookConsumerWidget {
  final String? barcode;

  const BarcodeEditor({super.key, this.barcode});

  @override
  ConsumerState<BarcodeEditor> createState() => _BarcodeEditorState();
}

class _BarcodeEditorState extends ConsumerState<BarcodeEditor> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final controller = useTextEditingController(text: widget.barcode);
    final error = useState<String?>(null);
    final isSubmitting = useState(false);

    return Container(
      constraints: BoxConstraints.expand(height: 330),
      padding: EdgeInsets.symmetric(horizontal: theme.spaces.xxl).add(
        EdgeInsets.only(bottom: theme.spaces.md),
      ),
      child: AppSafeArea(
        top: false,
        child: Column(
          spacing: theme.spaces.md,
          children: [
            Text('綁定雲端發票手機條碼', style: theme.text.common.headlineLarge),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    spacing: theme.spaces.xs,
                    children: [
                      TextField(
                        controller: controller,
                        cursorColor: theme.colors.primary,
                        decoration: InputDecoration(
                          hintText: '/A3Z+920',
                          hintStyle: theme.text.common.labelLarge,
                          errorText: error.value,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.colors.tertiaryText,
                            ),
                            borderRadius:
                                BorderRadius.all(theme.radii.small / 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.colors.primary,
                            ),
                            borderRadius:
                                BorderRadius.all(theme.radii.small / 2),
                          ),
                        ),
                        onChanged: (value) => error.value = null,
                      ),
                      Text(
                        '手機條碼格式為 / + 7 碼英數字或符號（大寫）',
                        style: theme.text.common.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  ComposableButton(
                    onPressed: () async {
                      final text = controller.text;
                      if (text.isEmpty) {
                        error.value = '請輸入手機條碼';
                        return;
                      }

                      final validationError = _validateBarcode(text);
                      error.value = validationError;

                      if (validationError == null) {
                        isSubmitting.value = true;
                        final notifier =
                            ref.read(membershipControllerProvider.notifier);
                        await notifier.editSettings(
                            MemberSettings(eInvoiceBarcode: text));
                        isSubmitting.value = false;

                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    },
                    style: FilledStyle.dark(),
                    content: Text('立即綁定')
                        .asButtonContent
                        .withPadding(
                          EdgeInsets.symmetric(vertical: theme.spaces.sm),
                        )
                        .withLoading(isSubmitting.value)
                        .withExpanded(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String? _validateBarcode(String value) {
    final pattern = RegExp(r'^\/[0-9A-Z.+-]{7}$');
    if (pattern.hasMatch(value)) return null;

    return '條碼格式錯誤';
  }
}
