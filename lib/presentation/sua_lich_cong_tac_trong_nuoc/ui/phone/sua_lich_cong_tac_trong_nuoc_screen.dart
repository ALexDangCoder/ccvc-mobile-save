import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_dat_nuoc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lap_den_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap_tuy_chinh.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_quan_huyen_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_tinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_xa_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/mau_mac_dinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuaLichCongTacTrongNuocPhone extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;

  const SuaLichCongTacTrongNuocPhone({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _SuaLichCongTacTrongNuocPhoneState createState() =>
      _SuaLichCongTacTrongNuocPhoneState();
}

class _SuaLichCongTacTrongNuocPhoneState
    extends State<SuaLichCongTacTrongNuocPhone> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  TextEditingController tieuDeController = TextEditingController();
  ThanhPhanThamGiaCubit thamGiaCubit = ThanhPhanThamGiaCubit();
  final _formKey = GlobalKey<FormState>();
  List<DonViModel> list = [];

  @override
  void initState() {
    super.initState();
    taoLichLamViecCubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: WidgetTaoLichLVInherited(
        taoLichLamViecCubit: taoLichLamViecCubit,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: backgroundColorApp,
          ),
          child: ExpandGroup(
            child: StreamBuilder<ChiTietLichLamViecModel>(
                stream: widget.cubit.chiTietLichLamViecStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  final dataDetail = snapshot.data ?? ChiTietLichLamViecModel();
                  taoLichLamViecCubit.selectedCountry = dataDetail.country ?? '';
                  taoLichLamViecCubit.selectedCountryID= dataDetail.countryId ?? '';
                  taoLichLamViecCubit.datNuocSelectModel?.id=dataDetail.countryId;
                  if(dataDetail.typeScheduleId=='1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e'){
                    taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
                  }else{
                    taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<String>(
                                initialData: dataDetail.typeScheduleName ?? '',
                                stream: taoLichLamViecCubit.changeOption,
                                builder: (context, snapshot) {
                                  final data=snapshot.data??'';
                                  return Text(
                                    'Sửa ${data}',
                                    style: textNormalCustom(fontSize: 18, color: textTitle),
                                  );
                                }
                              ),
                              TextFieldStyle(
                                controller: TextEditingController(
                                    text: dataDetail.title),
                                urlIcon: ImageAssets.icEdit,
                                hintText: S.current.lich_cong_tac_trong_nuoc,
                                onChange: (vl) {
                                  taoLichLamViecCubit.title = vl;
                                },
                              ),
                              StreamBuilder<List<LoaiSelectModel>>(
                                stream: taoLichLamViecCubit.loaiLich,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  return SelectOnlyExpand(
                                    onChange: (value) {
                                      taoLichLamViecCubit.selectLoaiLich?.id ==
                                          dataDetail.typeScheduleId;
                                      taoLichLamViecCubit.changeOption.sink.add(
                                          data[value].name);
                                      if(data[value].id=='1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e'){
                                        taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
                                      }else{
                                        taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
                                      }
                                      if (dataDetail.typeScheduleId ==
                                          data[value].id) {
                                        taoLichLamViecCubit
                                                .selectLoaiLich?.id ==
                                            dataDetail.typeScheduleId;
                                      } else {
                                        taoLichLamViecCubit.selectLoaiLich?.id =
                                            data[value].id;
                                      }
                                    },
                                    urlIcon: ImageAssets.icCalendarUnFocus,
                                    value: dataDetail.typeScheduleName ?? '',
                                    listSelect:
                                        data.map((e) => e.name).toList(),
                                    title: S.current.loai_lich,
                                  );
                                },
                              ),
                              //bug chua fix
                              StartEndDateWidget(
                                icMargin: dataDetail.isAllDay ?? false,
                                // initEndData: DateTime.parse(dataDetail.dateTimeTo??''),
                                // initStartData: DateTime.parse(dataDetail.dateTimeFrom??''),
                                onEndDateTimeChanged: (DateTime value) {
                                  taoLichLamViecCubit.dateEnd =
                                      dataDetail.dateTo;
                                  taoLichLamViecCubit.dateEnd =
                                      value.toString();
                                },
                                onStartDateTimeChanged: (DateTime value) {
                                  taoLichLamViecCubit.dateFrom =
                                      dataDetail.dateFrom;
                                  taoLichLamViecCubit.dateFrom =
                                      value.toString();
                                },
                                isCheck: (bool value) {
                                  taoLichLamViecCubit.isCheckAllDaySubject
                                      .add(value);
                                },
                              ),
                              StreamBuilder<List<NhacLaiModel>>(
                                  stream: taoLichLamViecCubit.nhacLai,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return SelectOnlyExpand(
                                      urlIcon: ImageAssets.icNotify,
                                      title: S.current.nhac_lich,
                                      value: dataDetail.scheduleReminder
                                              ?.nhacLai() ??
                                          '',
                                      listSelect: data
                                          .map<String>((e) => e.title ?? '')
                                          .toList(),
                                      onChange: (value) {
                                        taoLichLamViecCubit.selectNhacLai
                                            .title = data[value].title;
                                        taoLichLamViecCubit.selectNhacLai
                                            .value = data[value].value;
                                      },
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              MauMacDinhWidget(
                                taoLichLamViecCubit: taoLichLamViecCubit,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              NguoiChuTriWidget(
                                  taoLichLamViecCubit: taoLichLamViecCubit),
                              StreamBuilder<List<LoaiSelectModel>>(
                                stream: taoLichLamViecCubit.linhVuc,
                                builder: (context, snapshot) {
                                  final data =
                                      snapshot.data ?? <LoaiSelectModel>[];
                                  return SelectOnlyExpand(
                                    onChange: (value) {
                                      taoLichLamViecCubit.selectLinhVuc?.id =
                                          data[value].id;
                                    },
                                    urlIcon: ImageAssets.icWork,
                                    listSelect:
                                        data.map((e) => e.name).toList(),
                                    value: dataDetail.linhVuc ?? '',
                                    title: S.current.linh_vuc,
                                  );
                                },
                              ),
                              StreamBuilder<bool>(
                                stream: taoLichLamViecCubit.checkTrongNuoc,
                                builder: (context, snapshot) {
                                  final data=snapshot.data??false;
                               if(!data){
                                 return Column(
                                   children: [
                                     ItemTinhWidget(
                                       taoLichLamViecCubit: taoLichLamViecCubit,
                                     ),
                                     ItemHuyenWidget(
                                       taoLichLamViecCubit: taoLichLamViecCubit,
                                     ),
                                     ItemXaWidget(
                                       taoLichLamViecCubit: taoLichLamViecCubit,
                                     ),
                                   ],
                                 );

                               }else{
                                 return  StreamBuilder<List<DatNuocSelectModel>>(
                                     stream: taoLichLamViecCubit.datNuocSelect,
                                     builder: (context, snapshot) {
                                       final data = snapshot.data ?? [];
                                       return SelectOnlyExpand(
                                         urlIcon: ImageAssets.icViTri,
                                         title: S.current.quoc_gia,
                                        value: taoLichLamViecCubit.selectedCountry,
                                         listSelect: data.map((e) => e.name ?? '').toList(),
                                         onChange: (value) {
                                          taoLichLamViecCubit.datNuocSelectModel?.name =
                                               data[value].name;
                                          taoLichLamViecCubit.selectedCountry = data[value].name ?? '';
                                          taoLichLamViecCubit.selectedCountryID = data[value].id ?? '';
                                          taoLichLamViecCubit.datNuocSelectModel?.id=data[value].id;
                                         },
                                       );
                                     },);
                               }
                                }
                              ),

                              TextFieldStyle(
                                controller: TextEditingController(
                                    text: dataDetail.location),
                                urlIcon: ImageAssets.icViTri,
                                hintText: S.current.ubnd_tinh_dong_nai,
                                onChange: (vl) {
                                  taoLichLamViecCubit.location = vl;
                                },
                              ),
                              StreamBuilder<List<LichLapModel>>(
                                  stream: taoLichLamViecCubit.lichLap,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    if (dataDetail.typeRepeat == 7) {
                                      taoLichLamViecCubit
                                          .lichLapTuyChinhSubject.sink
                                          .add(true);
                                    } else {
                                      taoLichLamViecCubit
                                          .lichLapTuyChinhSubject.sink
                                          .add(false);
                                    }
                                    if (dataDetail.typeRepeat != 1) {
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
                                      value: dataDetail.lichLap(),
                                      listSelect: data
                                          .map<String>((e) => e.name ?? '')
                                          .toList(),
                                      onChange: (value) {
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
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                            initDataTuyChinh:
                                                taoLichLamViecCubit
                                                    .listNgayChonTuan(
                                                        dataDetail.days ?? ''),
                                          )
                                        : Container();
                                  }),
                              StreamBuilder<bool>(
                                stream: taoLichLamViecCubit
                                    .lichLapKhongLapLaiSubject.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? false;
                                  return data
                                      ? ItemLapDenNgayWidget(
                                          taoLichLamViecCubit:
                                              taoLichLamViecCubit,
                                          isThem: false,
                                          initDate: DateTime.parse(
                                              dataDetail.dateRepeat ??
                                                  DateTime.now().toString()),
                                        )
                                      : Container();
                                },
                              ),
                              TextFieldStyle(
                                controller: TextEditingController(
                                    text: dataDetail.location),
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
                                listPeopleInit: dataDetail.scheduleCoperatives,
                              ),
                              const TaiLieuWidget(),
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
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          StreamBuilder<bool>(
                              stream: taoLichLamViecCubit.checkTrongNuoc,
                              builder: (context, snapshot) {
                                final data=snapshot.data??false;
                              return Expanded(
                                child: btnSuaLich(
                                  name: S.current.luu,
                                  bgr: labelColor,
                                  colorName: Colors.white,
                                  onTap: () {
                                    if(!data){
                                      taoLichLamViecCubit.suaLichLamViec();
                                    }else{
                                      taoLichLamViecCubit.suaLichLamViecNuocNgoai();
                                    }
                                  },
                                ),
                              );
                            }
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
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
