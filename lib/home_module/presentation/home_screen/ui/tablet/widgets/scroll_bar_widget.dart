import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollBarWidget extends StatefulWidget {
  final List<Widget> children;

  const ScrollBarWidget({Key? key, required this.children}) : super(key: key);

  @override
  State<ScrollBarWidget> createState() => _ScrollBarWidgetState();
}

class _ScrollBarWidgetState extends State<ScrollBarWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
    // return Scrollbar(
    //   isAlwaysShown: false,
    //   thickness: 6,
    //   radius: const Radius.circular(12),
    //   child: SingleChildScrollView(
    //     controller: scrollController,
    //     padding: const EdgeInsets.symmetric(horizontal: 24),
    //     child: Column(
    //       children: widget.children,
    //     ),
    //   ),
    // );
  }
}
