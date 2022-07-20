import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/custom_checkbox_list_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cac_lua_chon_don_vi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/selecdate_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/radio/custom_radio_button.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaoBieuQuyetTabletWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const TaoBieuQuyetTabletWidget({
    Key? key,
    required this.id,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TaoBieuQuyetTabletWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TaoBieuQuyetTabletWidget> {
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
    widget.cubit.listThemLuaChon.clear();
    widget.cubit.listDanhSach = [];
    widget.cubit.isValidateSubject.sink.add(false);
    widget.cubit.isValidateTimer.sink.add(false);
    widget.cubit.date =
        coverDateTimeApi(widget.cubit.getChiTietLichHopModel.ngayBatDau);
    timeStart = widget.cubit.getChiTietLichHopModel.timeStart;
    timeEnd = widget.cubit.getChiTietLichHopModel.timeTo;
    thoiGianHop =
        coverDateTimeApi(widget.cubit.getChiTietLichHopModel.ngayBatDau)
            .split(' ')
            .first;
  }

  @override
  Widget build(BuildContext context) {
    return FormGroup(
      key: keyGroup,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: FollowKeyBoardWidget(
          bottomWidget: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DoubleButtonBottom(
              isTablet: true,
              title1: S.current.dong,
              title2: S.current.luu,
              onClickLeft: () {
                Navigator.pop(context);
              },
              onClickRight: () async {
                bool isCheckCallApi = true;
                final nav = Navigator.of(context);
                if (isShowValidate == true) {
                  isCheckCallApi = false;
                  widget.cubit.isValidateTimer.sink.add(true);
                }
                if (noiDungController.text.isEmpty) {
                  isCheckCallApi = false;
                  formKeyNoiDung.currentState!.validate();
                }
                if (widget.cubit.listThemLuaChon.isEmpty) {
                  isCheckCallApi = false;
                  setState(() {});
                  isShow = true;
                }
                if (widget.cubit.listDanhSach.isEmpty) {
                  widget.cubit.isValidateSubject.sink.add(true);
                  isCheckCallApi = false;
                }
                if (isCheckCallApi) {
                  await widget.cubit.postThemBieuQuyetHop(
                    widget.id,
                    noiDungController.text,
                    widget.cubit.date,
                    widget.cubit.loaiBieuQ,
                    widget.cubit.dateTimeFormat(thoiGianHop, timeStart),
                    widget.cubit.dateTimeFormat(thoiGianHop, timeEnd),
                  );
                  nav.pop(true);
                }
              },
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH20,
                CustomRadioButtons(
                  title: S.current.loai_bieu_quyet,
                  onchange: (value) {
                    widget.cubit.loaiBieuQ = value;
                  },
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
                            timeKetThuc: timeEnd.getTimeData(
                              timeReturnParseFail: TimerData(
                                hour: DateTime.now().hour,
                                minutes: DateTime.now().minute,
                              ),
                            ),
                            onChange: (start, end) {
                              timeStart = start.timerToString;
                              timeEnd = end.timerToString;
                              final dateTimeStart =
                                  '$thoiGianHop $timeStart'.convertStringToDate(
                                formatPattern:
                                    DateTimeFormat.DATE_TIME_PUT_EDIT,
                              );
                              final dateTimeEnd =
                                  '$thoiGianHop $timeEnd'.convertStringToDate(
                                formatPattern:
                                    DateTimeFormat.DATE_TIME_PUT_EDIT,
                              );
                              if (dateTimeStart.isBefore(
                                    widget.cubit.getTime().convertStringToDate(
                                          formatPattern:
                                              DateFormatApp.monthDayFormat,
                                        ),
                                  ) ||
                                  dateTimeEnd.isAfter(
                                    widget.cubit
                                        .getTime(isGetDateStart: false)
                                        .convertStringToDate(
                                          formatPattern:
                                              DateFormatApp.monthDayFormat,
                                        ),
                                  )) {
                                widget.cubit.isValidateTimer.sink.add(true);
                                isShowValidate = true;
                              } else {
                                widget.cubit.isValidateTimer.sink.add(false);
                                isShowValidate = false;
                              }
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
                Flexible(
                  child: BlockTextViewLich(
                    formKey: formKeyNoiDung,
                    maxLenght: 255,
                    contentController: noiDungController,
                    title: S.current.ten_bieu_quyet,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.vui_long_nhap}'
                            ' ${S.current.ten_bieu_quyet}';
                      }
                      return null;
                    },
                  ),
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
                      child: CacLuaChonDonViWidget(
                        detailMeetCalenderCubit: widget.cubit,
                        onchange: (value) {
                          if (value.isEmpty) {
                            isShow = true;
                            setState(() {});
                          } else {
                            isShow = false;
                            setState(() {});
                          }
                          widget.cubit.listLuaChon = value;
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
                        child: StreamBuilder<List<DanhSachNguoiThamGiaModel>>(
                          stream: widget.cubit.nguoiThamGiaSubject,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            if (data.isNotEmpty) {
                              return Column(
                                children: [
                                  CustomCheckBoxList(
                                    urlIcon: ImageAssets.icDocument,
                                    title: S.current.loai_bai_viet,
                                    onChange: (value) {
                                      if (value.isEmpty) {
                                        widget.cubit.isValidateSubject.sink
                                            .add(true);
                                      } else {
                                        widget.cubit.isValidateSubject.sink
                                            .add(false);
                                      }
                                      widget.cubit.listDanhSach = value;
                                    },
                                    dataNguoiThamGia: data,
                                  ),
                                ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
