import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class InputInfoUserWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isObligatory;
  final bool needMargin;

  const InputInfoUserWidget({
    Key? key,
    required this.title,
    required this.child,
    this.isObligatory = false,
    this.needMargin = true,
  }) : super(key: key);

  @override
  State<InputInfoUserWidget> createState() => _InputInfoUserWidgetState();
}

class _InputInfoUserWidgetState extends State<InputInfoUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.needMargin ? 20 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              textConten(),
              if (widget.isObligatory)
                const Text(
                  ' *',
                  style: TextStyle(color: colorF94444),
                )
              else
                const SizedBox()
            ],
          ),
          spaceH10,
          widget.child
        ],
      ),
    );
  }

  Widget textConten() {
    return Text(
      widget.title,
      style: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: color586B8B,
      ),
    );
  }
}
