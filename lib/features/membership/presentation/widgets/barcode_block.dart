import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';

import 'barcode_editor.dart';

class BarcodeBlock extends StatefulHookConsumerWidget {
  final String? barcode;
  const BarcodeBlock({super.key, required this.barcode});

  @override
  ConsumerState<BarcodeBlock> createState() => _BarcodeBlockState();
}

class _BarcodeBlockState extends ConsumerState<BarcodeBlock> {
  @override
  Widget build(BuildContext context) {
    final barcode = widget.barcode;

    if (barcode == null) {
      return _buildEmptyMessage();
    }

    final theme = useTheme();

    return Column(
      spacing: theme.spaces.md,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spaces.sm),
          child: BarcodeWidget(
            height: 100,
            barcode: Barcode.code39(),
            data: barcode,
            color: theme.colors.primary,
          ),
        ),
        ComposableButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => BarcodeEditor(barcode: widget.barcode),
            );
          },
          style: OutlinedStyle.normal(),
          content: Text('編輯條碼').asButtonContent,
        ),
      ],
    );
  }

  SizedBox _buildEmptyMessage() {
    final theme = useTheme();

    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: theme.spaces.xs,
        children: [
          Text(
            '綁定發票共通性載具！\n在特約商店享受更便利的支付體驗',
            style: theme.text.common.titleSmall,
            textAlign: TextAlign.center,
          ),
          ComposableButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BarcodeEditor(barcode: widget.barcode),
              );
            },
            style: FilledStyle.light(
              backgroundColor: theme.colors.primaryBackground,
            ),
            content: Text('綁定條碼').asButtonContent,
          ),
        ],
      ),
    );
  }
}
