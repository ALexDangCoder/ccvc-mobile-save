import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tablet/widgets/button_save_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/co_quan_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/hinh_thuc_hop.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/lich_lap_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/nhac_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/row_column_tablet.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuaLichHopTabletScreen extends StatefulWidget {
  final ChiTietLichHopModel chiTietHop;
  final bool isMulti;

  const SuaLichHopTabletScreen({
    Key? key,
    required this.chiTietHop,
    this.isMulti = false,
  }) : super(key: key);

  @override
  _SuaLichHopScreenState createState() => _SuaLichHopScreenState();
}

class _SuaLichHopScreenState extends State<SuaLichHopTabletScreen> {
  final TaoLichHopCubit _cubitTaoLichHop = TaoLichHopCubit();
  final _formKey = GlobalKey<FormState>();
  final _timerPickerKey = GlobalKey<CupertinoMaterialPickerState>();

  @override
  void initState() {
    super.initState();
    _cubitTaoLichHop.loadData();
    _cubitTaoLichHop.taoLichHopRequest =
        taoHopFormChiTietHopModel(widget.chiTietHop);
    _cubitTaoLichHop.taoLichHopRequest.isMulti = widget.isMulti;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCalenderColor,
      resizeToAvoidBottomInset: true,
      appBar: BaseAppBar(
        title: S.current.sua_lich_hop,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: _cubitTaoLichHop.stateStream,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RowColunmTabletWidget(
                widgetLeft: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandGroup(
                          child: Column(
                            children: [
                              TextFieldStyle(
                                initValue: widget.chiTietHop.title,
                                urlIcon: ImageAssets.icEdit,
                                hintText: S.current.tieu_de,
                                onChange: (value) {
                                  _cubitTaoLichHop.taoLichHopRequest.title =
                                      value;
                                },
                                validate: (value) {
                                  return value.isEmpty
                                      ? S.current.khong_duoc_de_trong
                                      : null;
                                },
                                maxLength: 200,
                              ),
                              spaceH5,
                              StreamBuilder<List<LoaiSelectModel>>(
                                stream: _cubitTaoLichHop.loaiLich,
                                builder: (context, snapshot) {
                                  final data =
                                      snapshot.data ?? <LoaiSelectModel>[];
                                  return SelectOnlyExpand(
                                    urlIcon: ImageAssets.icCalendar,
                                    title: S.current.loai_hop,
                                    value: widget.chiTietHop.loaiHop,
                                    listSelect:
                                        data.map((e) => e.name).toList(),
                                    onChange: (index) {
                                      _cubitTaoLichHop.taoLichHopRequest
                                          .typeScheduleId = data[index].id;
                                    },
                                  );
                                },
                              ),
                              spaceH5,
                              StreamBuilder<List<LoaiSelectModel>>(
                                stream: _cubitTaoLichHop.linhVuc,
                                builder: (context, snapshot) {
                                  final data =
                                      snapshot.data ?? <LoaiSelectModel>[];
                                  return SelectOnlyExpand(
                                    urlIcon: ImageAssets.icWork,
                                    title: S.current.linh_vuc,
                                    value: widget.chiTietHop.linhVuc,
                                    listSelect:
                                        data.map((e) => e.name).toList(),
                                    onChange: (index) {
                                      _cubitTaoLichHop.taoLichHopRequest
                                          .linhVucId = data[index].id;
                                    },
                                  );
                                },
                              ),
                              CupertinoMaterialPicker(
                                key: _timerPickerKey,
                                isEdit: true,
                                initDateStart: widget.chiTietHop.ngayBatDau
                                    .convertStringToDate(
                                  formatPattern: DateFormatApp.monthDayFormat,
                                ),
                                initDateEnd: widget.chiTietHop.ngayKetThuc
                                    .convertStringToDate(
                                  formatPattern: DateFormatApp.monthDayFormat,
                                ),
                                initTimeEnd: widget.chiTietHop.timeTo
                                    .convertStringToDate(
                                  formatPattern: DateFormatApp.timeFormat,
                                ),
                                initTimeStart: widget.chiTietHop.timeStart
                                    .convertStringToDate(
                                  formatPattern: DateFormatApp.timeFormat,
                                ),
                                isAllDay: widget.chiTietHop.isAllDay,
                                onDateTimeChanged: (
                                  String timeStart,
                                  String timeEnd,
                                  String dateStart,
                                  String dateEnd,
                                ) {
                                  _cubitTaoLichHop.taoLichHopRequest.timeStart =
                                      timeStart;
                                  _cubitTaoLichHop.taoLichHopRequest.timeTo =
                                      timeEnd;
                                  _cubitTaoLichHop.taoLichHopRequest
                                      .ngayBatDau =
                                      dateStart
                                          .convertStringToDate(
                                            formatPattern: DateFormatApp.date,
                                          )
                                          .formatApi;
                                  _cubitTaoLichHop.taoLichHopRequest
                                      .ngayKetThuc =
                                      dateEnd
                                          .convertStringToDate(
                                            formatPattern: DateFormatApp.date,
                                          )
                                          .formatApi;
                                },
                                onSwitchPressed: (value) {
                                  _cubitTaoLichHop.taoLichHopRequest.isAllDay =
                                      value;
                                },
                                validateTime: (String value) {},
                              ),
                              spaceH5,
                              NhacLichWidget(
                                isSelectedBtn:
                                    widget.chiTietHop.isCongKhai ?? false,
                                urlIcon: ImageAssets.icNhacLai,
                                title: S.current.nhac_lai,
                                value: widget.chiTietHop.nhacLai(),
                                listSelect: danhSachSuaThoiGianNhacLich
                                    .map((e) => e.label)
                                    .toList(),
                                onChange: (index) {
                                  _cubitTaoLichHop
                                      .taoLichHopRequest.typeReminder =
                                      danhSachSuaThoiGianNhacLich[index].id;
                                  if (index == 0) {
                                    _cubitTaoLichHop
                                        .taoLichHopRequest.isNhacLich = false;
                                  } else {
                                    _cubitTaoLichHop
                                        .taoLichHopRequest.isNhacLich = true;
                                  }
                                },
                                onTogglePressed: (value) {
                                  _cubitTaoLichHop.taoLichHopRequest.congKhai =
                                      value;
                                },
                              ),
                              spaceH5,
                              LichLapWidget(
                                urlIcon: ImageAssets.icNhacLai,
                                title: S.current.lich_lap,
                                value: widget.chiTietHop.lichLap(),
                                isUpdate: true,
                                initDayPicked: widget.chiTietHop.getDays(),
                                initDate: widget.chiTietHop.dateRepeat
                                    ?.convertStringToDate(),
                                listSelect: danhSachLichLap
                                    .map((e) => e.label)
                                    .toList(),
                                onChange: (index) {
                                  _cubitTaoLichHop.taoLichHopRequest
                                      .typeRepeat = danhSachLichLap[index].id;
                                  if (index == 0) {
                                    _cubitTaoLichHop
                                        .taoLichHopRequest.isLichLap = false;
                                  } else {
                                    _cubitTaoLichHop
                                        .taoLichHopRequest.isLichLap = true;
                                  }
                                },
                                onDayPicked: (listId) {
                                  _cubitTaoLichHop.taoLichHopRequest.days =
                                      listId.join(',');
                                  if(listId.isEmpty) {
                                    _cubitTaoLichHop.taoLichHopRequest
                                      .typeRepeat = danhSachLichLap.first.id;
                                  }
                                },
                                onDateChange: (value) {
                                  _cubitTaoLichHop
                                          .taoLichHopRequest.dateRepeat =
                                      value.changeToNewPatternDate(
                                    DateFormatApp.date,
                                    DateFormatApp.dateTimeBackEnd,
                                  );
                                },
                              ),
                              spaceH5,
                              SelectOnlyExpand(
                                urlIcon: ImageAssets.icMucDoHop,
                                title: S.current.muc_do_hop,
                                value: widget.chiTietHop.getMucDoHop(),
                                listSelect:
                                    mucDoHop.map((e) => e.label).toList(),
                                onChange: (index) {
                                  _cubitTaoLichHop.taoLichHopRequest.mucDo =
                                      mucDoHop[index].id;
                                },
                              ),
                              spaceH12,
                              CoQuanChuTri(
                                cubit: _cubitTaoLichHop,
                              ),
                              spaceH24,
                              TextFieldStyle(
                                initValue: widget.chiTietHop.noiDung,
                                urlIcon: ImageAssets.icDocument,
                                hintText: S.current.noidung,
                                maxLines: 4,
                                onChange: (value) {
                                  _cubitTaoLichHop.taoLichHopRequest.noiDung =
                                      value;
                                },
                              ),
                              spaceH24
                            ],
                          ),
                        ),
                        HinhThucHop(
                          cubit: _cubitTaoLichHop,
                          chiTietHop: widget.chiTietHop,
                        ),
                      ],
                    ),
                  ),
                ),
                widgetRight: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleChildWidget(
                      title: S.current.dau_moi_lien_he,
                      child: Column(
                        children: [
                          TextFieldStyle(
                            initValue:
                                widget.chiTietHop.chuTriModel.dauMoiLienHe,
                            urlIcon: ImageAssets.icPeople,
                            hintText: S.current.ho_ten,
                            onChange: (value) {
                              _cubitTaoLichHop.taoLichHopRequest.chuTri
                                  ?.dauMoiLienHe = value;
                            },
                          ),
                          spaceH16,
                          TextFieldStyle(
                            initValue:
                                widget.chiTietHop.chuTriModel.soDienThoai,
                            urlIcon: ImageAssets.icCuocGoi,
                            hintText: S.current.so_dien_thoai,
                            validate: (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              final phoneRegex = RegExp(VN_PHONE);
                              final bool checkRegex =
                                  phoneRegex.hasMatch(value);
                              return checkRegex
                                  ? null
                                  : S.current.nhap_sai_dinh_dang;
                            },
                            onChange: (value) {
                              _cubitTaoLichHop.taoLichHopRequest.chuTri
                                  ?.soDienThoai = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    spaceH24,
                    ChonPhongHopScreen(
                      dateFrom: _cubitTaoLichHop.getTime(),
                      dateTo: _cubitTaoLichHop.getTime(isGetDateStart: false),
                      id: _cubitTaoLichHop.donViId,
                      onChange: (value) {
                        _cubitTaoLichHop.handleChonPhongHop(value);
                      },
                      initPhongHop: _cubitTaoLichHop.taoLichHopRequest.phongHop,
                      initThietBi:
                          _cubitTaoLichHop.taoLichHopRequest.phongHopThietBi,
                    ),
                  ],
                ),
                titleLeft: S.current.thong_tin_lich,
                titleRight: '',
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 28, bottom: 30),
                  child: ButtonSaveWidget(
                    leftTxt: S.current.dong,
                    rightTxt: S.current.luu,
                    funcBtnOk: () {
                      if ((_formKey.currentState?.validate() ?? false) &&
                          (_timerPickerKey.currentState?.validator() ??
                              false)) {
                        _cubitTaoLichHop.editMeeting().then((value) {
                          if (value) {
                            MessageConfig.show(
                              title: S.current.sua_thanh_cong,
                            );
                            Navigator.pop(context, true);
                          } else {
                            MessageConfig.show(
                              messState: MessState.error,
                              title: S.current.sua_that_bai,
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
