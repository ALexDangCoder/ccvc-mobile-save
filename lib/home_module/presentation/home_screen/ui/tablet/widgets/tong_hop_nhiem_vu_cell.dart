import 'package:flutter/material.dart';

class TongHopNhiemVuCell extends StatefulWidget {
  final int count;
  final Widget Function(BuildContext, int) builder;
  const TongHopNhiemVuCell(
      {Key? key, required this.builder, required this.count})
      : super(key: key);

  @override
  State<TongHopNhiemVuCell> createState() => _TongHopNhiemVuCellState();
}

class _TongHopNhiemVuCellState extends State<TongHopNhiemVuCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          widget.count,
          (index) =>
              SizedBox(width: 163, height: 200,child: widget.builder(context, index))),
    );
  }
}
