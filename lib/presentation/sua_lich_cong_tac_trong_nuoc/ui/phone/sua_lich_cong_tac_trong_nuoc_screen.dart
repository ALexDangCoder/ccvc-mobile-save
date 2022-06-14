import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/custom_switch_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lap_den_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap_tuy_chinh.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_quan_huyen_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_tinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_xa_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuaLichCongTacTrongNuocPhone extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final ChiTietLichLamViecModel event;

  const SuaLichCongTacTrongNuocPhone({
    Key? key,
    required this.cubit,
    required this.event,
  }) : super(key: key);

  @override
  _SuaLichCongTacTrongNuocPhoneState createState() =>
      _SuaLichCongTacTrongNuocPhoneState();
}

class _SuaLichCongTacTrongNuocPhoneState
    extends State<SuaLichCongTacTrongNuocPhone> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController diaDiemController = TextEditingController();
  ThanhPhanThamGiaCubit thamGiaCubit = ThanhPhanThamGiaCubit();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    taoLichLamViecCubit.chiTietLichLamViecModel = widget.event;
    taoLichLamViecCubit.selectedCountry = widget.event.country ?? '';
    taoLichLamViecCubit.selectedCountryID = widget.event.countryId ?? '';
    taoLichLamViecCubit.datNuocSelectModel?.id = widget.event.countryId;
    taoLichLamViecCubit.typeScheduleId = widget.event.typeScheduleId;
    taoLichLamViecCubit.dateEnd = widget.event.dateTo;
    taoLichLamViecCubit.timeFrom = widget.event.timeFrom;
    taoLichLamViecCubit.timeEnd = widget.event.timeTo;
    taoLichLamViecCubit.dateFrom = widget.event.dateFrom;
    taoLichLamViecCubit.dateTimeFrom = widget.event.dateTimeFrom;
    taoLichLamViecCubit.dateTimeTo = widget.event.dateTimeTo;
    taoLichLamViecCubit.linhVucString = widget.event.linhVuc;
    taoLichLamViecCubit.days = widget.event.days;
    taoLichLamViecCubit.typeRepeat = widget.event.typeRepeat;
    taoLichLamViecCubit.typeScheduleName = widget.event.typeScheduleName;
    taoLichLamViecCubit.changeOption.sink
        .add(widget.event.typeScheduleName ?? '');
    taoLichLamViecCubit.publishSchedule = widget.event.publishSchedule;

    taoLichLamViecCubit.dateRepeat = widget.event.dateRepeat;

    taoLichLamViecCubit.scheduleReminder = widget.event.scheduleReminder;
    taoLichLamViecCubit.chiTietLichLamViecModel.scheduleCoperatives =
        widget.event.scheduleCoperatives;
    tieuDeController.text = widget.event.title ?? '';
    noiDungController.text = widget.event.content ?? '';
    diaDiemController.text = widget.event.location ?? '';
    if (widget.event.typeScheduleId == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
      taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
    } else {
      taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
    }
    taoLichLamViecCubit.files = widget.event.files;
    taoLichLamViecCubit.id = widget.event.id;
    taoLichLamViecCubit.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaoLichLamViecCubit, TaoLichLamViecState>(
      bloc: taoLichLamViecCubit,
      listener: (context, state) {
        if(state is CreateSuccess){
          Navigator.pop(context, true);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: backgroundColorApp,
        ),
        child: FollowKeyBoardWidget(
          child: WidgetTaoLichLVInherited(
            taoLichLamViecCubit: taoLichLamViecCubit,
            child: ExpandGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<String>(
                      initialData: taoLichLamViecCubit.typeScheduleName,
                      stream: taoLichLamViecCubit.changeOption,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? '';
                        return Text(
                          'Sửa $data',
                          style:
                              textNormalCustom(fontSize: 18, color: textTitle),
                        );
                      }),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: StreamBuilder<String>(
                                initialData:
                                    taoLichLamViecCubit.typeScheduleName,
                                stream: taoLichLamViecCubit.changeOption,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? '';
                                  return TextFieldStyle(
                                    controller: tieuDeController,
                                    urlIcon: ImageAssets.icEdit,
                                    hintText: '${S.current.tieu_de} $data',
                                    onChange: (vl) {
                                      taoLichLamViecCubit.title = vl;
                                    },
                                    validate: (value) {
                                      return value.checkNull();
                                    },
                                  );
                                }),
                          ),
                          StreamBuilder<List<LoaiSelectModel>>(
                            stream: taoLichLamViecCubit.loaiLich,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? [];
                              return SelectOnlyExpand(
                                onChange: (value) {
                                  taoLichLamViecCubit.selectLoaiLich?.id ==
                                      taoLichLamViecCubit.typeScheduleId;
                                  taoLichLamViecCubit.changeOption.sink
                                      .add(data[value].name);
                                  taoLichLamViecCubit.typeScheduleName =
                                      data[value].name;
                                  if (data[value].id ==
                                      '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
                                    taoLichLamViecCubit.checkTrongNuoc.sink
                                        .add(true);
                                  } else {
                                    taoLichLamViecCubit.checkTrongNuoc.sink
                                        .add(false);
                                  }
                                  if (taoLichLamViecCubit.typeScheduleId ==
                                      data[value].id) {
                                    taoLichLamViecCubit.selectLoaiLich?.id ==
                                        taoLichLamViecCubit.typeScheduleId;
                                  } else {
                                    taoLichLamViecCubit.selectLoaiLich?.id =
                                        data[value].id;
                                  }
                                },
                                urlIcon: ImageAssets.icCalendarUnFocus,
                                value:
                                    taoLichLamViecCubit.typeScheduleName ?? '',
                                listSelect: data.map((e) => e.name).toList(),
                                title: S.current.loai_lich,
                              );
                            },
                          ),
                          CupertinoMaterialPicker(
                            initDateStart: taoLichLamViecCubit.dateTimeFrom
                                ?.convertStringToDate(),
                            initTimeStart: taoLichLamViecCubit.dateTimeFrom
                                ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd),
                            initDateEnd: taoLichLamViecCubit.dateTimeTo
                                ?.convertStringToDate(),
                            initTimeEnd: taoLichLamViecCubit.dateTimeTo
                                ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd),
                            onDateTimeChanged: (
                              String timeStart,
                              String timeEnd,
                              String dateStart,
                              String dateEnd,
                            ) {
                              taoLichLamViecCubit.checkValidateTime();
                              taoLichLamViecCubit.listeningEndDataTime(
                                DateTime.parse(
                                  timeFormat(
                                    '$dateEnd $timeEnd',
                                    'dd/MM/yyyy hh:mm',
                                    'yyyy-MM-dd hh:mm:ss.ms',
                                  ),
                                ),
                              );
                              taoLichLamViecCubit.listeningStartDataTime(
                                DateTime.parse(
                                  timeFormat(
                                    '$dateStart $timeStart',
                                    'dd/MM/yyyy hh:mm',
                                    'yyyy-MM-dd hh:mm:ss.ms',
                                  ),
                                ),
                              );
                            },
                            onSwitchPressed: (value) {
                              taoLichLamViecCubit.isCheckAllDaySubject
                                  .add(value);
                            },
                            validateTime: (bool value) {},
                          ),
                          StreamBuilder<List<NhacLaiModel>>(
                              stream: taoLichLamViecCubit.nhacLai,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? [];
                                return SelectOnlyExpand(
                                  urlIcon: ImageAssets.icNotify,
                                  title: S.current.nhac_lich,
                                  value: taoLichLamViecCubit.scheduleReminder
                                          ?.nhacLai() ??
                                      '',
                                  listSelect: data
                                      .map<String>((e) => e.title ?? '')
                                      .toList(),
                                  onChange: (value) {
                                    taoLichLamViecCubit.selectNhacLai.title =
                                        data[value].title;
                                    taoLichLamViecCubit.selectNhacLai.value =
                                        data[value].value;
                                    taoLichLamViecCubit.scheduleReminder
                                        ?.typeReminder = data[value].value;
                                  },
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<List<NguoiChutriModel>>(
                              stream: taoLichLamViecCubit.nguoiChuTri,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? [];
                                return SelectOnlyExpand(
                                  onChange: (value) {
                                    taoLichLamViecCubit.selectNguoiChuTri
                                        ?.userId = data[value].userId;
                                    taoLichLamViecCubit.selectNguoiChuTri
                                        ?.donViId = data[value].donViId;
                                    taoLichLamViecCubit.selectNguoiChuTri =
                                        data[value];
                                  },
                                  urlIcon: ImageAssets.icPeople,
                                  listSelect:
                                      data.map((e) => e.title()).toList(),
                                  value: taoLichLamViecCubit.selectNguoiChuTri
                                          ?.title() ??
                                      '',
                                  title: S.current.nguoi_chu_tri,
                                );
                              }),
                          StreamBuilder<List<LoaiSelectModel>>(
                            stream: taoLichLamViecCubit.linhVuc,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? <LoaiSelectModel>[];
                              return SelectOnlyExpand(
                                onChange: (value) {
                                  taoLichLamViecCubit.selectLinhVuc?.id =
                                      data[value].id;
                                  taoLichLamViecCubit.linhVucString =
                                      data[value].name;
                                },
                                urlIcon: ImageAssets.icWork,
                                listSelect: data.map((e) => e.name).toList(),
                                value: taoLichLamViecCubit.linhVucString ?? '',
                                title: S.current.linh_vuc,
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, left: 30.0),
                            child: CustomSwitchWidget(
                              onToggle: (value) {
                                taoLichLamViecCubit.publishSchedule = value;
                              },
                              value:
                                  taoLichLamViecCubit.publishSchedule ?? false,
                            ),
                          ),
                          StreamBuilder<bool>(
                              stream: taoLichLamViecCubit.checkTrongNuoc,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? false;
                                if (!data) {
                                  return Column(
                                    children: [
                                      ItemTinhWidget(
                                        taoLichLamViecCubit:
                                            taoLichLamViecCubit,
                                      ),
                                      ItemHuyenWidget(
                                        taoLichLamViecCubit:
                                            taoLichLamViecCubit,
                                      ),
                                      ItemXaWidget(
                                        taoLichLamViecCubit:
                                            taoLichLamViecCubit,
                                      ),
                                    ],
                                  );
                                } else {
                                  return StreamBuilder<
                                      List<DatNuocSelectModel>>(
                                    stream: taoLichLamViecCubit.datNuocSelect,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data ?? [];
                                      return SelectOnlyExpand(
                                        urlIcon: ImageAssets.icViTri,
                                        title: S.current.quoc_gia,
                                        value:
                                            taoLichLamViecCubit.selectedCountry,
                                        listSelect: data
                                            .map((e) => e.name ?? '')
                                            .toList(),
                                        onChange: (value) {
                                          taoLichLamViecCubit.datNuocSelectModel
                                              ?.name = data[value].name;
                                          taoLichLamViecCubit.selectedCountry =
                                              data[value].name ?? '';
                                          taoLichLamViecCubit
                                                  .selectedCountryID =
                                              data[value].id ?? '';
                                          taoLichLamViecCubit.datNuocSelectModel
                                              ?.id = data[value].id;
                                        },
                                      );
                                    },
                                  );
                                }
                              }),
                          TextFieldStyle(
                            controller: diaDiemController,
                            urlIcon: ImageAssets.icViTri,
                            hintText: S.current.dia_diem,
                            onChange: (vl) {
                              taoLichLamViecCubit.location = vl;
                            },
                          ),
                          StreamBuilder<List<LichLapModel>>(
                              stream: taoLichLamViecCubit.lichLap,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? [];
                                if (taoLichLamViecCubit.typeRepeat == 7) {
                                  taoLichLamViecCubit
                                      .lichLapTuyChinhSubject.sink
                                      .add(true);
                                } else {
                                  taoLichLamViecCubit
                                      .lichLapTuyChinhSubject.sink
                                      .add(false);
                                }
                                if (taoLichLamViecCubit.typeRepeat != 1) {
                                  taoLichLamViecCubit
                                      .lichLapKhongLapLaiSubject.sink
                                      .add(true);
                                } else {
                                  taoLichLamViecCubit
                                      .lichLapKhongLapLaiSubject.sink
                                      .add(false);
                                }
                                return SelectOnlyExpand(
                                  urlIcon: ImageAssets.icNhacLai,
                                  title: S.current.lich_lap,
                                  value: taoLichLamViecCubit
                                      .chiTietLichLamViecModel
                                      .lichLap(),
                                  listSelect: data
                                      .map<String>((e) => e.name ?? '')
                                      .toList(),
                                  onChange: (value) {
                                    taoLichLamViecCubit.chiTietLichLamViecModel
                                        .typeRepeat = data[value].id;
                                    // taoLichLamViecCubit.typeRepeat=data[value].id;
                                    if (data[value].id == 7) {
                                      taoLichLamViecCubit
                                          .lichLapTuyChinhSubject.sink
                                          .add(true);
                                    } else {
                                      taoLichLamViecCubit
                                          .lichLapTuyChinhSubject.sink
                                          .add(false);
                                    }
                                    if (data[value].id != 1) {
                                      taoLichLamViecCubit
                                          .lichLapKhongLapLaiSubject.sink
                                          .add(true);
                                    } else {
                                      taoLichLamViecCubit
                                          .lichLapKhongLapLaiSubject.sink
                                          .add(false);
                                    }
                                    taoLichLamViecCubit.selectLichLap.id =
                                        data[value].id;
                                  },
                                );
                              }),
                          StreamBuilder<bool>(
                            stream: taoLichLamViecCubit
                                .lichLapTuyChinhSubject.stream,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? false;
                              return data
                                  ? SuaLichLapTuyChinh(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                      initDataTuyChinh:
                                          taoLichLamViecCubit.listNgayChonTuan(
                                              taoLichLamViecCubit.days ?? ''),
                                    )
                                  : Container();
                            },
                          ),
                          StreamBuilder<bool>(
                            stream: taoLichLamViecCubit
                                .lichLapKhongLapLaiSubject.stream,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? false;
                              return data
                                  ? ItemLapDenNgayWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                      isThem: false,
                                      initDate: DateTime.parse(
                                          taoLichLamViecCubit.dateRepeat ??
                                              DateTime.now().toString()),
                                    )
                                  : Container();
                            },
                          ),
                          TextFieldStyle(
                            controller: noiDungController,
                            urlIcon: ImageAssets.icDocument,
                            hintText: S.current.noi_dung,
                            onChange: (vl) {
                              taoLichLamViecCubit.content = vl;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ThanhPhanThamGiaTLWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                            listPeopleInit: taoLichLamViecCubit
                                .chiTietLichLamViecModel.scheduleCoperatives,
                          ),
                          TaiLieuWidget(
                            files: (taoLichLamViecCubit.files ?? [])
                                .map((e) => File(e.path ?? ''))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: btnSuaLich(
                          name: S.current.dong,
                          bgr: buttonColor.withOpacity(0.1),
                          colorName: textDefault,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      StreamBuilder<bool>(
                          stream: taoLichLamViecCubit.checkTrongNuoc,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? false;
                            return Expanded(
                              child: btnSuaLich(
                                name: S.current.luu,
                                bgr: labelColor,
                                colorName: Colors.white,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    checkInside(data);
                                  }
                                },
                              ),
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkInside(bool data) {
    if (!data) {
      if (widget.event.isLichLap ?? false) {
        showDialog(
          context: context,
          builder: (context) => ThemLinkHopDialog(
            title: S.current.sua_lich_lam_viec,
            isConfirm: false,
            imageUrl: ImageAssets.ic_edit_cal,
            textConfirm: S.current.ban_co_chac_chan_sua_lich,
            textRadioAbove: S.current.chi_lich_nay,
            textRadioBelow: S.current.tu_lich_nay,
          ),
        ).then((value) {
          final flag = !value;
          taoLichLamViecCubit.suaLichLamViec(
            flag,
            context,
          );
        });
      } else {
        taoLichLamViecCubit.suaLichLamViec(
          false,
          context,
        );
      }
    } else {
      if (widget.event.isLichLap ?? false) {
        showDialog(
          context: context,
          builder: (context) => ThemLinkHopDialog(
            title: S.current.sua_lich_lam_viec,
            isConfirm: false,
            imageUrl: ImageAssets.ic_edit_cal,
            textConfirm: S.current.ban_co_chac_chan_sua_lich,
            textRadioAbove: S.current.chi_lich_nay,
            textRadioBelow: S.current.tu_lich_nay,
          ),
        ).then((value) {
          final flag = !value;
          taoLichLamViecCubit.suaLichLamViecNuocNgoai(
            flag,
            context,
          );
        });
      } else {
        taoLichLamViecCubit.suaLichLamViecNuocNgoai(
          false,
          context,
        );
      }
    }
  }
}

Widget btnSuaLich({
  required String name,
  required Color bgr,
  required Color colorName,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgr,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorName,
        ),
      ),
    ),
  );
}
