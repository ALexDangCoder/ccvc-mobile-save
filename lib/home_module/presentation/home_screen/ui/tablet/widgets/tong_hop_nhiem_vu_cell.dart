import 'package:flutter/material.dart';

class TongHopNhiemVuCell extends StatefulWidget {

  final List<Widget> childs;
  const TongHopNhiemVuCell(
      {Key? key, required this.childs})
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
        widget.childs.length,
        (index) => SizedBox(
          width: 163,
          height: 200,
          child: widget.childs[index],
        ),
      ),
    );
  }
}
