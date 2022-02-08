import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/search_name_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuaLichCongTacTrongNuocPhone extends StatefulWidget {
  const SuaLichCongTacTrongNuocPhone({Key? key}) : super(key: key);

  @override
  _SuaLichCongTacTrongNuocPhoneState createState() =>
      _SuaLichCongTacTrongNuocPhoneState();
}

class _SuaLichCongTacTrongNuocPhoneState
    extends State<SuaLichCongTacTrongNuocPhone> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  TextEditingController tieuDeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<DonViModel> list = [];

  @override
  Widget build(BuildContext context) {
    return WidgetTaoLichLVInherited(
      taoLichLamViecCubit: taoLichLamViecCubit,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all( 16),
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
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: ExpandGroup(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          height: 6,
                          width: 57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Text(
                        S.current.sua_lich_cong_tac_trong_nuoc,
                        style: textNormalCustom(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: textTitle,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormWidget(
                          controller: tieuDeController,
                          image: ImageAssets.icEdit,
                          hint: S.current.lich_cong_tac_trong_nuoc,
                        ),
                      ),
                      const LoaiLichWidget(),
                      const SearchNameWidget(),
                      StartEndDateWidget(
                        onEndDateTimeChanged: (DateTime value) {},
                        onStartDateTimeChanged: (DateTime value) {},
                      ),
                      const NhacLaiWidget(),
                      const NguoiChuTriWidget(),
                      const LinhVucWidget(),
                      TextFormWidget(
                        image: ImageAssets.icViTri,
                        hint: S.current.ubnd_tinh_dong_nai,
                      ),
                      TextFormWidget(
                        image: ImageAssets.icDocument,
                        hint: S.current.bao_cao_thuong_vu,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonSelectFile(
                        title: S.current.tai_lieu_dinh_kem,
                        onChange: (List<File> files) {
                        },
                        files: const [],
                      ),
                      ThanhPhanThamGiaWidget(
                        onChange: (value) {
                          list = value;
                        },
                        phuongThucNhan: (value) {},
                        isPhuongThucNhan: false,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: btnSuaLich(
                      name: S.current.dong,
                      bgr: buttonColor.withOpacity(0.1),
                      colorName: textDefault,
                      onTap: () {},
                    ),
                  ),

                  const SizedBox(width: 16,),

                  Expanded(
                      child: btnSuaLich(
                          name: S.current.luu,
                          bgr: labelColor,
                          colorName: Colors.white,
                          onTap: () {},),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget btnSuaLich({
  required String name,
  required Color bgr,
  required Color colorName,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgr,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorName,
        ),
      ),
    ),
  );
}
