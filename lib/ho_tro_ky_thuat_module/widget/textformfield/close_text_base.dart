import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CloseTextBase extends StatefulWidget {
  final TextEditingController textEditingController;

  const CloseTextBase({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _CloseTextBaseState createState() => _CloseTextBaseState();
}

class _CloseTextBaseState extends State<CloseTextBase> {
  @override
  void initState() {
    widget.textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.textEditingController.text = '';
      },
      child: widget.textEditingController.text.isNotEmpty
          ? SvgPicture.asset(
              ImageAssets.icClose,
              width: 20,
              height: 20,
            )
          : const SizedBox(
              height: 20,
              width: 20,
            ),
    );
  }
}
