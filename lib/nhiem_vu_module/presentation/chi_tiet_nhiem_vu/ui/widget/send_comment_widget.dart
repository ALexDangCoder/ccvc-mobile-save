import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendCommentWidget extends StatefulWidget {
  final TextEditingController contentController = TextEditingController();
  final Function(String, List<String>) onSendComment;
  bool isReComment = false;
  final ValueNotifier<bool> _isDisableButtonNotifier = ValueNotifier(true);

  SendCommentWidget({
    Key? key,
    required this.onSendComment,
    required this.isReComment,
  }) : super(key: key);

  @override
  _SendCommentWidgetState createState() =>
      _SendCommentWidgetState();
}

class _SendCommentWidgetState extends State<SendCommentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 62.0.textScale(space: 18.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (text) {
                    widget._isDisableButtonNotifier.value = text.trim().isEmpty;
                  },
                  controller: widget.contentController,
                  maxLines: 3,
                  style: tokenDetailAmount(
                    fontSize: 14.0.textScale(),
                    color: colorB9C4D0,
                  ),
                  decoration: InputDecoration(
                    fillColor: colorFFFFFF,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: colorDBDFEF,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: colorDBDFEF,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    hintText: S.current.nhap_y_kien_cua_ban,
                    hintStyle: textNormalCustom(
                      color: colorB9C4D0,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0.textScale(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: widget._isDisableButtonNotifier,
                    builder: (context, value, child) {
                      final bool isDisable = value as bool;
                      return IconButton(
                        icon: SvgPicture.asset(
                          isDisable
                              ? ImageAssets.ic_gui_y_kien
                              : ImageAssets.ic_gui_y_kien,
                        ),
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
