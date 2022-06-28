import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DangKyThongTinXeMoi extends StatelessWidget {
  const DangKyThongTinXeMoi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiemDanhCubit cubit=DiemDanhCubit();
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.dang_ky_thong_tin_xe_moi,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorE2E8F0),
                      borderRadius: BorderRadius.circular(8.0),
                      color: colorFFFFFF,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icUpAnh,
                          color: color7966FF,
                        ),
                        spaceH14,
                        Text(
                          S.current.tai_anh_len,
                          style: textNormal(
                            color667793,
                            14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH12,
                  Text(
                    S.current.giay_dang_ky_xe,
                    style: textNormalCustom(
                      color: color3D5586,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH20,
                  ItemTextNote(title: S.current.loai_xe),
                  StreamBuilder<List<LoaiXeModel>>(
                    initialData: [ LoaiXeModel(ten: S.current.xe_may),
                      LoaiXeModel(ten: S.current.xe_o_to),],
                    stream: cubit.loaiXeSubject,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return CoolDropDown(
                        initData: data.map((e) => e.ten??'').first,
                        listData: data.map((e) => e.ten ?? '').toList(),
                        onChange: (vl) {},
                      );
                    },),
                  spaceH20,
                  ItemTextNote(title: S.current.bien_kiem_soat),
                  TextFieldValidator(
                    hintText: S.current.bien_kiem_soat,
                    onChange: (value) {},
                    validator: (value) {},
                  ),
                  spaceH20,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.loai_so_huu,
                      style: textNormalCustom(
                        color: color3D5586,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  CustomRadioLoaiSoHuu(onchange: (onchange) {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: DoubleButtonBottom(
                  title1: S.current.huy_bo,
                  title2: S.current.them_moi,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
