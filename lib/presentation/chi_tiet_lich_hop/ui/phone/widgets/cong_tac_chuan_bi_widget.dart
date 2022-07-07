import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/row_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cong_tac_chuan_bi_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class CongTacChuanBiWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const CongTacChuanBiWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CongTacChuanBiWidget> createState() => _CongTacChuanBiWidgetState();
}

class _CongTacChuanBiWidgetState extends State<CongTacChuanBiWidget> {
  final TaoLichHopCubit _cubitTaoLichHop = TaoLichHopCubit();
  List<ThietBiPhongHopModel> listTHietBiDuocChon = [];

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value) {
            widget.cubit.callApiCongTacChuanBi();
            _cubitTaoLichHop.loadData();
            _cubitTaoLichHop.taoLichHopRequest =
                taoHopFormChiTietHopModel(widget.cubit.getChiTietLichHopModel);
          }
        },
        title: S.current.cong_tac_chuan_bi,
        child: body(),
      ),
      tabletScreen: CongTacChuanBiWidgetTablet(
        cubit: widget.cubit,
      ),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleType(
          title: S.current.thong_tin_phong,
          child: StreamBuilder<ThongTinPhongHopModel>(
            stream: widget.cubit.getThongTinPhongHop,
            builder: (context, snapshot) {
              final data = snapshot.data ?? ThongTinPhongHopModel();
              if (widget.cubit.isChonPhongHop()) {
                ///nếu chua có phòng nào và là người chủ trì thì hiện button chọn phòng họp
                return ChonPhongHopScreen(
                  dateFrom: _cubitTaoLichHop.getTime(),
                  dateTo: _cubitTaoLichHop.getTime(isGetDateStart: false),
                  id: _cubitTaoLichHop.donViId,
                  onChange: (value) {
                    _cubitTaoLichHop.chonPhongHopMetting(
                      widget.cubit.taoLichHopRequest,
                      value,
                    );
                  },
                  initPhongHop: _cubitTaoLichHop.taoLichHopRequest.phongHop,
                  initThietBi:
                      _cubitTaoLichHop.taoLichHopRequest.phongHopThietBi,
                );
              }
              if (widget.cubit.isHasPhong()) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.cubit.checkPermissionQuyenDuyetPhong())
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              /// check quyền hiển thị từ trạng thái phòng họp và quyền của app
                              if (widget.cubit.checkDuyetPhong())
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ButtonOtherWidget(
                                    text: S.current.duyet,
                                    color: itemWidgetUsing,
                                    ontap: () {
                                      widget.cubit.huyOrDuyetPhongHop(true);
                                    },
                                  ),
                                ),
                              if (widget.cubit.checkHuyDuyet())
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ButtonOtherWidget(
                                    text: S.current.tu_choi,
                                    color: statusCalenderRed,
                                    ontap: () {
                                      widget.cubit.huyOrDuyetPhongHop(false);
                                    },
                                  ),
                                ),
                              if (widget.cubit.checkThayDoiPhong())
                                ButtonOtherWidget(
                                  text: S.current.thay_doi_phong,
                                  color: bgButtonDropDown,
                                  ontap: () {
                                    showBottomSheet();
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ThongTinPhongWidget(
                      thongTinPhongHopModel: data,
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
        spaceH20,
        titleType(
          title: S.current.thong_tin_yeu_cau_thiet_bi,
          child: Column(
            children: [
              StreamBuilder<List<ThietBiPhongHopModel>>(
                stream: widget.cubit.getListThietBi,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <ThietBiPhongHopModel>[];
                  if (data.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: NodataWidget(),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StreamBuilder<ChiTietLichHopModel>(
                            stream: widget.cubit.chiTietLichHopSubject.stream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData &&
                                  widget.cubit
                                      .checkPermissionQuyenDuyetPhong()) {
                                return const SizedBox();
                              }
                              return Row(
                                children: [
                                  ButtonOtherWidget(
                                    text: S.current.duyet,
                                    color: itemWidgetUsing,
                                    ontap: () {
                                      duyetOrhuyDuyetThietBi(true);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ButtonOtherWidget(
                                      text: S.current.tu_choi,
                                      color: statusCalenderRed,
                                      ontap: () {
                                        duyetOrhuyDuyetThietBi(false);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Column(
                        children: List.generate(
                          data.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ThongTinYeuCauThietBiWidget(
                              model: data[index],
                              onChange: (value) {
                                if (!value) {
                                  listTHietBiDuocChon.add(data[index]);
                                } else {
                                  listTHietBiDuocChon.remove(data[index]);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// button duyet ky thuat hiển thị khi có quyền và trạng thái phòng họp đã duyệt
              StreamBuilder<ThongTinPhongHopModel>(
                stream: widget.cubit.getThongTinPhongHop,
                builder: (context, snapshotPhongHop) {
                  final data = snapshotPhongHop.data;
                  if (data == null) {
                    return const SizedBox();
                  }
                  if (widget.cubit.checkPermissionDKT()) {
                    return StreamBuilder<ChiTietLichHopModel>(
                      stream: widget.cubit.chiTietLichHopSubject.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              if (widget.cubit.checkDuyetKyThuat())
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ButtonOtherWidget(
                                    text: S.current.duyet_ky_thuat,
                                    color: itemWidgetUsing,
                                    ontap: () {
                                      widget.cubit.duyetOrHuyDuyetKyThuat(true);
                                    },
                                  ),
                                ),
                              if (widget.cubit.checkTuChoiKyThuat())
                                ButtonOtherWidget(
                                  text: S.current.tu_choi_ky_thuat,
                                  color: statusCalenderRed,
                                  ontap: () {
                                    widget.cubit.duyetOrHuyDuyetKyThuat(false);
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void duyetOrhuyDuyetThietBi(bool isDuyet) {
    if (listTHietBiDuocChon.isNotEmpty) {
      widget.cubit
          .forToduyetOrHuyDuyetThietBi(
            listTHietBiDuocChon: listTHietBiDuocChon,
            isDuyet: isDuyet,
          )
          .then(
            (value) => emtyThietBiDuocChon(value),
          );
    }
  }

  Widget titleType({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textNormalCustom(color: infoColor, fontSize: 14),
        ),
        spaceH16,
        child
      ],
    );
  }

  void emtyThietBiDuocChon(bool value) {
    if (value) {
      listTHietBiDuocChon = [];
    }
  }

  void showBottomSheet() {
    if (isMobile()) {
      showBottomSheetCustom<ChonPhongHopModel>(
        context,
        child: _ChonPhongHopScreenOnly(
          cubit: widget.cubit,
        ),
        title: S.current.chon_phong_hop,
      );
    } else {
      showDiaLogTablet<ChonPhongHopModel>(
        context,
        title: S.current.chon_phong_hop,
        child: _ChonPhongHopScreenOnly(
          cubit: widget.cubit,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}

class ThongTinPhongWidget extends StatelessWidget {
  final ThongTinPhongHopModel thongTinPhongHopModel;

  const ThongTinPhongWidget({Key? key, required this.thongTinPhongHopModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderItemCalender.withOpacity(0.1),
        border: Border.all(color: borderItemCalender),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          RowDataWidget(
            keyTxt: S.current.ten_phong,
            value: thongTinPhongHopModel.tenPhong ?? '',
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.suc_chua,
            value: thongTinPhongHopModel.sucChua ?? '0',
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.dia_diem,
            value: thongTinPhongHopModel.diaDiem ?? '',
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.trang_thai,
            value: thongTinPhongHopModel.trangThaiPhongHop.getText(),
            color: thongTinPhongHopModel.trangThaiPhongHop.getColor(),
            isStatus: true,
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.thiet_bi_san_co,
            value: thongTinPhongHopModel.thietBiSanCo ?? '',
          )
        ],
      ),
    );
  }
}

class ThongTinYeuCauThietBiWidget extends StatelessWidget {
  final Function(bool) onChange;
  final ThietBiPhongHopModel model;

  const ThongTinYeuCauThietBiWidget(
      {Key? key, required this.model, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BehaviorSubject<bool> _check = BehaviorSubject.seeded(false);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderItemCalender.withOpacity(0.1),
        border: Border.all(color: borderItemCalender),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              RowDataWidget(
                keyTxt: S.current.loai_thiet_bi,
                value: model.loaiThietBi ?? '',
              ),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  StreamBuilder<bool>(
                      stream: _check,
                      builder: (context, snapshot) {
                        return CustomCheckBox(
                          isOnlyCheckbox: true,
                          isCheck: _check.value,
                          onChange: (value) {
                            onChange(_check.value);
                            _check.sink.add(!_check.value);
                          },
                        );
                      }),
                ],
              )
            ],
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.so_luong,
            value: model.soLuong ?? '0',
          ),
          spaceH10,
          RowDataWidget(
            keyTxt: S.current.trang_thai,
            value: model.trangThaiPhongHop.getText(),
            color: model.trangThaiPhongHop.getColor(),
            isStatus: true,
          ),
        ],
      ),
    );
  }
}

class ButtonOtherWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Function() ontap;

  const ButtonOtherWidget(
      {Key? key, required this.text, required this.color, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(isMobile() ? 4 : 8)),
          color: color.withOpacity(0.15),
        ),
        child: Text(
          text,
          style: textNormalCustom(color: color),
        ),
      ),
    );
  }
}

class _ChonPhongHopScreenOnly extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const _ChonPhongHopScreenOnly({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _ChonPhongHopScreenOnlyState createState() => _ChonPhongHopScreenOnlyState();
}

class _ChonPhongHopScreenOnlyState extends State<_ChonPhongHopScreenOnly> {
  int groupValue = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height) * 0.8,
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DoubleButtonBottom(
            title1: S.current.dong,
            title2: S.current.xac_nhan,
            onPressed1: () {
              Navigator.pop(context);
            },
            onPressed2: () {
              widget.cubit.thayDoiPhongHop();
              Navigator.pop(context);
            },
          ),
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<List<PhongHopModel>>(
            stream: widget.cubit.phongHopSubject,
            builder: (context, snapshot) {
              final listData = snapshot.data ?? [];
              if (listData.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listData.length,
                  itemBuilder: (_, index) => itemPhongHop(
                    phongHop: listData[index],
                    index: index,
                    groupValue: groupValue,
                    onChange: (index) {
                      widget.cubit.chosePhongHop
                        ..donViId = listData[index].donViDuyetId
                        ..ten = listData[index].ten
                        ..bitTTDH = listData[index].bit_TTDH
                        ..phongHopId = listData[index].id;
                      groupValue = index;
                      setState(() {});
                    },
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: NodataWidget(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
