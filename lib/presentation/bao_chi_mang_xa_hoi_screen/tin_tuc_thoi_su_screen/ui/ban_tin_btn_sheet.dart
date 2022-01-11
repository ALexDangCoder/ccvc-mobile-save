import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/item_list_bang_tin.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BanTinBtnSheet extends StatefulWidget {
  const BanTinBtnSheet({Key? key}) : super(key: key);

  @override
  _BanTinBtnSheetState createState() => _BanTinBtnSheetState();
}

class _BanTinBtnSheetState extends State<BanTinBtnSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.93,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 6,
              width: 57,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
          Text(
            S.current.ban_tin_trua_ngay,
            style: textNormalCustom(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: titleColor,
            ),
          ),
          Slider(
              value: 5,
              min: 0.0,
              max: 20,
              activeColor: labelColor,
              inactiveColor: borderButtomColor,
              onChanged: (value) {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      color: unselectLabelColor,
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous)),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(ImageAssets.icPlay),
                  ),
                  IconButton(
                      color: unselectLabelColor,
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next)),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_up),
                    color: unselectLabelColor,
                  )
                ],
              ),
              Text(
                S.current.time_play,
                style: textNormalCustom(
                    color: AqiColor, fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ItemListBangTin(
                  tin:
                      'Hướng dẫn xác định ca mắc COVID và khỏi bệnh bằng test nhanh',
                  isCheck: false),
              ItemListBangTin(
                  tin:
                      'Hướng dẫn xác định ca mắc COVID và khỏi bệnh bằng test nhanh',
                  isCheck: false),
              ItemListBangTin(
                  tin:
                      'Hướng dẫn xác định ca mắc COVID và khỏi bệnh bằng test nhanh',
                  isCheck: true),
              ItemListBangTin(
                  tin:
                      'Hướng dẫn xác định ca mắc COVID và khỏi bệnh bằng test nhanh',
                  isCheck: false),
              ItemListBangTin(
                  tin:
                      'Hướng dẫn xác định ca mắc COVID và khỏi bệnh bằng test nhanh',
                  isCheck: false),
            ],
          )
        ],
      ),
    );
  }
}
