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
  final int maxLines;

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

  String _replaceString({double maxWidth = 0}) {
    final textSlip = data.split(' ');
    String character = '';
    for (int  i = 0 ; i< textSlip.length ; i++ ) {
      final element = textSlip[i];
      final painter = TextPainter(
        text: TextSpan(text: '${character.trim()} $element...', style: style),
        textDirection: TextDirection.ltr,
        textHeightBehavior: textHeightBehavior,
        strutStyle: strutStyle,
      );
      painter.layout(maxWidth: maxWidth);
      final metrics = painter.computeLineMetrics();
      if (metrics.length > maxLines) {
        return '${character.trim()}...';
      }
      character = '${character.trim()} $element';
    }
    return character;
  }

  String _loadData(
    BoxConstraints constraints,
    TextStyle style,
    double? textScale,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      textDirection: TextDirection.ltr,
      locale: locale ?? style.locale,
      textScaleFactor: textScale ?? 1,
      textHeightBehavior: textHeightBehavior,
      strutStyle: strutStyle,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);
    final lineText = textPainter.computeLineMetrics();
    if (lineText.length < maxLines ||
        (lineText.length == maxLines &&
            lineText[maxLines - 1].width < constraints.maxWidth - 30)) {
      return data;
    }
    final newString = _replaceString(maxWidth: constraints.maxWidth);
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

        final replaceCharater = _loadData(
          constraints,
          textStyle,
          textScale,
        );

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
