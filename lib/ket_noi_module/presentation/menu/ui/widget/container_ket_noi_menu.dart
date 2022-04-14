import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerKetNoiMenuWidget extends StatefulWidget {
  final Widget? childExpand;
  final Function() onTap;
  final LoaiBaiVietModel data;

  const ContainerKetNoiMenuWidget({
    Key? key,
    required this.data,
    this.childExpand,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ContainerKetNoiMenuWidget> createState() =>
      _ContainerKetNoiMenuWidgetState();
}

class _ContainerKetNoiMenuWidgetState extends State<ContainerKetNoiMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if ((widget.data.childrens ?? []).isEmpty) {
              widget.onTap();
              Navigator.pop(context);
            } else {
              widget.data.isShowExpanded =
                  !(widget.data.isShowExpanded ?? false);
              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 17.0.textScale(),
              vertical: 12.0.textScale(),
            ),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (widget.data.id == ID_KET_NOI ||
                          widget.data.id == ID_SU_KIEN)
                        SizedBox(
                          height: 15.0.textScale(space: 8),
                          width: 15.0.textScale(space: 8),
                          child: SvgPicture.asset(
                            ImageAssets.ic_wifi,
                            color: Colors.grey,
                          ),
                        )
                      else
                        SizedBox(
                          height: 15.0.textScale(space: 8),
                          width: 15.0.textScale(space: 8),
                        ),
                      Container(
                        width: 14.0.textScale(),
                      ),
                      Expanded(
                        child: Text(
                          widget.data.title ?? '',
                          style: textNormalCustom(
                            color: textTitle,
                            fontSize: 14.0.textScale(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                if ((widget.data.childrens ?? []).isEmpty)
                  Container()
                else
                  Icon(
                    (widget.data.isShowExpanded ?? false)
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_up_rounded,
                    color: AqiColor,
                  )
              ],
            ),
          ),
        ),
        if ((widget.data.childrens ?? []).isNotEmpty)
          ExpandedSection(
            expand: widget.data.isShowExpanded ?? false,
            child: widget.childExpand ?? Container(),
          ),
      ],
    );
  }
}
