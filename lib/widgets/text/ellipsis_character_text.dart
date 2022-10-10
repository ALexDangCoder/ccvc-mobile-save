import 'package:flutter/material.dart';

class EllipsisDoubleLineText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  static const double _defaultFontSize = 14;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final double? textScaleFactor;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final int? maxLines;
  const EllipsisDoubleLineText(
    this.data, {
    Key? key,
    this.locale,
    this.maxLines = 2,
    this.semanticsLabel,
    this.selectionColor,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.textWidthBasis,
  }) : super(key: key);
  String _replaceString(int? maxLines, TextPainter textPainter,
      {double maxWidth = 0}) {
    if (maxLines == null) return data;
    final textSlip = data.split(' ');
    String charater = '';
    for (var element in textSlip) {
      final painter = TextPainter(
          text: TextSpan(text: '${charater.trim()}...', style: style),
          textDirection: TextDirection.ltr,
          textHeightBehavior: textHeightBehavior,
          strutStyle: strutStyle,
          maxLines: maxLines);

      painter.layout(maxWidth: maxWidth - 30);
      final metrics = painter.computeLineMetrics();
      if (metrics.length > maxLines) {
        return '${charater.trim()}...';
      }
      if (metrics.length > 1 && metrics[1].width >= maxWidth - 30) {
        return '${charater.trim()}...';
      }
      charater = charater + element + ' ';
    }

    return data;
  }

  String _loadData(BoxConstraints constraints, TextStyle style,
      double? textScale, int? maxLinesx) {
    final textPainter = TextPainter(
        text: TextSpan(text: data, style: style),
        textDirection: TextDirection.ltr,
        locale: locale ?? style.locale,
        textScaleFactor: textScale ?? 1,
        textHeightBehavior: textHeightBehavior,
        strutStyle: strutStyle,
        maxLines: maxLines,
        ellipsis: '...');

    textPainter.layout(maxWidth: constraints.maxWidth);
    final lineText = textPainter.computeLineMetrics();
    if (lineText.length == 1) return data;

    if (lineText[1].width < constraints.maxWidth && lineText.length <= 2)
      return data;

    String newString = _replaceString(2, textPainter, maxWidth: constraints.maxWidth);
    return newString;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultTextStyle = DefaultTextStyle.of(context);

        late TextStyle textStyle;
        if (style == null || style!.inherit) {
          textStyle = defaultTextStyle.style.merge(style);
        }
        if (textStyle.fontSize == null) {
          textStyle = textStyle.copyWith(
            fontSize: EllipsisDoubleLineText._defaultFontSize,
          );
        }

        final textScale =
            textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

        int? maxLines = this.maxLines ?? defaultTextStyle.maxLines;

        final replaceCharater =
            _loadData(constraints, textStyle, textScale, maxLines);

        return Text(replaceCharater,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: textHeightBehavior,
            textAlign: textAlign,
            softWrap: softWrap,
            textDirection: textDirection,
            textWidthBasis: textWidthBasis,
            textScaleFactor: textScale,
            locale: locale,
            semanticsLabel: semanticsLabel,
            strutStyle: strutStyle,
            maxLines: maxLines);
      },
    );
  }
}
