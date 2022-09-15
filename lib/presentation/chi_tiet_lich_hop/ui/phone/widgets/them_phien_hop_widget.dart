import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/selecdate_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  bool isOverFileLength = false;
  late String timeStart;
  late String timeEnd;
  String thoiGianHop = '';
  bool isShowValidate = false;
  late final TaoPhienHopRequest taoPhienHopRequest;

  @override
  void initState() {
    super.initState();
    taoPhienHopRequest = TaoPhienHopRequest(
      thoiGian_BatDau: widget.cubit.getTime(),
      thoiGian_KetThuc: widget.cubit.getTime(isGetDateStart: false),
    );
    timeStart = widget.cubit.getChiTietLichHopModel.timeStart;
    timeEnd = widget.cubit.getChiTietLichHopModel.timeTo;
    thoiGianHop =
        coverDateTimeApi(widget.cubit.getChiTietLichHopModel.ngayBatDau)
            .split(' ')
            .first;
    handleButtonSaveClick();
  }

  String getTime({bool isGetDateStart = true}) {
    return isGetDateStart
        ? '${widget.cubit.getChiTietLichHopModel.ngayBatDau.split(' ').first} '
            '${widget.cubit.getChiTietLichHopModel.timeStart}'
        : '${widget.cubit.getChiTietLichHopModel.ngayKetThuc.split(' ').first} '
            '${widget.cubit.getChiTietLichHopModel.timeTo}';
  }

  void handleButtonSaveClick() {
    // Thời gian bắt đầu phiên họp:
    final dateTimeStart = '$thoiGianHop $timeStart'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian kết thúc phiên họp:
    final dateTimeEnd = '$thoiGianHop $timeEnd'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian bắt đầu cuộc họp:
    final limitTimeStart = getTime().convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_HM,
    );

    //Thời gian kết thúc cuộc họp:
    final limitTimeEnd = getTime(isGetDateStart: false).convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_HM,
    );

    final bool isOverMeetingTime = dateTimeStart.isBefore(limitTimeStart) ||
        dateTimeEnd.isAfter(limitTimeEnd);
    final bool validateTime = _keyBaseTime.currentState?.validator() ?? false;

    if (validateTime) {
      widget.cubit.isValidateTimer.sink.add(isOverMeetingTime);
      isShowValidate = isOverMeetingTime;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardEdt(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),

          /// hai button
          child: DoubleButtonBottom(
            onClickRight: () {
              final validateTime =
                  widget.cubit.isValidateTimer.valueOrNull ?? true;
              if ((_key.currentState?.validator() ?? false) &&
                  !isOverFileLength &&
                  !validateTime) {
                taoPhienHopRequest.thoiGian_BatDau = '$thoiGianHop $timeStart';
                taoPhienHopRequest.thoiGian_KetThuc = '$thoiGianHop $timeEnd';
                taoPhienHopRequest.timeEnd = timeEnd;
                taoPhienHopRequest.tieuDe.trim();
                widget.cubit.themPhienHop(
                  id: widget.id,
                  taoPhienHopRequest: taoPhienHopRequest,
                );
                Navigator.pop(context);
              }
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
                /// them phien hop
                InputInfoUserWidget(
                  title: S.current.ten_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {
                      taoPhienHopRequest.tieuDe = value;
                    },
                    validator: (value) {
                      return value?.checkNull(
                        showText: S.current.vui_long_nhap_ten_phien_hop,
                      );
                    },
                  ),
                ),

                /// thoi gian hop
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: SelectDateWidget(
                    paddings: 10,
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                    value: thoiGianHop,
                    onSelectDate: (dateTime) {
                      if (mounted) setState(() {});
                      thoiGianHop = dateTime.changeToNewPatternDate(
                        DateTimeFormat.DEFAULT_FORMAT,
                        DateTimeFormat.DOB_FORMAT,
                      );
                      handleButtonSaveClick();
                    },
                  ),
                ),
                spaceH20,
                SizedBox(
                  child: StreamBuilder<bool>(
                    stream: widget.cubit.isValidateTimer.stream,
                    builder: (context, snapshot) {
                      return ShowRequied(
                        paddingLeft: 0,
                        isShow: snapshot.data ?? true,
                        textShow: S.current.validata_phien_hop,
                        child: BaseChooseTimerWidget(
                          key: _keyBaseTime,
                          timeBatDau: timeStart.getTimeData(
                            timeReturnParseFail: TimerData(
                              hour: DateTime.now().hour,
                              minutes: DateTime.now().minute,
                            ),
                          ),
                          isCheckRemoveDidUpdate: true,
                          timeKetThuc: timeEnd.getTimeData(
                            timeReturnParseFail: TimerData(
                              hour: DateTime.now().hour,
                              minutes: DateTime.now().minute,
                            ),
                          ),
                          onChange: (start, end) {
                            timeStart = start.timerToString;
                            timeEnd = end.timerToString;
                            handleButtonSaveClick();
                          },
                          validator: (timeBegin, timerEn) {
                            return timeBegin.equalTime(timerEn);
                          },
                        ),
                      );
                    },
                  ),
                ),

                /// chon nguoi chu tri
                StreamBuilder<List<NguoiChutriModel>>(
                  stream: widget.cubit.listNguoiCHuTriModel.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return InputInfoUserWidget(
                      title: S.current.nguoi_chu_tri,
                      child: DropDownSearch(
                        isShowIconDropdown: true,
                        title: S.current.nguoi_chu_tri,
                        hintText: S.current.chon_nguoi_chu_tri,
                        onChange: (value) {
                          taoPhienHopRequest.hoTen =
                              (data[value].hoTen ?? '').isNotEmpty
                                  ? data[value].hoTen ?? ''
                                  : data[value].dauMoiLienHe ?? '';
                        },
                        listSelect: data.map(
                          (value) {
                            final name = (value.hoTen ?? '').isNotEmpty
                                ? value.hoTen
                                : value.dauMoiLienHe ?? '';
                            return name?.isNotEmpty ?? false
                                ? name ?? ''
                                : value.tenCoQuan ?? '';
                          },
                        ).toList(),
                      ),
                    );
                  },
                ),
                /// nội dung phiên họp
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    maxLine: 5,
                    onChange: (value) {
                      taoPhienHopRequest.noiDung = value;
                    },
                    validator: (value) {
                      return value?.checkNull(
                        showText: S.current.vui_long_nhap_noi_dung_phien_hop,
                      );
                    },
                  ),
                ),
                spaceH20,

                /// thêm tài liệu

                SelectFileBtn(
                  onChange: (files) {
                    taoPhienHopRequest.files = files;
                  },
                  maxSize: MaxSizeFile.MAX_SIZE_20MB.toDouble(),
                  initFileSystem: taoPhienHopRequest.files ?? [],
                  onDeletedFileApi: (fileDeleted) {
                    widget.cubit.filesDelete.add(
                      fileDeleted.id ?? '',
                    );
                  },
                  allowedExtensions: const [
                    FileExtensions.DOC,
                    FileExtensions.DOCX,
                    FileExtensions.JPEG,
                    FileExtensions.JPG,
                    FileExtensions.PDF,
                    FileExtensions.PNG,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
