import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddToDoWidgetTienIch extends StatefulWidget {
  final Function(String) onTap;
  final String initData;

  const AddToDoWidgetTienIch(
      {Key? key, required this.onTap, this.initData = ''})
      : super(key: key);

  @override
  _AddToDoWidgetTienIchState createState() => _AddToDoWidgetTienIchState();
}

class _AddToDoWidgetTienIchState extends State<AddToDoWidgetTienIch> {
  bool isAdd = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.initData;
  }

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
              child: ShowRequied(
                textShow: S.current.ban_phai_nhap_truong_ten_nhom,
                isShow: isShow,
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      isAdd = false;
                    } else {
                      isAdd = true;
                    }
                    setState(() {
                      isShow = false;
                    });
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
                          ImageAssets.icEditBlue,
                          width: 14,
                          height: 14,
                          color: coloriCon,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    isDense: true,
                  ),
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
                if (controller.text.trim().isEmpty) {
                  setState(() {
                    isShow = true;
                  });
                  return;
                }
                widget.onTap(controller.text.trim());
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
