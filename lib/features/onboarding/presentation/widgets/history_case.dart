import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/core/style/lib.dart';

class HistoryCasesViewer extends StatefulHookConsumerWidget {
  final List<HistoryCase> cases;
  final VoidCallback? onFinished;

  HistoryCasesViewer({super.key, required this.cases, this.onFinished})
      : assert(cases.isNotEmpty, 'Cases must not be empty');

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryCasesViewerState();
}

class _HistoryCasesViewerState extends ConsumerState<HistoryCasesViewer> {
  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    final children = <Widget>[];
    final totalCases = widget.cases.length;
    for (var i = 0; i < totalCases; i++) {
      final item = widget.cases[i];
      final previousItem = i > 0 ? widget.cases[i - 1] : null;
      children.add(
        Visibility(
          visible: index.value == i,
          child: TickerMode(
            enabled: index.value == i,
            child: HistoryCaseAnimation(
              title: item.title,
              startYear: previousItem?.year ?? item.year,
              endYear: item.year,
              onFinished: () {
                final isLastPage = i + 1 == totalCases;
                if (isLastPage) {
                  widget.onFinished?.call();
                } else if (mounted) {
                  index.value++;
                }
              },
            ),
          ),
        ),
      );
    }

    return Stack(children: children);
  }
}

class HistoryCaseAnimation extends StatefulHookConsumerWidget {
  final String title;
  final int startYear;
  final int endYear;

  final VoidCallback? onFinished;

  const HistoryCaseAnimation(
      {super.key,
      required this.title,
      required this.startYear,
      required this.endYear,
      this.onFinished});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryCaseAnimationState();
}

class _HistoryCaseAnimationState extends ConsumerState<HistoryCaseAnimation> {
  bool titleFinished = false;
  bool yearFinished = false;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final startYear = widget.startYear;
    final endYear = widget.endYear;
    final Duration totalDuration = const Duration(milliseconds: 1500);

    final yearDiff = _getYearDiffPosition(widget.startYear, widget.endYear);
    if (yearDiff == 0) {
      yearFinished = true;
    }

    final startYearStr = startYear.toString();
    final endYearStr = endYear.toString();
    final sameYearStr = startYearStr.substring(0, endYearStr.length - yearDiff);
    final years = _rotateYears(startYear, endYear, yearDiff);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: theme.spaces.xxl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sameYearStr,
                style: theme.text.specialNumber,
              ),
              if (yearDiff > 0)
                AnimatedTextKit(
                  pause: const Duration(milliseconds: 200),
                  animatedTexts: years
                      .map((year) => RotateAnimatedText(
                            year,
                            textAlign: TextAlign.center,
                            textStyle: theme.text.specialNumber,
                            duration: Duration(
                              milliseconds: totalDuration.inMilliseconds ~/
                                  years.length ~/
                                  1.2,
                            ),
                            rotateOut: false,
                          ))
                      .toList(),
                  isRepeatingAnimation: false,
                  onFinished: () {
                    yearFinished = true;
                    _onFinished();
                  },
                ),
            ],
          ),
        ),
        AnimatedTextKit(
          pause: const Duration(milliseconds: 500),
          animatedTexts: [
            TyperAnimatedText(
              widget.title,
              textAlign: TextAlign.center,
              textStyle: theme.text.common.headlineLarge,
              speed: Duration(
                  milliseconds:
                      totalDuration.inMilliseconds ~/ widget.title.length),
            ),
          ],
          isRepeatingAnimation: false,
          onFinished: () {
            titleFinished = true;
            _onFinished();
          },
        ),
      ],
    );
  }

  Future<void> _onFinished() async {
    if (titleFinished && yearFinished) {
      await Future.delayed(const Duration(milliseconds: 500));
      widget.onFinished?.call();
    }
  }

  /// Calculates the difference position between two years for animation purposes.
  int _getYearDiffPosition(int start, int end) {
    final startStr = start.toString();
    final endStr = end.toString();

    final startIterator = startStr.characters.iterator;
    final endIterator = endStr.characters.iterator;
    int sameChars = 0;

    while (startIterator.moveNext() && endIterator.moveNext()) {
      if (startIterator.current != endIterator.current) {
        break;
      }
      sameChars++;
    }

    return endStr.length - sameChars;
  }

  List<String> _rotateYears(int start, int end, int diff) {
    final years = <String>[];
    for (var i = start + 1; i <= end; i++) {
      final yearStr = i.toString();
      final diffStr = yearStr.substring(yearStr.length - diff);
      years.add(diffStr);
    }

    return years;
  }
}

class HistoryCase {
  final String title;
  final int year;

  const HistoryCase({required this.title, required this.year});
}
