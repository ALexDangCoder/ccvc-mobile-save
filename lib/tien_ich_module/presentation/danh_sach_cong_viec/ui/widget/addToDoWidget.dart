import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddToDoWidgetTienIch extends StatefulWidget {
  final Function(String) onTap;

  const AddToDoWidgetTienIch({Key? key, required this.onTap}) : super(key: key);

  @override
  _AddToDoWidgetTienIchState createState() => _AddToDoWidgetTienIchState();
}

class _AddToDoWidgetTienIchState extends State<AddToDoWidgetTienIch> {
  bool isAdd = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: borderButtomColor)),
              ),
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  if (value.isEmpty) {
                    isAdd = false;
                  } else {
                    isAdd = true;
                  }
                  setState(() {});
                },
                style: textNormal(infoColor, 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints:
                  const BoxConstraints(maxWidth: 25, maxHeight: 14),
                  prefixIcon: Container(
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        ImageAssets.icEdit,
                        width: 14,
                        height: 14,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  isDense: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: isMobile()
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 100),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.them,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                widget.onTap(controller.text.trim());
                controller.text = '';
                focusNode.unfocus();
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}