import 'package:flutter/material.dart' show Divider, RichText, TextSpan;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/gen/fonts.gen.dart';

import '../../model/student_member.dart';

class MembershipDataView extends HookWidget {
  final StudentMember member;
  const MembershipDataView({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: theme.spaces.sm),
          child: Text('會員基本資料', style: theme.text.common.titleSmall),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: theme.spaces.xxs),
          child: Divider(),
        ),
        Column(
          spacing: theme.spaces.sm,
          children: [
            _buildItem('編號', member.id, useMono: true),
            _buildItem('方案', '由學生自治組織提供'),
            if (member.activatedAt != null)
              _buildDateItem('資格啟用日期', member.activatedAt!),
            if (member.expiredAt != null)
              _buildDateItem('資格有效期限', member.expiredAt!),
          ],
        ),
      ],
    );
  }

  // 新增共用方法，統一產生帶有標題與內容的 Row
  Widget _buildRow(String title, Widget content, dynamic theme) {
    return Padding(
      padding: EdgeInsets.only(left: theme.spaces.sm, right: theme.spaces.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(title, style: theme.text.common.titleSmall),
          ),
          Flexible(
            flex: 3,
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String content, {bool useMono = false}) {
    final theme = useTheme();

    return _buildRow(
      title,
      Text(
        content,
        style: theme.text.common.bodyLarge.copyWith(
          color: theme.colors.accentText,
          fontFamily: useMono ? FontFamily.iBMPlexMono : null,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      theme,
    );
  }

  Widget _buildDateItem(String title, DateTime time) {
    final theme = useTheme();
    final dateStr =
        '${time.year} 年 ${time.month.toString().padLeft(2, '0')} 月 ${time.day.toString().padLeft(2, '0')} 日';

    return _buildRow(
      title,
      RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: theme.text.common.bodyLarge
              .copyWith(color: theme.colors.accentText),
          children: _buildDateTextSpans(dateStr),
        ),
      ),
      theme,
    );
  }

  List<TextSpan> _buildDateTextSpans(String text) {
    final spans = <TextSpan>[];
    final regExp = RegExp(r'\d+');
    int start = 0;

    for (final match in regExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: TextStyle(fontFamily: FontFamily.iBMPlexMono),
      ));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return spans;
  }
}
