import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/co_quan_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/hinh_thuc_hop.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/lich_lap_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuaLichHopWidget extends StatefulWidget {
  final ChiTietLichHopModel chiTietHop;
  final bool isMulti;

  const SuaLichHopWidget({
    Key? key,
    required this.chiTietHop,
    this.isMulti = false,
  }) : super(key: key);

  @override
  _SuaLichHopWidgetState createState() => _SuaLichHopWidgetState();
}

class _SuaLichHopWidgetState extends State<SuaLichHopWidget> {
  final TaoLichHopCubit _cubitTaoLichHop = TaoLichHopCubit();
  final _formKey = GlobalKey<FormGroupState>();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      stream: _cubitTaoLichHop.stateStream,
      child: FollowKeyBoardWidget(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: FormGroup(
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
                          _cubitTaoLichHop.taoLichHopRequest.title = value;
                        },
                        validate: (value) {
                          return value.isEmpty
                              ? '${S.current.vui_long_nhap} '
                                  '${S.current.tieu_de.toLowerCase()}'
                              : null;
                        },
                        maxLength: 200,
                      ),
                      spaceH5,
                      StreamBuilder<List<LoaiSelectModel>>(
                        stream: _cubitTaoLichHop.loaiLich,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? <LoaiSelectModel>[];
                          return SelectOnlyExpand(
                            urlIcon: ImageAssets.icCalendar,
                            title: S.current.loai_hop,
                            value: widget.chiTietHop.loaiHop,
                            listSelect: data.map((e) => e.name).toList(),
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
                          final data = snapshot.data ?? <LoaiSelectModel>[];
                          return SelectOnlyExpand(
                            urlIcon: ImageAssets.icWork,
                            title: S.current.linh_vuc,
                            value: widget.chiTietHop.linhVuc,
                            listSelect: data.map((e) => e.name).toList(),
                            onChange: (index) {
                              _cubitTaoLichHop.taoLichHopRequest.linhVucId =
                                  data[index].id;
                            },
                          );
                        },
                      ),
                      StreamBuilder<Map<String, String>>(
                          stream: _cubitTaoLichHop.timeConfigSubject,
                          builder: (context, snapshot) {
                            final timeConfig = snapshot.data ?? {};
                            return CupertinoMaterialPicker(
                              key: _timerPickerKey,
                              isEdit: true,
                              timeEndConfigSystem: timeConfig['timeEnd'],
                              timeStartConfigSystem: timeConfig['timeStart'],
                              initDateStart: widget.chiTietHop.ngayBatDau
                                  .convertStringToDate(
                                formatPattern: DateFormatApp.monthDayFormat,
                              ),
                              initDateEnd: widget.chiTietHop.ngayKetThuc
                                  .convertStringToDate(
                                formatPattern: DateFormatApp.monthDayFormat,
                              ),
                              initTimeEnd:
                                  widget.chiTietHop.timeTo.convertStringToDate(
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
                                _cubitTaoLichHop.taoLichHopRequest.ngayBatDau =
                                    dateStart
                                        .convertStringToDate(
                                          formatPattern: DateFormatApp.date,
                                        )
                                        .formatApi;
                                _cubitTaoLichHop.taoLichHopRequest.ngayKetThuc =
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
                            );
                          },
                      ),
                      spaceH5,
                      SelectOnlyExpand(
                        urlIcon: ImageAssets.icNhacLai,
                        title: S.current.nhac_lai,
                        value: widget.chiTietHop.nhacLai(),
                        listSelect: danhSachSuaThoiGianNhacLich
                            .map((e) => e.label)
                            .toList(),
                        onChange: (index) {
                          _cubitTaoLichHop.taoLichHopRequest.typeReminder =
                              danhSachSuaThoiGianNhacLich[index].id;
                          if (index == 0) {
                            _cubitTaoLichHop.taoLichHopRequest.isNhacLich =
                                false;
                          } else {
                            _cubitTaoLichHop.taoLichHopRequest.isNhacLich =
                                true;
                          }
                        },
                      ),
                      ContainerToggleWidget(
                        title: S.current.cong_khai_lich,
                        initData: widget.chiTietHop.isCongKhai ?? false,
                        onChange: (value) {
                          _cubitTaoLichHop.taoLichHopRequest.congKhai = value;
                        },
                      ),
                      spaceH5,
                      LichLapWidget(
                        urlIcon: ImageAssets.icNhacLai,
                        title: S.current.lich_lap,
                        value: widget.chiTietHop.lichLap(),
                        isUpdate: true,
                        initDayPicked: widget.chiTietHop.getDays(),
                        initDate:
                            widget.chiTietHop.dateRepeat?.convertStringToDate(),
                        listSelect:
                            danhSachLichLap.map((e) => e.label).toList(),
                        onChange: (index) {
                          _cubitTaoLichHop.taoLichHopRequest.typeRepeat =
                              danhSachLichLap[index].id;
                          if (index == 0) {
                            _cubitTaoLichHop.taoLichHopRequest.isLichLap =
                                false;
                          } else {
                            _cubitTaoLichHop.taoLichHopRequest.isLichLap = true;
                          }
                        },
                        onDayPicked: (listId) {
                          _cubitTaoLichHop.taoLichHopRequest.days =
                              listId.join(',');
                          if (listId.isEmpty) {
                            _cubitTaoLichHop.taoLichHopRequest.typeRepeat =
                                danhSachLichLap.first.id;
                          }
                        },
                        onDateChange: (value) {
                          _cubitTaoLichHop.taoLichHopRequest.dateRepeat =
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
                        listSelect: mucDoHop.map((e) => e.label).toList(),
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
                          _cubitTaoLichHop.taoLichHopRequest.noiDung = value;
                        },
                      ),
                      spaceH24
                    ],
                  ),
                ),
                TitleChildWidget(
                  title: S.current.dau_moi_lien_he,
                  child: Column(
                    children: [
                      TextFieldStyle(
                        initValue: widget.chiTietHop.chuTriModel.dauMoiLienHe,
                        urlIcon: ImageAssets.icPeople,
                        hintText: S.current.ho_ten,
                        onChange: (value) {
                          _cubitTaoLichHop
                              .taoLichHopRequest.chuTri?.dauMoiLienHe = value;
                        },
                      ),
                      spaceH16,
                      TextFieldStyle(
                        initValue: widget.chiTietHop.chuTriModel.soDienThoai,
                        urlIcon: ImageAssets.icCuocGoi,
                        hintText: S.current.so_dien_thoai,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputType: TextInputType.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            return null;
                          }
                          final phoneRegex = RegExp(VN_PHONE);
                          final bool checkRegex = phoneRegex.hasMatch(value);
                          return checkRegex
                              ? null
                              : S.current.nhap_sai_dinh_dang;
                        },
                        onChange: (value) {
                          _cubitTaoLichHop
                              .taoLichHopRequest.chuTri?.soDienThoai = value;
                        },
                      ),
                    ],
                  ),
                ),
                spaceH24,
                HinhThucHop(
                  cubit: _cubitTaoLichHop,
                  chiTietHop: widget.chiTietHop,
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
                  needShowSelectedRoom: true,
                  idHop: _cubitTaoLichHop.taoLichHopRequest.id,
                  onDelete: () {
                    _cubitTaoLichHop.taoLichHopRequest.phongHop = null;
                    _cubitTaoLichHop.taoLichHopRequest.phongHopThietBi = null;
                  },
                ),
                spaceH15,
                DoubleButtonBottom(
                  title1: S.current.dong,
                  onClickLeft: () {
                    Navigator.pop(context);
                  },
                  title2: S.current.luu,
                  onClickRight: () {
                    handleButtonEditPressed();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleButtonEditPressed() {
    final bool validateTime =
        _timerPickerKey.currentState?.validator() ?? false;
    final bool validateTextField = _formKey.currentState?.validator() ?? false;

    if (validateTime && validateTextField) {
      if (_cubitTaoLichHop.taoLichHopRequest.bitTrongDonVi == null) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.vui_long_chon_chu_tri,
        );
        return;
      }
      if (_cubitTaoLichHop.taoLichHopRequest.bitHopTrucTuyen == null ||
          (!_cubitTaoLichHop.isHopTrucTiep &&
              _cubitTaoLichHop.taoLichHopRequest.bitHopTrucTuyen == false)) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.vui_long_chon_hinh_thuc_hop,
        );
        return;
      }
      _cubitTaoLichHop
          .checkLichTrung(
        donViId: _cubitTaoLichHop.taoLichHopRequest.chuTri?.donViId ?? '',
        canBoId: _cubitTaoLichHop.taoLichHopRequest.chuTri?.canBoId ?? '',
      )
          .then((value) {
        if (value) {
          showDiaLog(
            context,
            title: S.current.lich_trung,
            textContent: S.current.ban_co_muon_tiep_tuc_khong,
            icon: ImageAssets.svgAssets(
              ImageAssets.ic_trung_hop,
            ),
            btnRightTxt: S.current.dong_y,
            btnLeftTxt: S.current.khong,
            isCenterTitle: true,
            funcBtnRight: () {
              createMeeting();
            },
          );
        } else {
          createMeeting();
        }
      });
    }
  }

  void createMeeting() {
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
}
