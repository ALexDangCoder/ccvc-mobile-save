import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaTLWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final List<DonViModel>? listPeopleInit;
  final bool isEditCalendarWord;
  final ChiTietLichLamViecCubit? chiTietLichLamViecCubit;

  const ThanhPhanThamGiaTLWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    this.listPeopleInit,
    this.isEditCalendarWord = false,
    this.chiTietLichLamViecCubit,
  }) : super(key: key);

  @override
  _ThanhPhanThamGiaTLWidgetState createState() =>
      _ThanhPhanThamGiaTLWidgetState();
}

class _ThanhPhanThamGiaTLWidgetState extends State<ThanhPhanThamGiaTLWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.thanh_phan_tham_gia,
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.textScale(),
                  color: color667793,
                ),
              ),
              if (isExpand)
                const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AqiColor,
                )
              else
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AqiColor,
                )
            ],
          ),
        ),
        SizedBox(
          height: 16.5.textScale(),
        ),
        ExpandedSection(
          expand: isExpand,
          child: ThanhPhanThamGiaWidget(
            isEditCalendarWord: widget.isEditCalendarWord,
            listPeopleInit: widget.listPeopleInit,
            onChange: (value) {
              widget.taoLichLamViecCubit.donviModel = value;
            },
            phuongThucNhan: (value) {},
            isPhuongThucNhan: false,
          ),
        )
      ],
    );
  }
}
