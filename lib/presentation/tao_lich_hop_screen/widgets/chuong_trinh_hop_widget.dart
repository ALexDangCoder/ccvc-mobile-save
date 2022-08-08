
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/select_file2/select_file.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChuongTrinhHopWidget extends StatelessWidget {
  final TaoLichHopCubit cubit;

  const ChuongTrinhHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.chuong_trinh_hop,
                style: textNormalCustom(
                  color: titleColumn,
                  fontSize: 16.0.textScale(),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.0.textScale(space: 10),
          ),
          SolidButton(
            onTap: () {
              showDialog(context);
            },
            text: S.current.them_phien_hop,
            urlIcon: ImageAssets.icAddButtonCalenderTablet,
          ),
          spaceH16,
          StreamBuilder<List<TaoPhienHopRequest>>(
            stream: cubit.listPhienHop,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return ItemPhienHop(
                    phienHop: data[index],
                    onTapRemove: () {
                      showDiaLog(
                        context,
                        title: S.current.xoa_chuong_trinh_hop,
                        textContent: S.current.confirm_xoa_chuong_trinh_hop,
                        icon: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: redChart.withOpacity(0.1),
                          ),
                          child: ImageAssets.svgAssets(
                            ImageAssets.icDeleteRed,
                          ),
                        ),
                        btnRightTxt: S.current.dong_y,
                        btnLeftTxt: S.current.khong,
                        funcBtnRight: () {
                          data.removeAt(index);
                          cubit.listPhienHop.sink.add(data);
                        },
                      );
                    },
                    onTapEdit: () {
                      showDialog(context, index: index);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void showDialog(BuildContext context, {int index = -1}) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        child: ThemPhienHopScreen(
          cubit: cubit,
          indexEdit: index,
        ),
        title: S.current.them_phien_hop,
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.them_phien_hop,
        isBottomShow: false,
        child: ThemPhienHopScreen(
          cubit: cubit,
          indexEdit: index,
        ),
        funcBtnOk: () {},
      );
    }
  }
}

class ThemPhienHopScreen extends StatefulWidget {
  final TaoLichHopCubit cubit;
  final int indexEdit;

  const ThemPhienHopScreen({
    Key? key,
    required this.cubit,
    this.indexEdit = -1,
  }) : super(key: key);

  @override
  _ThemPhienHopScreenState createState() => _ThemPhienHopScreenState();
}

class _ThemPhienHopScreenState extends State<ThemPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  late final TaoPhienHopRequest taoPhienHopRequest;

  late String timeStart;
  late String timeEnd;
  String thoiGianHop = DateTime.now().formatApi;
  bool isOverFileLength = false;

  @override
  void initState() {
    super.initState();
    if (widget.indexEdit >= 0) {
      taoPhienHopRequest = widget.cubit.listPhienHop.value[widget.indexEdit];
    } else {
      taoPhienHopRequest = TaoPhienHopRequest(
        thoiGian_BatDau: widget.cubit.getTime(),
        thoiGian_KetThuc: widget.cubit.getTime(isGetDateStart: false),
      );
      taoPhienHopRequest.files = [];
    }
    taoPhienHopRequest.date =
        taoPhienHopRequest.thoiGian_BatDau.split(' ').first;
    timeStart = taoPhienHopRequest.thoiGian_BatDau.split(' ').last;
    timeEnd = taoPhienHopRequest.thoiGian_KetThuc.split(' ').last;
  }

  void handleButtonSaveClick() {
    if (isOverFileLength) {
      return;
    }
    // Thời gian bắt đầu phiên họp:
    final dateTimeStart = '$thoiGianHop $timeStart'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian kết thúc phiên họp:
    final dateTimeEnd = '$thoiGianHop $timeEnd'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian bắt đầu cuộc họp:
    final limitTimeStart = widget.cubit.getTime().convertStringToDate(
          formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
        );

    //Thời gian kết thúc cuộc họp:
    final limitTimeEnd =
        widget.cubit.getTime(isGetDateStart: false).convertStringToDate(
              formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
            );

    final bool isOverMeetingTime = dateTimeStart.isBefore(limitTimeStart) ||
        dateTimeEnd.isAfter(limitTimeEnd);

    final bool validateRequireField = _key.currentState?.validator() ?? false;
    final bool validateTime = _keyBaseTime.currentState?.validator() ?? false;

    if (isOverMeetingTime) {
      MessageConfig.show(
        messState: MessState.error,
        title: S.current.validate_thoi_gian_phien_hop,
      );
      return;
    }

    if (validateRequireField && validateTime) {
      taoPhienHopRequest.thoiGian_BatDau = '$thoiGianHop $timeStart';
      taoPhienHopRequest.thoiGian_KetThuc = '$thoiGianHop $timeEnd';
      taoPhienHopRequest.timeEnd = timeEnd;
      final listPhienHop = widget.cubit.listPhienHop.value;
      if (widget.indexEdit >= 0) {
        listPhienHop[widget.indexEdit] = taoPhienHopRequest;
      } else {
        listPhienHop.add(taoPhienHopRequest);
      }
      widget.cubit.listPhienHop.sink.add(listPhienHop);
      Navigator.pop(context);
    }
  }

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
            isTablet: isMobile() == false,
            onClickRight: () {
              handleButtonSaveClick();
            },
            onClickLeft: () {
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
                  title: S.current.ten_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    initialValue: taoPhienHopRequest.tieuDe,
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {
                      taoPhienHopRequest.tieuDe = value;
                    },
                    validator: (value) {
                      return value?.pleaseEnter(
                        S.current.nhap_ten_phien_hop.toLowerCase(),
                      );
                    },
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: CustomSelectDate(
                    value: taoPhienHopRequest.date?.convertStringToDate() ??
                        DateTime.now(),
                    onSelectDate: (value) {
                      thoiGianHop = value.formatApi;
                    },
                    paddings: 12,
                    leadingIcon: SvgPicture.asset(
                      isMobile()
                          ? ImageAssets.icCalenders
                          : ImageAssets.icCanlendarTablet,
                    ),
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  timeBatDau: timeStart.getTimeData(
                    timeReturnParseFail: TimerData(
                      hour: DateTime.now().hour,
                      minutes: DateTime.now().minute,
                    ),
                  ),
                  timeKetThuc: timeEnd.getTimeData(
                    timeReturnParseFail: TimerData(
                      hour: DateTime.now().hour + 1,
                      minutes: DateTime.now().minute,
                    ),
                  ),
                  key: _keyBaseTime,
                  validator: (timeBegin, timerEn) {
                    return timeBegin.equalTime(timerEn);
                  },
                  onChange: (timeBegin, timerEn) {
                    timeStart = timeBegin.timerToString;
                    timeEnd = timerEn.timerToString;
                  },
                ),
                spaceH20,
                Text(
                  S.current.nguoi_chu_tri,
                  style: textNormal(
                    titleItemEdit,
                    14.0.textScale(),
                  ),
                ),
                spaceH8,
                DropDownSearch(
                  title: S.current.nguoi_chu_tri,
                  hintText: S.current.chon_nguoi_chu_tri,
                  initSelected: taoPhienHopRequest.hoTen,
                  isShowIconDropdown: true,
                  onChange: (index) {
                    final DonViModel donVi =
                        widget.cubit.listThanhPhanThamGia.toList()[index];
                    taoPhienHopRequest.canBoId =
                        donVi.canBoId.isNotEmpty ? donVi.canBoId : null;
                    taoPhienHopRequest.donViId = donVi.donViId.isNotEmpty
                        ? donVi.donViId
                        : donVi.id.isNotEmpty
                            ? donVi.id
                            : null;
                    taoPhienHopRequest.hoTen = donVi.tenCanBo.isNotEmpty
                        ? donVi.tenCanBo
                        : donVi.name.isNotEmpty
                            ? donVi.name
                            : '';
                    taoPhienHopRequest.uuid = donVi.uuid;
                  },
                  listSelect: widget.cubit.getListTenCanBo(),
                ),
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    initialValue: taoPhienHopRequest.noiDung,
                    maxLine: 5,
                    onChange: (value) {
                      taoPhienHopRequest.noiDung = value;
                    },
                    validator: (value) {
                      return value?.pleaseEnter(
                        S.current.noi_dung_phien_hop,
                      );
                    },
                  ),
                ),
                spaceH20,
                SelectFileBtn2(
                  onChange: (files) {
                    taoPhienHopRequest.listFileBytes = files;
                  },
                  initFileSystem: taoPhienHopRequest.listFileBytes,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemPhienHop extends StatelessWidget {
  const ItemPhienHop({
    Key? key,
    required this.phienHop,
    required this.onTapRemove,
    required this.onTapEdit,
  }) : super(key: key);
  final TaoPhienHopRequest phienHop;
  final Function onTapRemove;
  final Function onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Text(
                  phienHop.tieuDe,
                  style: textNormal(color3D5586, 16).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: '${phienHop.thoiGian_BatDau}'
                    '${phienHop.timeEnd?.isNotEmpty ?? false ? ''
                    ' - ${phienHop.timeEnd}' : ''}',
                key: S.current.thoi_gian,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: phienHop.hoTen,
                key: S.current.nguoi_phu_trach,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                key: S.current.noi_dung,
                value: phienHop.noiDung,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.file,
                      style: textNormal(infoColor, 14.0.textScale()),
                    ),
                  ),
                  spaceW8,
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        phienHop.listFileBytes?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            phienHop.listFileBytes?[index].path
                                    .convertNameFile() ??
                                '',
                            style: textNormalCustom(
                              color: color5A8DEE,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0.textScale(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onTapEdit();
                  },
                  child: SvgPicture.asset(ImageAssets.ic_edit),
                ),
                spaceW12,
                GestureDetector(
                  onTap: () {
                    onTapRemove();
                  },
                  child: SvgPicture.asset(ImageAssets.icDeleteRed),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
