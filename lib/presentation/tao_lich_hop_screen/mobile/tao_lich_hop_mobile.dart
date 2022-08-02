import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/co_quan_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/hinh_thuc_hop.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/lich_lap_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/tai_lieu_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/tao_hop_success.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/thanh_phan_tham_gia_widget_expand.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class TaoLichHopMobileScreen extends StatefulWidget {
  const TaoLichHopMobileScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopMobileScreen> {
  late TaoLichHopCubit _cubit;
  final _formKey = GlobalKey<FormGroupState>();
  final _timerPickerKey = GlobalKey<CupertinoMaterialPickerState>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = ProviderWidget.of<TaoLichHopCubit>(context).cubit;
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarDefaultBack(S.current.tao_lich_hop),
        body: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('', S.current.something_went_wrong),
          stream: _cubit.stateStream,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            controller: _scrollController,
            child: FormGroup(
              key: _formKey,
              scrollController: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandGroup(
                    child: Column(
                      children: [
                        TextFieldStyle(
                          urlIcon: ImageAssets.icEdit,
                          hintText: S.current.tieu_de,
                          onChange: (value) {
                            _cubit.taoLichHopRequest.title = value;
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
                          stream: _cubit.loaiLich,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <LoaiSelectModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icCalendar,
                              title: S.current.loai_hop,
                              value: _cubit.selectLoaiHop?.name ?? '',
                              listSelect: data.map((e) => e.name).toList(),
                              onChange: (index) {
                                _cubit.taoLichHopRequest.typeScheduleId =
                                    data[index].id;
                              },
                            );
                          },
                        ),
                        spaceH5,
                        StreamBuilder<List<LoaiSelectModel>>(
                          stream: _cubit.linhVuc,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <LoaiSelectModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icWork,
                              title: S.current.linh_vuc,
                              value: _cubit.selectLinhVuc?.name ?? '',
                              listSelect: data.map((e) => e.name).toList(),
                              onChange: (index) {
                                _cubit.taoLichHopRequest.linhVucId =
                                    data[index].id;
                              },
                            );
                          },
                        ),
                        StreamBuilder<Map<String, String>>(
                            stream: _cubit.timeConfigSubject.stream,
                            builder: (context, snapshot) {
                              final timeConfig = snapshot.data ?? {};
                              return CupertinoMaterialPicker(
                                key: _timerPickerKey,
                                timeEndConfigSystem: timeConfig['timeEnd'],
                                timeStartConfigSystem: timeConfig['timeStart'],
                                initTimeEnd: DateTime.now()
                                    .add(const Duration(hours: 1)),
                                onDateTimeChanged: (
                                  String timeStart,
                                  String timeEnd,
                                  String dateStart,
                                  String dateEnd,
                                ) {
                                  _cubit.taoLichHopRequest.timeStart =
                                      timeStart;
                                  _cubit.taoLichHopRequest.timeTo = timeEnd;
                                  _cubit.taoLichHopRequest.ngayBatDau =
                                      dateStart
                                          .convertStringToDate(
                                            formatPattern: DateFormatApp.date,
                                          )
                                          .formatApi;
                                  _cubit.taoLichHopRequest.ngayKetThuc = dateEnd
                                      .convertStringToDate(
                                        formatPattern: DateFormatApp.date,
                                      )
                                      .formatApi;
                                },
                                onSwitchPressed: (value) {
                                  _cubit.taoLichHopRequest.isAllDay = value;
                                },
                                validateTime: (String value) {},
                              );
                            },
                        ),
                        spaceH5,
                        SelectOnlyExpand(
                          urlIcon: ImageAssets.icNhacLai,
                          title: S.current.nhac_lai,
                          value: danhSachThoiGianNhacLich.first.label,
                          listSelect: danhSachThoiGianNhacLich
                              .map((e) => e.label)
                              .toList(),
                          onChange: (index) {
                            _cubit.taoLichHopRequest.typeReminder =
                                danhSachThoiGianNhacLich[index].id;
                            if (index == 0) {
                              _cubit.taoLichHopRequest.isNhacLich = false;
                            } else {
                              _cubit.taoLichHopRequest.isNhacLich = true;
                            }
                          },
                        ),
                        ContainerToggleWidget(
                          title: S.current.cong_khai_lich,
                          onChange: (value) {
                            _cubit.taoLichHopRequest.congKhai = value;
                          },
                        ),
                        spaceH5,
                        LichLapWidget(
                          urlIcon: ImageAssets.icNhacLai,
                          title: S.current.lich_lap,
                          value: danhSachLichLap.first.label,
                          listSelect:
                              danhSachLichLap.map((e) => e.label).toList(),
                          onChange: (index) {
                            _cubit.taoLichHopRequest.typeRepeat =
                                danhSachLichLap[index].id;
                            if (index == 0) {
                              _cubit.taoLichHopRequest.isLichLap = false;
                            } else {
                              _cubit.taoLichHopRequest.isLichLap = true;
                            }
                          },
                          onDayPicked: (listId) {
                            _cubit.taoLichHopRequest.days = listId.join(',');
                            if (listId.isEmpty) {
                              _cubit.taoLichHopRequest.typeRepeat =
                                  danhSachLichLap.first.id;
                            }
                          },
                          onDateChange: (value) {
                            _cubit.taoLichHopRequest.dateRepeat =
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
                          value: mucDoHop.first.label,
                          listSelect: mucDoHop.map((e) => e.label).toList(),
                          onChange: (index) {
                            _cubit.taoLichHopRequest.mucDo = mucDoHop[index].id;
                          },
                        ),
                        spaceH12,
                        CoQuanChuTri(
                          cubit: _cubit,
                        ),
                        spaceH24,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icDocument,
                          hintText: S.current.noidung,
                          maxLines: 4,
                          onChange: (value) {
                            _cubit.taoLichHopRequest.noiDung = value;
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
                          urlIcon: ImageAssets.icPeople,
                          hintText: S.current.ho_ten,
                          onChange: (value) {
                            _cubit.taoLichHopRequest.chuTri?.dauMoiLienHe =
                                value;
                          },
                        ),
                        spaceH16,
                        TextFieldStyle(
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
                            _cubit.taoLichHopRequest.chuTri?.soDienThoai =
                                value;
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH24,
                  HinhThucHop(cubit: _cubit),
                  spaceH24,
                  ChonPhongHopScreen(
                    dateFrom: _cubit.getTime(),
                    dateTo: _cubit.getTime(isGetDateStart: false),
                    id: _cubit.donViId,
                    onChange: (value) {
                      _cubit.handleChonPhongHop(value);
                    },
                    needShowSelectedRoom: true,
                  ),
                  spaceH15,
                  ExpandGroup(
                    child: Column(
                      children: [
                        ThanhPhanThamGiaExpandWidget(
                          cubit: _cubit,
                        ),
                        ChuongTrinhHopWidget(
                          cubit: _cubit,
                        ),
                        TaiLieuCuocHopWidget(
                          cubit: _cubit,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ButtonBottom(
                      text: S.current.tao_lich_hop,
                      onPressed: () {
                        handleButtonCreatePressed();
                      },
                      customColor: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleButtonCreatePressed() {
    final bool validateTime =
        _timerPickerKey.currentState?.validator() ?? false;
    final bool validateTextField = _formKey.currentState?.validator() ?? false;

    if (validateTime && validateTextField) {
      if (_cubit.taoLichHopRequest.bitTrongDonVi == null) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.vui_long_chon_chu_tri,
        );
        return;
      }
      if (_cubit.taoLichHopRequest.bitHopTrucTuyen == null ||
          (!_cubit.isHopTrucTiep &&
              _cubit.taoLichHopRequest.bitHopTrucTuyen == false)) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.vui_long_chon_hinh_thuc_hop,
        );
        return;
      }
      if (!_cubit.checkThoiGianPhienHop()) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.validate_thoi_gian_phien_hop,
        );
        return;
      }
      if (_cubit.isOverFileLength) {
        MessageConfig.show(
          messState: MessState.error,
          title: '${S.current.tong_file_khong_vuot_qua} 30MB',
        );
        return;
      }
      _cubit
          .checkLichTrung(
        donViId: _cubit.taoLichHopRequest.chuTri?.donViId ?? '',
        canBoId: _cubit.taoLichHopRequest.chuTri?.canBoId ?? '',
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
    _cubit.createMeeting().then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaoHopSuccess(),
          ),
        ).then((value) => Navigator.pop(context, true));
      } else {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.tao_that_bai,
        );
      }
    });
  }
}
