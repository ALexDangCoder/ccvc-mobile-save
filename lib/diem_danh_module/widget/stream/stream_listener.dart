
import 'package:flutter/material.dart';


class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    Key? key,
    required this.child,
    required this.stream,
    required this.listen,
  }) : super(key: key);

  final Widget child;
  final Function(T) listen;
  final Stream<T> stream;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  @override
  void initState() {
    super.initState();
    widget.stream.listen((event) {
      widget.listen(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
