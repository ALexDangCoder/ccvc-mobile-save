import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/cap_nhat_thong_tin_khach/LoaiTheModel.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/bloc/cap_nhat_thong_tin_khach_hang_cubit.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinKhachVaoCoQuanScreen extends StatefulWidget {
 final CheckIdCardModel checkIdCardModel;
   ThongTinKhachVaoCoQuanScreen({Key? key, required this.checkIdCardModel}) : super(key: key);

  @override
  _ThongTinKhachVaoCoQuanScreenState createState() =>
      _ThongTinKhachVaoCoQuanScreenState();
}

class _ThongTinKhachVaoCoQuanScreenState
    extends State<ThongTinKhachVaoCoQuanScreen> {
  final CapNhatThongTinKhachHangCubit cubit = CapNhatThongTinKhachHangCubit();
  final ScrollController scrollController = ScrollController();
  final TextEditingController hoTenEditingController = TextEditingController();
  final TextEditingController soCmndEditingController = TextEditingController();
  final TextEditingController idTheVaoEditingController =
      TextEditingController();
  final TextEditingController coQuanToChucEditingController =
      TextEditingController();
  final TextEditingController nguoiTiepDonEditingController =
      TextEditingController();
  final TextEditingController nhapLyDoEditingController =
      TextEditingController();

  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    cubit.postThongTinKhach();
    super.initState();
    hoTenEditingController.text=widget.checkIdCardModel.frontContent?.content?.name??'';
    soCmndEditingController.text=widget.checkIdCardModel.frontContent?.content?.id??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.thong_tin_khach_vao_co_quan),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        controller: scrollController,
        child: FormGroup(
          scrollController: scrollController,
          key: keyGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  S.current.thong_tin_cmnd_cccd,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().colorField(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InputInfoUserWidget(
                title: S.current.ho_va_ten,
                isObligatory: true,
                child: TextFieldValidator(
                  hintText: S.current.ho_va_ten,
                  controller: hoTenEditingController,
                  maxLength: 255,
                  validator: (value) {
                    return (value ?? '').checkTruongNull(S.current.ho_va_ten);
                  },
                ),
              ),
              StreamBuilder<List<LoaiTheModel>>(
                initialData: [
                  LoaiTheModel(ten: S.current.chung_minh_nhan_dan),
                  LoaiTheModel(ten: S.current.can_cuoc_cong_dan),
                ],
                stream: cubit.loaiTheSubject.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return InputInfoUserWidget(
                    title: S.current.loai_the,
                    child: CoolDropDown(
                      onChange: (value) {},
                      initData: S.current.chung_minh_nhan_dan,
                      listData: data.map((e) => e.ten ?? '').toList(),
                    ),
                  );
                },
              ),
              InputInfoUserWidget(
                title: '${S.current.so} ${S.current.cmnd}',
                child: TextFieldValidator(
                  hintText: '${S.current.so} ${S.current.cmnd}',
                  controller: soCmndEditingController,
                  maxLength: 255,
                  validator: (value) {
                    return (value ?? '')
                        .checkTruongNull('${S.current.so} ${S.current.cmnd}');
                  },
                ),
              ),
              InputInfoUserWidget(
                title: S.current.ngay_sinh,
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                  value: DateTime.now().toString(),
                  onSelectDate: (dateTime) {},
                ),
              ),
              InputInfoUserWidget(
                title: S.current.gioi_tinh,
                child: CoolDropDown(
                  key: UniqueKey(),
                  initData: widget.checkIdCardModel.frontContent?.content?.gender??'',
                  placeHoder: S.current.gioi_tinh,
                  onChange: (value) {},
                  listData: cubit.dataGioiTinh,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  S.current.thong_tin_khach,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().colorField(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InputInfoUserWidget(
                title: S.current.id_the_vao,
                child: TextFieldValidator(
                  hintText: S.current.id_the_vao,
                  controller: idTheVaoEditingController,
                  maxLength: 20,
                ),
              ),
              InputInfoUserWidget(
                title: S.current.co_quan_to_chuc,
                child: TextFieldValidator(
                  hintText: S.current.nhap_ten_day_du_co_quan,
                  controller: coQuanToChucEditingController,
                  maxLength: 255,
                ),
              ),
              InputInfoUserWidget(
                isObligatory: true,
                title: S.current.nguoi_tiep_don,
                child: TextFieldValidator(
                  hintText: S.current.nhap_ten_nguoi_don,
                  controller: nguoiTiepDonEditingController,
                  maxLength: 255,
                  validator: (value) {
                    return (value ?? '')
                        .checkTruongNull(S.current.nguoi_tiep_don);
                  },
                ),
              ),
              InputInfoUserWidget(
                isObligatory: true,
                title: S.current.ly_do_vao_co_quan,
                child: TextFieldValidator(
                  hintText:  S.current.nhap_ly_do,
                  controller: nhapLyDoEditingController,
                  maxLength: 255,
                  validator: (value) {
                    return (value ?? '').checkTruongNull(S.current.nhap_ly_do);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24, top: 16),
                child: ButtonBottom(
                  customColor: true,
                  onPressed: () {
                    if (keyGroup.currentState?.validator() ?? true) {
                    } else {
                      return;
                    }
                  },
                  text: S.current.gui,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
