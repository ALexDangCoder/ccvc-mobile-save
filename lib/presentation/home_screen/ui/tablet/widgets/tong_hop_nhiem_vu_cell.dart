import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class TongHopNhiemVuCell extends StatefulWidget {
  final Widget Function(BuildContext, int) builder;
  const TongHopNhiemVuCell({Key? key, required this.builder}) : super(key: key);

  @override
  State<TongHopNhiemVuCell> createState() => _TongHopNhiemVuCellState();
}

class _TongHopNhiemVuCellState extends State<TongHopNhiemVuCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: widget.builder(context, 0),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: widget.builder(context, 1),
              )
            ],
          ),
        ),
        spaceH20,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: widget.builder(context, 2),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: widget.builder(context, 3),
              )
            ],
          ),
        ),
        spaceH20,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: widget.builder(context, 4),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: widget.builder(context, 5),
              )
            ],
          ),
        )
      ],
    );
  }
}
