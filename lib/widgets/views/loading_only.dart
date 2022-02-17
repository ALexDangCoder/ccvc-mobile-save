import 'package:ccvc_mobile/widgets/views/state_layout.dart';
import 'package:flutter/material.dart';

class LoadingOnly extends StatelessWidget {
  final Stream<StateLayout> stream;
  final Widget child;

  const LoadingOnly({Key? key, required this.child, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateLayout>(
      stream: stream,
      builder: (context, snapshot) {
        return ModalProgressHUD(
          inAsyncCall: snapshot.data == StateLayout.showLoading,
          opacity: 0,
          progressIndicator: const CircularProgressIndicator(),
          child: child,
        );
      },
    );
  }
}

class ModalProgressHUD extends StatefulWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  const ModalProgressHUD({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator.adaptive(),
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  State<ModalProgressHUD> createState() => _ModalProgressHUDState();
}

class _ModalProgressHUDState extends State<ModalProgressHUD> {
  Size size = const Size(0, 0);
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final renderBox = context.findRenderObject() as RenderBox;
      size = renderBox.size;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Visibility(
          visible: widget.inAsyncCall,
          child: Positioned(
              top: size.height / 2,
              right: size.width / 2,
              child: Center(child: widget.progressIndicator)),
        )
      ],
    );
  }
}
