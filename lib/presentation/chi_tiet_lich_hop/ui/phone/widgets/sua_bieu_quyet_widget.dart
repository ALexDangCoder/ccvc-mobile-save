import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/check_box_list_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/custom_radio_sua_bieu_quyet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/danh_sach_lua_chon_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/selecdate_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SuaBieuQuyetWidget extends StatefulWidget {
  final String idBieuQuyet;
  final DetailMeetCalenderCubit cubit;

  const SuaBieuQuyetWidget({
    Key? key,
    required this.idBieuQuyet,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SuaBieuQuyetWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<SuaBieuQuyetWidget> {
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  final keyGroup = GlobalKey<FormGroupState>();
  bool isShow = false;
  bool isShowValidate = false;
  bool isShowValidateDanhSach = false;
  late String timeStart;
  late String timeEnd;
  String thoiGianHop = '';

  @override
  void initState() {
    super.initState();
    widget.cubit.clearData();
    widget.cubit.chiTietBieuQuyet(idBieuQuyet: widget.idBieuQuyet);
    timeStart = widget.cubit.getChiTietLichHopModel.timeStart;
    timeEnd = widget.cubit.getChiTietLichHopModel.timeTo;
    thoiGianHop =
        widget.cubit.getChiTietLichHopModel.ngayBatDau.changeToNewPatternDate(
      DateTimeFormat.DATE_TIME_HM,
      DateTimeFormat.DATE_TIME_PUT_EDIT,
    );
    widget.cubit.chiTietBieuQuyetSubject.listen((value) {
      noiDungController.text = value.data?.noiDung ?? '';
      widget.cubit.loaiBieuQ = value.data?.loaiBieuQuyet ?? true;
      widget.cubit.lisLuaChonOld = value.data?.dsLuaChon ?? [];
      widget.cubit.listThanhPhanThamGiaOld =
          value.data?.dsThanhPhanThamGia ?? [];
      timeEnd = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
          .parse(value.data?.thoiGianKetThuc ?? '')
          .formatTime;
      timeStart = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
          .parse(value.data?.thoiGianBatDau ?? '')
          .formatTime;
      thoiGianHop = DateFormat(DateTimeFormat.DATE_TIME_RECEIVE)
          .parse(value.data?.thoiGianBatDau ?? '')
          .formatApi;
      handleButtonSaveClick();
    });
  }

  void handleButtonSaveClick() {
    // Thời gian bắt đầu bieu quyet:
    final dateTimeStart = '$thoiGianHop $timeStart'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian kết thúc bieu quyet:
    final dateTimeEnd = '$thoiGianHop $timeEnd'.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    //Thời gian bắt đầu cuộc họp:
    final limitTimeStart = widget.cubit.getTime().convertStringToDate(
          formatPattern: DateTimeFormat.DATE_TIME_HM,
        );

    //Thời gian kết thúc cuộc họp:
    final limitTimeEnd =
        widget.cubit.getTime(isGetDateStart: false).convertStringToDate(
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
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: FormGroup(
        key: keyGroup,
        child: StreamBuilder<ChiTietBieuQuyetModel>(
          initialData: ChiTietBieuQuyetModel(),
          stream: widget.cubit.chiTietBieuQuyetSubject.stream,
          builder: (context, snapshot) {
            final dataChiTiet = snapshot.data ?? ChiTietBieuQuyetModel();
            return FollowKeyBoardWidget(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH20,
                    CustomRadioSuaBieuQuyet(
                      initValue: widget.cubit.checkLoaiBieuQuyet(
                        loaiBieuQuyet: widget.cubit.loaiBieuQ,
                      ),
                      title: S.current.loai_bieu_quyet,
                      onchange: (value) {
                        widget.cubit.loaiBieuQ = value;
                      },
                      key: UniqueKey(),
                    ),
                    InputInfoUserWidget(
                      title: S.current.ngay_bieu_quyet,
                      isObligatory: true,
                      child: SelectDateWidget(
                        paddings: 10,
                        leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                        value: widget.cubit.paserDateTime(
                          widget.cubit.getChiTietLichHopModel.ngayBatDau,
                        ),
                        onSelectDate: (dateTime) {
                          if (mounted) setState(() {});
                          widget.cubit.date = dateTime;
                          thoiGianHop = dateTime.changeToNewPatternDate(
                            DateTimeFormat.DEFAULT_FORMAT,
                            DateTimeFormat.DOB_FORMAT,
                          );
                          handleButtonSaveClick();
                        },
                      ),
                    ),
                    spaceH20,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        child: StreamBuilder<bool>(
                          stream: widget.cubit.isValidateTimer,
                          builder: (context, snapshot) {
                            return ShowRequied(
                              isShow: snapshot.data ?? true,
                              textShow: S.current.validate_bieu_quyet,
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
                    ),
                    BlockTextViewLich(
                      formKey: formKeyNoiDung,
                      contentController: noiDungController,
                      maxLenght: 255,
                      title: S.current.ten_bieu_quyet,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '${S.current.vui_long_nhap}'
                              ' ${S.current.ten_bieu_quyet}';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ShowRequied(
                        isShow: isShow,
                        textShow: '${S.current.vui_long_nhap}'
                            ' ${S.current.cac_lua_chon_bieu_quyet}',
                        child: InputInfoUserWidget(
                          isObligatory: true,
                          title: S.current.cac_lua_chon_bieu_quyet,
                          child: DanhSachLuaChonWidget(
                            initData: widget.cubit.getListLuaChon(
                              dataChiTiet.data?.dsLuaChon ?? [],
                            ),
                            detailMeetCalenderCubit: widget.cubit,
                            onchange: (value) {
                              if (value.isEmpty) {
                                isShow = true;
                                setState(() {});
                              } else {
                                isShow = false;
                                setState(() {});
                              }
                              widget.cubit.listLuaChonNew = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: widget.cubit.isValidateSubject,
                      builder: (context, snapshot) {
                        return ShowRequied(
                          isShow: snapshot.data ?? true,
                          textShow: '${S.current.vui_long_chon_bieu_quyet}'
                              ' ${S.current.thanh_phan_bieu_quyet}',
                          child: InputInfoUserWidget(
                            isObligatory: true,
                            title: S.current.thanh_phan_bieu_quyet,
                            child:
                                StreamBuilder<List<DanhSachNguoiThamGiaModel>>(
                              stream: widget.cubit.nguoiThamGiaSubject,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? [];
                                if (data.isNotEmpty) {
                                  return CheckBoxSuaBieuQuyet(
                                    urlIcon: ImageAssets.icDocument,
                                    title: S.current.loai_bai_viet,
                                    onChange: (value) {
                                      if (value.isEmpty) {
                                        widget.cubit.isValidateSubject.sink
                                            .add(true);
                                        isShowValidateDanhSach = true;
                                      } else {
                                        widget.cubit.isValidateSubject.sink
                                            .add(false);
                                        isShowValidateDanhSach = false;
                                      }
                                      widget.cubit.listDanhSach = value;
                                    },
                                    dataNguoiThamGia: data,
                                    initData:
                                        widget.cubit.listThanhPhanThamGiaOld,
                                    cubit: widget.cubit,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    DoubleButtonBottom(
                      isTablet: true,
                      title1: S.current.dong,
                      title2: S.current.luu,
                      onClickLeft: () {
                        Navigator.pop(context);
                      },
                      onClickRight: () async {
                        final listLuaChonNew =
                            widget.cubit.suaDanhSachLuaChon.valueOrNull ?? [];
                        bool isCheckCallApi = true;
                        final nav = Navigator.of(context);
                        if (isShowValidate) {
                          isCheckCallApi = false;
                          widget.cubit.isValidateTimer.sink.add(true);
                        }
                        if (noiDungController.text.isEmpty) {
                          isCheckCallApi = false;
                          formKeyNoiDung.currentState!.validate();
                        }
                        if (listLuaChonNew.isEmpty) {
                          isCheckCallApi = false;
                          setState(() {});
                          isShow = true;
                        }
                        if (widget.cubit.listDanhSach.isEmpty) {
                          widget.cubit.isValidateSubject.sink.add(true);
                          isCheckCallApi = false;
                        }
                        if (isCheckCallApi) {
                          await widget.cubit.suaBieuQuyet(
                            idBieuQuyet: widget.idBieuQuyet,
                            lichHopId: widget.cubit.idCuocHop,
                            loaiBieuQuyets: widget.cubit.loaiBieuQ,
                            noiDung: noiDungController.text,
                            quyenBieuQuyet: true,
                            thoiGianBatDau: widget.cubit
                                .dateTimeFormat(thoiGianHop, timeStart),
                            thoiGianKetThuc: widget.cubit
                                .dateTimeFormat(thoiGianHop, timeEnd),
                            danhSachLuaChonNew:
                                widget.cubit.paserListLuaChonNew(
                              listLuaChonNew,
                            ),
                            danhSachThanhPhanThamGia: [],
                            ngayHop: thoiGianHop,
                            isPublish: widget.cubit.loaiBieuQ,
                            dsLuaChonOld: widget.cubit.paserListLuaChon(
                              widget.cubit.lisLuaChonOld,
                            ),
                            thanhPhanThamGiaOld:
                                widget.cubit.paserThanhPhanThamGia(
                              widget.cubit.listThanhPhanThamGiaOld,
                            ),
                            dateStart: DateFormat(DateTimeFormat.DOB_FORMAT)
                                .parse(thoiGianHop)
                                .formatStartTimeSuaBieuQuyet,
                            danhSachThanhPhanThamGiaNew:
                                widget.cubit.paserThanhPhanThamGiaNew(
                              widget.cubit.listDanhSach,
                            ),
                          );
                          nav.pop(true);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
