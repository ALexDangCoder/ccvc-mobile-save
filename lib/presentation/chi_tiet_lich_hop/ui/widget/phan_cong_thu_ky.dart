import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cac_lua_chon_don_vi_widget.dart';

class PhanCongThuKyWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const PhanCongThuKyWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _PhanCongThuKyWidgetState createState() => _PhanCongThuKyWidgetState();
}

class _PhanCongThuKyWidgetState extends State<PhanCongThuKyWidget> {
  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (APP_DEVICE == DeviceType.MOBILE)
              Text(
                S.current.chon_thu_ky_cuoc_hop,
                style: textNormalCustom(color: infoColor),
              ),
            Sb(8),
            SelectThuKyWidget(cubit: widget.cubit),
            Sb(36),
            Padding(
              padding: APP_DEVICE == DeviceType.MOBILE
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 100),
              child: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.xac_nhan,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Sb(16),
          ],
        ),
      ),
    );
  }

  Widget Sb(double height) => SizedBox(
        height: height,
      );
}

class SelectThuKyWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const SelectThuKyWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SelectThuKyWidget> createState() => _SelectThuKyWidgetState();
}

class _SelectThuKyWidgetState extends State<SelectThuKyWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.cubit.chonThuKy,
      builder: (context, snapshot) {
        return SelectThuKyCell(
          controller: controller,
          listSelect: widget.cubit.thuKy,
          onDelete: (value) {
            widget.cubit.removeThuKy(value);
            setState(() {});
          },
          cubit: widget.cubit,
        );
      },
    );
  }
}

class SelectThuKyCell extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  final List<String> listSelect;
  final Function(String) onDelete;
  final TextEditingController controller;

  const SelectThuKyCell({
    Key? key,
    required this.listSelect,
    required this.onDelete,
    required this.controller,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(7.0.textScale(space: 5)),
      decoration: BoxDecoration(
        boxShadow: APP_DEVICE == DeviceType.MOBILE
            ? []
            : [
                BoxShadow(
                  color: shadowContainerColor.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                )
              ],
        border: Border.all(
          color: APP_DEVICE == DeviceType.MOBILE
              ? borderButtomColor
              : borderColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.0.textScale())),
        color: Colors.white,
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(listSelect.length + 1, (index) {
          if (index == listSelect.length) {
            return CustomDropDown(
              items: cubit.dataDropdown,
              onSelectItem: (value) {
                cubit.addThuKyToList(cubit.dataDropdown[index]);
              },
            );
          }
          final data = listSelect[index];
          return tag(
            title: data,
            onDelete: () {
              onDelete(data);
            },
          );
        }),
      ),
    );
  }

  Widget tag({required String title, required Function onDelete}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: APP_DEVICE == DeviceType.MOBILE ? bgTag : labelColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            child: Text(
              title,
              style: textNormal(
                APP_DEVICE == DeviceType.MOBILE
                    ? linkColor
                    : backgroundColorApp,
                12.0.textScale(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              onDelete();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 9.25),
              child: SvgPicture.asset(
                ImageAssets.icClose,
                width: 7.5,
                height: 7.5,
                color: APP_DEVICE == DeviceType.MOBILE
                    ? labelColor
                    : backgroundColorApp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
