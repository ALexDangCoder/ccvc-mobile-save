import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetCapNhatThingTinDangKyXe extends StatefulWidget {
  final DiemDanhCubit cubit;

  const WidgetCapNhatThingTinDangKyXe({Key? key, required this.cubit})
      : super(key: key);

  @override
  _WidgetCapNhatThingTinDangKyXeState createState() =>
      _WidgetCapNhatThingTinDangKyXeState();
}

class _WidgetCapNhatThingTinDangKyXeState
    extends State<WidgetCapNhatThingTinDangKyXe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
          child: DoubleButtonBottom(
            title1: S.current.huy,
            title2: S.current.cap_nhat,
            onPressed1: () {},
            onPressed2: () {},
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    spaceH20,
                    Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: colorE2E8F0),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage(ImageAssets.imgBienSoXe),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: color000000.withOpacity(0.5)
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.icUpAnh,
                                  color: colorFFFFFF,
                                ),
                                spaceH14,
                                Text(
                                  S.current.tai_anh_len,
                                  style: textNormal(
                                    colorFFFFFF,
                                    14.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
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
                        stream: widget.cubit.loaiXeSubject,
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
                      initialValue: widget.cubit.bienKiemSoat,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
