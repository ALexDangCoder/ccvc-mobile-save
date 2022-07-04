import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
import 'package:flutter/material.dart';

class DropDownTrangThaiPAKN extends StatefulWidget {
  const DropDownTrangThaiPAKN({Key? key}) : super(key: key);

  @override
  State<DropDownTrangThaiPAKN> createState() => _DropDownTrangThaiPAKNState();
}

class _DropDownTrangThaiPAKNState extends State<DropDownTrangThaiPAKN> {

  bool showDropDown = false;
  Color colorBgDefault = AppTheme.getInstance().dfBtnColor();
  String defaultDropdown = S.current.chon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
         _item(colorBG: colorBgDefault, title: defaultDropdown, callBack: () {
          showDropDown =! showDropDown;
          setState(() {

          });
        },),
        if (showDropDown) Positioned(right: 0, top: 0,child: _dropDownTrangThai()) else Container(),
      ],
    );
  }

  Container _dropDownTrangThai() {
    return Container(
    width: 218,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      color: AppTheme.getInstance().dfBtnTxtColor(),
    ),
    child: Column(
      children: [
        ExpandPAKNWidget(
          name: S.current.tiep_nhan,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH12,
              _item(
                callBack: () {},
                colorBG: AppTheme.getInstance().choXuLyColor(),
                title: S.current.cho_tiep_nhan,
              ),
              spaceH16,
              _item(
                callBack: () {

                },
                colorBG: AppTheme.getInstance().subTitleColor(),
                title: S.current.phan_xu_ly,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: textColorForum,
                title: S.current.dang_xu_ly,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: AppTheme.getInstance().choXuLyColor(),
                title: S.current.cho_tao_van_ban_di,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: daXuLyColor,
                title: S.current.da_cho_van_ban_di,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: daXuLyColor,
                title: S.current.da_hoan_thanh,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: AppTheme.getInstance().choXuLyColor(),
                title: S.current.cho_bo_sung_thong_tin,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: redChart,
                title: S.current.bi_tu_choi_tiep_nhan,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: redChart,
                title: S.current.bi_huy_bo,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: purpleChart,
                title: S.current.chuyen_xu_ly,
              ),
            ],
          ),
        ),
        spaceH20,
        ExpandPAKNWidget(
          name: S.current.xu_ly,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH12,
              _item(
                callBack: () {  },
                colorBG: AppTheme.getInstance().choXuLyColor(),
                title: S.current.cho_tiep_nhan_xu_ly,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: AppTheme.getInstance().choXuLyColor(),
                title: S.current.cho_phan_cong_xu_ly,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: daXuLyColor,
                title: S.current.da_phan_cong,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: textColorForum,
                title: S.current.cho_xu_ly,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: textColorForum,
                title: S.current.cho_duyet,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: textColorForum,
                title: S.current.cho_tao_van_ban_di,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: greenChart,
                title: S.current.da_cho_van_ban_di,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: greenChart,
                title: S.current.da_hoan_thanh,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: textColorForum,
                title: S.current.cho_cho_y_kien,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: greenChart,
                title: S.current.da_cho_y_kien,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: redChart,
                title: S.current.thu_hoi,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: redChart,
                title: S.current.tra_lai,
              ),
              spaceH16,
              _item(
                callBack: () {  },
                colorBG: purpleChart,
                title: S.current.chuyen_xu_ly,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  }

  Widget _item({
    required Color colorBG,
    required String title,
    required Function() callBack,
  }) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: colorBG,
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              color: AppTheme.getInstance().dfBtnTxtColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

