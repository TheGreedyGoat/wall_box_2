import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';

class ShowIntervals extends StatefulWidget {
  final List<TimeInterval> intervals;
  final double totalWidth;
  const ShowIntervals({
    super.key,
    required this.intervals,
    required this.totalWidth,
  });

  @override
  State<ShowIntervals> createState() => _ShowIntervalsState();
}

class _ShowIntervalsState extends State<ShowIntervals> {
  late final DateTime firstStart; // a
  late final DateTime lastEnd; // b
  @override
  void initState() {
    super.initState();
    _precalc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: widget.totalWidth + 200,
        child: Stack(
          children: [
            SizedBox(
              width: widget.totalWidth,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (
                    DateTime date = firstStart;
                    date.isBefore(lastEnd);
                    date = date.add(Duration(days: 7))
                  )
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                date.toDynamicString(
                                  '~DD.~MM',
                                ),
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  ...widget.intervals.map(
                    (interval) {
                      final startPoint = _calcPosition(interval.from);
                      final endPoint = _calcPosition(interval.to);
                      final width = (endPoint - startPoint).abs();

                      final color = HSVColor.fromAHSV(
                        1,
                        widget.intervals.indexOf(interval) /
                            widget.intervals.length *
                            255,
                        1,
                        1,
                      ).toColor();
                      return Transform.translate(
                        offset: Offset(startPoint, 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5, color: color),
                                ),
                              ),
                            ),
                            Text(interval.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _precalc() {
    firstStart = widget.intervals
        .reduce(
          (a, b) => a.from.isBefore(b.from) ? a : b,
        )
        .from;
    lastEnd = widget.intervals
        .reduce(
          (a, b) => a.from.isAfter(b.from) ? a : b,
        )
        .from;
  }

  double _calcPosition(DateTime date) {
    final t =
        date.difference(firstStart).inMicroseconds /
        lastEnd.difference(firstStart).inMicroseconds;
    return lerpDouble(0, widget.totalWidth, t)!;
  }

  double _inverseLerp(double a, double b, double l) {
    return (l - a) / (b - a);
  }
}
