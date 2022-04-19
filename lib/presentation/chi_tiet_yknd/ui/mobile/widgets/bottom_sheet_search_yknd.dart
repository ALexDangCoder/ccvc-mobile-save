import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/them_don_vi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetSearchYKND extends StatefulWidget {
  const BottomSheetSearchYKND({Key? key}) : super(key: key);

  @override
  _BottomSheetSearchYKNDState createState() => _BottomSheetSearchYKNDState();
}

class _BottomSheetSearchYKNDState extends State<BottomSheetSearchYKND> {
  final ThanhPhanThamGiaCubit _cubit = ThanhPhanThamGiaCubit();
   @override
  void initState() {
    super.initState();
    _cubit.getTree();
    // _cubit.listPeopleThamGia.listen((event) {
    //   widget.onChange(event);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.don_vi,
            style: textNormalCustom(
              fontSize: 14,
              color: titleItemEdit,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          StreamBuilder<List<DonViModel>>(
            stream: _cubit.listPeopleThamGia,
            builder: (context, snapshot) {
              return ThemDonViWidget(
                cubit: _cubit,
                listSelectNode: snapshot.data ?? [],
                onChange: (value) {
                  _cubit.addPeopleThamGia(
                    value.map((e) => e.value).toList(),
                  );
                },
              );
            },
          ),
          // CustomDropDown(
          //   paddingLeft: 16,
          //   hint: Text(
          //     S.current.nhap_ten_don_vi,
          //     style: textNormalCustom(
          //       fontSize: 14,
          //       color: borderCaneder,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          //   items: [
          //     S.current.trung_binh,
          //     S.current.dat,
          //     S.current.khong_dat,
          //   ],
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                S.current.tu_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              const Text('~'),
              const SizedBox(
                width: 1,
              ),
              Text(
                S.current.den_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: DateTime.now().toString(),
                  onSelectDate: (dateTime) {},
                ),
              ),
              const SizedBox(
                width: 40,
                child: Center(
                  child: Text('~'),
                ),
              ),
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: '2022-01-01',
                  onSelectDate: (dateTime) {},
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ButtonCustomBottom(
                  title: S.current.dong,
                  isColorBlue: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: ButtonCustomBottom(
                  title: S.current.tim_kiem,
                  isColorBlue: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
