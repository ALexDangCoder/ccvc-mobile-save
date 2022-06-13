import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/fake_data_tao_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lich_lap_tuy_chinh_widget_hop_chi_tiet.dart';

class SuaLichHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const SuaLichHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _SuaLichHopWidgetState createState() => _SuaLichHopWidgetState();
}

class _SuaLichHopWidgetState extends State<SuaLichHopWidget> {
  final TaoLichHopCubit _cubitTaoLichHop = TaoLichHopCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubitTaoLichHop.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: StreamBuilder<ChiTietLichHopModel>(
            stream: widget.cubit.chiTietLichHopSubject,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              final dataDetail = snapshot.data ?? ChiTietLichHopModel();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandGroup(
                    child: Column(
                      children: [
                        TextFieldStyle(
                          controller:
                              TextEditingController(text: dataDetail.title),
                          urlIcon: ImageAssets.icEdit,
                          hintText: S.current.tieu_de,
                          onChange: (vl) {
                            widget.cubit.taoLichHopRequest.title = vl;
                          },
                        ),
                        spaceH5,
                        ContainerToggleWidget(
                          initData: dataDetail.bit_HopTrucTuyen,
                          title: S.current.hop_truc_tuyen,
                          onChange: (value) {
                            widget.cubit.taoLichHopRequest.bitHopTrucTuyen =
                                value;
                          },
                        ),
                        spaceH5,
                        ContainerToggleWidget(
                          initData: dataDetail.bit_TrongDonVi,
                          title: S.current.trong_don_vi,
                          onChange: (value) {
                            widget.cubit.taoLichHopRequest.bitTrongDonVi =
                                value;
                          },
                        ),
                        spaceH5,
                        StreamBuilder<List<LoaiSelectModel>>(
                          stream: _cubitTaoLichHop.loaiLich,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <LoaiSelectModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icCalendar,
                              title: S.current.loai_hop,
                              value: dataDetail.loaiHop,
                              listSelect: data.map((e) => e.name).toList(),
                              onChange: (vl) {},
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
                              value: dataDetail.linhVuc,
                              listSelect: data.map((e) => e.name).toList(),
                              onChange: (vl) {
                                widget.cubit.taoLichHopRequest.linhVucId =
                                    data[vl].id;
                              },
                            );
                          },
                        ),
                        StartEndDateWidget(
                          onEndDateTimeChanged: (DateTime value) {
                            widget.cubit.taoLichHopRequest.ngayBatDau =
                                value.toString();
                          },
                          onStartDateTimeChanged: (DateTime value) {
                            widget.cubit.taoLichHopRequest.ngayKetThuc =
                                value.toString();
                          },
                          isCheck: (bool value) {},
                        ),
                        spaceH5,
                        SelectOnlyExpand(
                          urlIcon: ImageAssets.icNhacLai,
                          title: S.current.nhac_lai,
                          value: dataDetail.nhacLai(),
                          listSelect: FakeDataTaoLichHop.nhacLai,
                          onChange: (vl) {
                            widget.cubit.taoLichHopRequest.typeReminder =
                                widget.cubit.nhacLai(vl);
                          },
                        ),
                        spaceH5,
                        SelectOnlyExpand(
                          urlIcon: ImageAssets.icNhacLai,
                          title: S.current.lich_lap,
                          value: dataDetail.lichLap(),
                          listSelect: FakeDataTaoLichHop.lichLap,
                          onChange: (vl) {
                            if (vl + 1 == FakeDataTaoLichHop.lichLap.length) {
                              widget.cubit.checkTuyChinh.sink.add(true);
                            } else {
                              widget.cubit.checkTuyChinh.sink.add(false);
                            }
                            widget.cubit.taoLichHopRequest.typeRepeat = vl + 1;
                          },
                        ),
                        StreamBuilder<bool>(
                          stream: widget.cubit.checkTuyChinh,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? false;
                            if (data && dataDetail.typeRepeat == 7) {
                              return LichLapTuyChinhChiTietHopWidget(
                                cubit: widget.cubit,
                                onChange: (vl) {
                                  final String vlChange = vl.join(',');
                                  widget.cubit.taoLichHopRequest.days =
                                      vlChange;
                                },
                                initData: widget.cubit
                                    .listNgayChonTuan(dataDetail.days ?? ''),
                                initDate: DateTime.parse(
                                  dataDetail.dateRepeat ??
                                      DateTime.now().toString(),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        spaceH5,
                        SelectOnlyExpand(
                          urlIcon: ImageAssets.icMucDoHop,
                          title: S.current.muc_do_hop,
                          value: dataDetail.mucDoHopWithInt(),
                          listSelect: FakeDataTaoLichHop.mucDoHop,
                        ),
                        spaceH5,
                        StreamBuilder<List<NguoiChutriModel>>(
                          stream: _cubitTaoLichHop.nguoiChuTri,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <NguoiChutriModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icPeople,
                              title: S.current.nguoi_chu_tri,
                              value: dataDetail.chuTriModel.data(),
                              listSelect: data.map((e) => e.title()).toList(),
                              onChange: (vl) {
                                final result = data[vl];
                                widget.cubit.taoLichHopRequest.chuTri = ChuTri(
                                  donViId: result.donViId,
                                  canBoId: result.userId,
                                  tenCanBo: result.hoTen,
                                  tenCoQuan: result.tenDonVi,
                                );
                              },
                            );
                          },
                        ),
                        spaceH24,
                        TextFieldStyle(
                          controller:
                              TextEditingController(text: dataDetail.noiDung),
                          urlIcon: ImageAssets.icDocument,
                          hintText: S.current.noi_dung,
                          maxLines: 4,
                          onChange: (vl) {
                            widget.cubit.taoLichHopRequest.title = vl;
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
                          controller: TextEditingController(
                              text: dataDetail.chuTriModel.dauMoiLienHe),
                          urlIcon: ImageAssets.icPeople,
                          hintText: S.current.ho_ten,
                          onChange: (vl) {
                            widget.cubit.taoLichHopRequest.chuTri
                                ?.dauMoiLienHe = vl;
                          },
                        ),
                        TextFieldStyle(
                          controller: TextEditingController(
                              text: dataDetail.chuTriModel.soDienThoai),
                          urlIcon: ImageAssets.icCuocGoi,
                          hintText: S.current.so_dien_thoai,
                          onChange: (vl) {
                            widget.cubit.taoLichHopRequest.chuTri?.soDienThoai =
                                vl;
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH24,
                  ChonPhongHopScreen(
                    onChange: (value) {},
                  ),
                  spaceH24,
                  DoubleButtonBottom(
                    title1: S.current.dong,
                    onPressed1: () {
                      Navigator.pop(context);
                    },
                    title2: S.current.luu,
                    onPressed2: () {
                      Navigator.pop(context);
                      widget.cubit.postSuaLichHop();
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
