import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


const double _kSelectionHandleOverlap = 1.5;
// Extracted from https://developer.apple.com/design/resources/.
const double _kSelectionHandleRadius = 6;

// Minimal padding from tip of the selection toolbar arrow to horizontal edges of the
// screen. Eyeballed value.
const double _kArrowScreenPadding = 26.0;

class AppCupertinoTextSelectionControls extends TextSelectionControls {
  AppCupertinoTextSelectionControls({
    required this.validatorPaste,
  });

  final bool Function(String) validatorPaste;

  RenderBox? boxTextFeild;

  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (validatorPaste(data?.text ?? '')) {
      await handlePasteValidator(delegate, data?.text);
    } else {
      delegate.bringIntoView(delegate.textEditingValue.selection.extent);
      delegate.hideToolbar();
    }
  }

  Future<void> handlePasteValidator(
      TextSelectionDelegate delegate, String? text) async {
    final TextEditingValue value =
        delegate.textEditingValue; // Snapshot the input before using `await`.
    if (text != null) {
      delegate.userUpdateTextEditingValue(
        TextEditingValue(
          text: value.selection.textBefore(value.text) +
              text +
              value.selection.textAfter(value.text),
          selection: TextSelection.collapsed(
            offset: value.selection.start + text.length,
          ),
        ),
        SelectionChangedCause.toolBar,
      );
    }
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
    delegate.hideToolbar();
  }

  /// Returns the size of the Cupertino handle.
  @override
  Size getHandleSize(double textLineHeight) {
    return Size(
      _kSelectionHandleRadius * 2,
      textLineHeight + _kSelectionHandleRadius * 2 - _kSelectionHandleOverlap,
    );
  }

  @override
  void handleSelectAll(TextSelectionDelegate delegate) {
    delegate.userUpdateTextEditingValue(
      TextEditingValue(
        text: delegate.textEditingValue.text,
        selection: TextSelection(
          baseOffset: 0,
          extentOffset: delegate.textEditingValue.text.length,
        ),
      ),
      SelectionChangedCause.toolBar,
    );
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
  }

  /// Builder for iOS-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier clipboardStatus,
      Offset? lastSecondaryTapDownPosition,
      ) {
    return _CupertinoTextSelectionControlsToolbar(
      clipboardStatus: clipboardStatus,
      endpoints: endpoints,
      globalEditableRegion: globalEditableRegion,
      handleCut: canCut(delegate) ? () => handleCut(delegate) : null,
      handleCopy: canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : null,
      handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
      handleSelectAll:
      canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
      selectionMidpoint: selectionMidpoint,
      textLineHeight: textLineHeight,
      boxTextFeild: boxTextFeild,
    );
  }

  /// Builder for iOS text selection edges.
  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap, double? startGlyphHeight, double? endGlyphHeight]) {
    // iOS selection handles do not respond to taps.

    // We want a size that's a vertical line the height of the text plus a 18.0
    // padding in every direction that will constitute the selection drag area.
    startGlyphHeight = startGlyphHeight ?? textLineHeight;
    endGlyphHeight = endGlyphHeight ?? textLineHeight;

    final Size desiredSize;
    final Widget handle;

    final Widget customPaint = CustomPaint(
      painter:
      _TextSelectionHandlePainter(CupertinoTheme.of(context).primaryColor),
    );

    // [buildHandle]'s widget is positioned at the selection cursor's bottom
    // baseline. We transform the handle such that the SizedBox is superimposed
    // on top of the text selection endpoints.
    switch (type) {
      case TextSelectionHandleType.left:
        desiredSize = getHandleSize(startGlyphHeight);
        handle = SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
        return handle;
      case TextSelectionHandleType.right:
        desiredSize = getHandleSize(endGlyphHeight);
        handle = SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
        return Transform(
          transform: Matrix4.identity()
            ..translate(desiredSize.width / 2, desiredSize.height / 2)
            ..rotateZ(math.pi)
            ..translate(-desiredSize.width / 2, -desiredSize.height / 2),
          child: handle,
        );
    // iOS doesn't draw anything for collapsed selections.
      case TextSelectionHandleType.collapsed:
        return const SizedBox();
    }
  }

  /// Gets anchor for cupertino-style text selection handles.
  ///
  /// See [TextSelectionControls.getHandleAnchor].
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight,
      [double? startGlyphHeight, double? endGlyphHeight]) {
    startGlyphHeight = startGlyphHeight ?? textLineHeight;
    endGlyphHeight = endGlyphHeight ?? textLineHeight;

    final Size handleSize;

    switch (type) {
    // The circle is at the top for the left handle, and the anchor point is
    // all the way at the bottom of the line.
      case TextSelectionHandleType.left:
        handleSize = getHandleSize(startGlyphHeight);
        return Offset(
          handleSize.width / 2,
          handleSize.height,
        );
    // The right handle is vertically flipped, and the anchor point is near
    // the top of the circle to give slight overlap.
      case TextSelectionHandleType.right:
        handleSize = getHandleSize(endGlyphHeight);
        return Offset(
          handleSize.width / 2,
          handleSize.height -
              2 * _kSelectionHandleRadius +
              _kSelectionHandleOverlap,
        );
    // A collapsed handle anchors itself so that it's centered.
      case TextSelectionHandleType.collapsed:
        handleSize = getHandleSize(textLineHeight);
        return Offset(
          handleSize.width / 2,
          textLineHeight + (handleSize.height - textLineHeight) / 2,
        );
    }
  }
}


class _CupertinoTextSelectionControlsToolbar extends StatefulWidget {
  const _CupertinoTextSelectionControlsToolbar({
    Key? key,
    required this.clipboardStatus,
    required this.endpoints,
    required this.globalEditableRegion,
    required this.handleCopy,
    required this.handleCut,
    required this.handlePaste,
    required this.handleSelectAll,
    required this.selectionMidpoint,
    required this.textLineHeight,
    this.boxTextFeild,
  }) : super(key: key);

  final ClipboardStatusNotifier? clipboardStatus;
  final List<TextSelectionPoint> endpoints;
  final Rect globalEditableRegion;
  final VoidCallback? handleCopy;
  final VoidCallback? handleCut;
  final VoidCallback? handlePaste;
  final VoidCallback? handleSelectAll;
  final Offset selectionMidpoint;
  final double textLineHeight;
  final RenderBox? boxTextFeild;

  @override
  _CupertinoTextSelectionControlsToolbarState createState() =>
      _CupertinoTextSelectionControlsToolbarState();
}

class _CupertinoTextSelectionControlsToolbarState
    extends State<_CupertinoTextSelectionControlsToolbar> {
  ClipboardStatusNotifier? _clipboardStatus;

  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.handlePaste != null) {
      _clipboardStatus = widget.clipboardStatus ?? ClipboardStatusNotifier();
      _clipboardStatus!.addListener(_onChangedClipboardStatus);
      _clipboardStatus!.update();
    }
  }

  @override
  void didUpdateWidget(_CupertinoTextSelectionControlsToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clipboardStatus != widget.clipboardStatus) {
      if (_clipboardStatus != null) {
        _clipboardStatus!.removeListener(_onChangedClipboardStatus);
        _clipboardStatus!.dispose();
      }
      _clipboardStatus = widget.clipboardStatus ?? ClipboardStatusNotifier();
      _clipboardStatus!.addListener(_onChangedClipboardStatus);
      if (widget.handlePaste != null) {
        _clipboardStatus!.update();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // When used in an Overlay, this can be disposed after its creator has
    // already disposed _clipboardStatus.
    if (_clipboardStatus != null && !_clipboardStatus!.disposed) {
      _clipboardStatus!.removeListener(_onChangedClipboardStatus);
      if (widget.clipboardStatus == null) {
        _clipboardStatus!.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't render the menu until the state of the clipboard is known.
    if (widget.handlePaste != null &&
        _clipboardStatus!.value == ClipboardStatus.unknown) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    // The toolbar should appear below the TextField when there is not enough
    // space above the TextField to show it, assuming there's always enough
    // space at the bottom in this case.
    late final double anchorX;
    if (widget.boxTextFeild == null) {
      anchorX = (widget.selectionMidpoint.dx + widget.globalEditableRegion.left)
          .clamp(
        _kArrowScreenPadding + mediaQuery.padding.left,
        mediaQuery.size.width - mediaQuery.padding.right - _kArrowScreenPadding,
      );
    } else {
      final appoffset =
      (widget.selectionMidpoint.dx + widget.globalEditableRegion.left)
          .clamp(
        _kArrowScreenPadding + mediaQuery.padding.left,
        mediaQuery.size.width - mediaQuery.padding.right - _kArrowScreenPadding,
      );
      final userOffset = (widget.boxTextFeild!.localToGlobal(Offset.zero).dx +
          widget.endpoints.last.point.dx / 2)
          .clamp(
        _kArrowScreenPadding + mediaQuery.padding.left,
        mediaQuery.size.width - mediaQuery.padding.right - _kArrowScreenPadding,
      );
      if (appoffset < widget.boxTextFeild!.localToGlobal(Offset.zero).dx) {
        anchorX = userOffset;
      } else {
        anchorX = appoffset;
      }
    }
    // The y-coordinate has to be calculated instead of directly quoting
    // selectionMidpoint.dy, since the caller
    // (TextSelectionOverlay._buildToolbar) does not know whether the toolbar is
    // going to be facing up or down.
    final Offset anchorAbove = Offset(
      anchorX,
      widget.endpoints.first.point.dy -
          widget.textLineHeight +
          widget.globalEditableRegion.top,
    );
    final Offset anchorBelow = Offset(
      anchorX,
      widget.endpoints.last.point.dy + widget.globalEditableRegion.top,
    );

    final List<Widget> items = <Widget>[];
    final CupertinoLocalizations localizations =
    CupertinoLocalizations.of(context);
    final Widget onePhysicalPixelVerticalDivider =
    SizedBox(width: 1.0 / MediaQuery.of(context).devicePixelRatio);

    void addToolbarButton(
        String text,
        VoidCallback onPressed,
        ) {
      if (items.isNotEmpty) {
        items.add(onePhysicalPixelVerticalDivider);
      }

      items.add(CupertinoTextSelectionToolbarButton.text(
        onPressed: onPressed,
        text: text,
      ));
    }

    if (widget.handleCut != null) {
      addToolbarButton(localizations.cutButtonLabel, widget.handleCut!);
    }
    if (widget.handleCopy != null) {
      addToolbarButton(localizations.copyButtonLabel, widget.handleCopy!);
    }
    if (widget.handlePaste != null &&
        _clipboardStatus!.value == ClipboardStatus.pasteable) {
      addToolbarButton(localizations.pasteButtonLabel, widget.handlePaste!);
    }
    if (widget.handleSelectAll != null) {
      addToolbarButton(
          localizations.selectAllButtonLabel, widget.handleSelectAll!);
    }

    // If there is no option available, build an empty widget.
    if (items.isEmpty) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return CupertinoTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      children: items,
    );
  }
}

class _TextSelectionHandlePainter extends CustomPainter {
  const _TextSelectionHandlePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: const Offset(_kSelectionHandleRadius, _kSelectionHandleRadius),
      radius: _kSelectionHandleRadius,
    );
    final Rect line = Rect.fromPoints(
      const Offset(
        _kSelectionHandleRadius - halfStrokeWidth,
        2 * _kSelectionHandleRadius - _kSelectionHandleOverlap,
      ),
      Offset(_kSelectionHandleRadius + halfStrokeWidth, size.height),
    );
    final Path path = Path()
      ..addOval(circle)
    // Draw line so it slightly overlaps the circle.
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TextSelectionHandlePainter oldPainter) =>
      color != oldPainter.color;
}
