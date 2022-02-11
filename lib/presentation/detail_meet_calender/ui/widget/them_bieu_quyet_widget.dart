import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/cac_lua_chon_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_hour_widget.dart';
import 'package:ccvc_mobile/presentation/edit_hdsd/ui/widget/block_textview.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/radio/cuctom_radio_check.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaoBieuQuyetWidget extends StatefulWidget {
  const TaoBieuQuyetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TaoBieuQuyetWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TaoBieuQuyetWidget> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final cubit = DetailMeetCalendarInherited.of(context).cubit;
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 24),
              child: Text(
                S.current.loai_bieu_quyet,
                style: tokenDetailAmount(
                  color: dateColor,
                  fontSize: 14.0,
                ),
              ),
            ),
            StreamBuilder<int>(
              initialData: 1,
              stream: cubit.checkRadioStream,
              builder: (context, snapshot) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRadioButtonCheck(
                      isCheck: snapshot.data == 1 ? true : false,
                      allowUnSelect: true,
                      title: S.current.bo_khieu_kin,
                      onSelectItem: (item) {
                        cubit.checkRadioButton(1);
                      },
                      canSelect: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomRadioButtonCheck(
                      isCheck: snapshot.data == 2 ? true : false,
                      allowUnSelect: true,
                      title: S.current.bo_phieu_cong_khai,
                      onSelectItem: (item) {
                        cubit.checkRadioButton(2);
                      },
                      canSelect: true,
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputInfoUserWidget(
                isObligatory: true,
                title: S.current.ngay_bieu_quyet,
                child: CustomSelectDate(
                  leadingIcon: SvgPicture.asset(ImageAssets.icCalendarUnFocus),
                  // value: cubit.managerPersonalInformationModel.ngaySinh,
                  onSelectDate: (dateTime) {
                    // cubit.selectBirthdayEvent(dateTime.toString());
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSelectHour(
                        onSelectDate: (value) {},
                        leadingIcon: SvgPicture.asset(ImageAssets.icTimer),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Text(
                        S.current.den,
                        style: textNormalCustom(
                          color: infoColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomSelectHour(
                        onSelectDate: (value) {},
                        leadingIcon: SvgPicture.asset(ImageAssets.icTimer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: BlockTextView(
                isObligatory: true,
                formKey: formKeyNoiDung,
                contentController: noiDungController,
                title: S.current.ten_bieu_quyet,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: InputInfoUserWidget(
                isObligatory: true,
                title: S.current.cac_lua_chon_bieu_quyet,
                child: CacLuaChonDonViWidget(detailMeetCalenderCubit: cubit),
              ),
            ),
            NguoiThamGiaWidget(title: 'Lê Sĩ Lâm - Văn thư - UBND TỈNH ĐỒNG NAI'),
            // ListView.builder(
            //   itemCount: 1,
            //   itemBuilder: (context, index) {
            //     // return NguoiThamGiaWidget(title: '');
            //     return Container();
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32, top: 24),
              child: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.luu,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
