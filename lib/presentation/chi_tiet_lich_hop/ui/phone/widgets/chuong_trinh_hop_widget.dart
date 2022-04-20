import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChuongTrinhHopWidget extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  final String id;

  const ChuongTrinhHopWidget({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: ExpandOnlyWidget(
        header: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.transparent,
          child: Row(
            children: [
              Text(
                S.current.chuong_trinh_hop,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SolidButton(
              onTap: () {
                showBottomSheetCustom(
                  context,
                  child: ThemPhienHopScreen(
                    id: id,
                    cubit: cubit,
                  ),
                  title: S.current.them_phien_hop,
                );
              },
              text: S.current.them_phien_hop,
              urlIcon: ImageAssets.icAddButtonCalenderTablet,
            ),
            const SizedBox(
              height: 24,
            ),
            StreamBuilder<List<ListPhienHopModel>>(
              stream: cubit.danhSachChuongTrinhHop.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CellDetailMeet(
                      listPhienHopModel: data[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolidButton(
              onTap: () {
                showDiaLogTablet(
                  context,
                  title: S.current.them_phien_hop,
                  child: ThemPhienHopScreen(
                    cubit: cubit,
                    id: id,
                  ),
                  isBottomShow: false,
                  funcBtnOk: () {
                    Navigator.pop(context);
                  },
                );
              },
              text: S.current.them_phien_hop,
              urlIcon: ImageAssets.icAddButtonCalenderTablet,
            ),
            StreamBuilder<List<ListPhienHopModel>>(
              stream: cubit.danhSachChuongTrinhHop.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return Container();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CellDetailMeet(
                      listPhienHopModel: data[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget CellDetailMeet({required ListPhienHopModel listPhienHopModel}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: borderItemCalender),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                listPhienHopModel.tieuDe ?? '',
                style: titleAppbar(
                  fontSize: 16.0.textScale(),
                ),
              ),
              const Expanded(child: SizedBox()),
              SvgPicture.asset(ImageAssets.icEditBlue),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(ImageAssets.ic_delete_do)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        S.current.thoi_gian,
                        style: textDetailHDSD(
                          fontSize: 14.0.textScale(),
                          color: infoColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Người phụ trách',
                        style: textDetailHDSD(
                          fontSize: 14.0.textScale(),
                          color: infoColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        S.current.noi_dung,
                        style: textDetailHDSD(
                          fontSize: 14.0.textScale(),
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      listPhienHopModel.thoiGianBatDau ?? '',
                      style: textDetailHDSD(
                          fontSize: 14.0.textScale(), color: textTitle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      listPhienHopModel.hoTen ?? '',
                      style: textDetailHDSD(
                          fontSize: 14.0.textScale(), color: textTitle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      listPhienHopModel.noiDung ?? '',
                      style: textDetailHDSD(
                          fontSize: 14.0.textScale(), color: textTitle),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${S.current.file}                      ',
                style: textDetailHDSD(
                  fontSize: 14.0.textScale(),
                  color: infoColor,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listPhienHopModel.files.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data =
                        listPhienHopModel.files.map((e) => e.name).toList();
                    return Text(
                      data[index] ?? S.current.khong_co_tep_nao,
                      style: textDetailHDSD(
                        fontSize: 14.0.textScale(),
                        color: choXuLyColor,
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ThemPhienHopScreen extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const ThemPhienHopScreen({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  _ThemPhienHopScreenState createState() => _ThemPhienHopScreenState();
}

class _ThemPhienHopScreenState extends State<ThemPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: DoubleButtonBottom(
            onPressed2: () {
              _keyBaseTime.currentState?.validator();
              if (_key.currentState?.validator() ?? false) {
                widget.cubit.ThemPhienHop(widget.id);
                Navigator.pop(context);
              }

            },
            onPressed1: () {
              Navigator.pop(context);
            },
            title1: S.current.dong,
            title2: S.current.luu,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: FormGroup(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputInfoUserWidget(
                  title: S.current.them_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {
                      widget.cubit.taoPhienHopRepuest.tieuDe = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: CustomSelectDate(
                    value: DateTime.now().toString(),
                    onSelectDate: (value) {
                      widget.cubit.taoPhienHopRepuest.thoiGian_BatDau =
                          value.toString();
                      widget.cubit.taoPhienHopRepuest.thoiGian_KetThuc =
                          value.toString();
                    },
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  key: _keyBaseTime,
                  validator: () {},
                ),
                StreamBuilder<List<NguoiChutriModel>>(
                  stream: widget.cubit.listNguoiCHuTriModel.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return InputInfoUserWidget(
                      title: S.current.nguoi_chu_tri,
                      child: DropDownSearch(
                        title: S.current.nguoi_chu_tri,
                        hintText: S.current.chon_nguoi_chu_tri,
                        onChange: (value) {
                          widget.cubit.taoPhienHopRepuest.hoTen =
                              data[value].hoTen;
                        },
                        listSelect: data.map((e) => e.hoTen ?? '').toList(),
                      ),
                    );
                  },
                ),
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    maxLine: 5,
                    onChange: (value) {
                      widget.cubit.taoPhienHopRepuest.noiDung = value;
                    },
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                spaceH20,
                ButtonSelectFile(
                  title: S.current.tai_lieu_dinh_kem,
                  onChange: (value) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
