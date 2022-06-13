import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/row_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/chon_phonghop_in_detail.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class CongTacChuanBiWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const CongTacChuanBiWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CongTacChuanBiWidget> createState() => _CongTacChuanBiWidgetState();
}

class _CongTacChuanBiWidgetState extends State<CongTacChuanBiWidget> {
  List<ThietBiPhongHopModel> listTHietBiDuocChon = [];

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      onchange: (vl) {
        if (vl) {
          widget.cubit.initData(
            boolGetDanhSachThietBi: true,
            boolGetThongTinPhongHopApi: true,
          );
        }
      },
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.cong_tac_chuan_bi,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      child: body(),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleType(
          title: S.current.thong_tin_phong,
          child: StreamBuilder<ThongTinPhongHopModel?>(
            stream: widget.cubit.getThongTinPhongHop,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return ChonPhongHopScreen(
                  onChange: (vl) {
                    widget.cubit.taoLichHopRequest.phongHop = vl.phongHop;
                    widget.cubit.taoLichHopRequest.phongHop?.noiDungYeuCau =
                        vl.yeuCauKhac;
                    widget.cubit.taoLichHopRequest.phongHopThietBi =
                        vl.listThietBi
                            .map(
                              (e) => PhongHopThietBi(
                                tenThietBi: e.tenThietBi,
                                soLuong: e.soLuong.toString(),
                              ),
                            )
                            .toList();
                  },
                );
              }
              return Column(
                children: [
                  StreamBuilder<ChiTietLichHopModel>(
                    stream: widget.cubit.chiTietLichHopSubject.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData && widget.cubit.checkPermission()) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            /// check quyền hiển thị từ trạng thái phòng họp và quuyền của app
                            if (widget.cubit.checkDuyetPhong())
                              ButtonOtherWidget(
                                text: S.current.duyet,
                                color: itemWidgetUsing,
                                ontap: () {
                                  widget.cubit.huyOrDuyetPhongHop(true);
                                },
                              ),
                            if (widget.cubit.checkHuyDuyet())
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ButtonOtherWidget(
                                  text: S.current.tu_choi,
                                  color: statusCalenderRed,
                                  ontap: () {
                                    widget.cubit.huyOrDuyetPhongHop(false);
                                  },
                                ),
                              ),
                            if (widget.cubit.checkThayDoiPhong())
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ButtonOtherWidget(
                                  text: S.current.thay_doi_phong,
                                  color: bgButtonDropDown,
                                  ontap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChonPhongHopDetailHopScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  ThongTinPhongWidget(
                    thongTinPhongHopModel: data,
                  ),
                ],
              );
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
                                  widget.cubit.checkPermission()) {
                                return const SizedBox();
                              }
                              return Row(
                                children: [
                                  ButtonOtherWidget(
                                    text: S.current.duyet,
                                    color: itemWidgetUsing,
                                    ontap: () {
                                      widget.cubit.forToduyetOrHuyDuyetThietBi(
                                        listTHietBiDuocChon:
                                            listTHietBiDuocChon,
                                        isDuyet: true,
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ButtonOtherWidget(
                                      text: S.current.tu_choi,
                                      color: statusCalenderRed,
                                      ontap: () {
                                        widget.cubit
                                            .forToduyetOrHuyDuyetThietBi(
                                          listTHietBiDuocChon:
                                              listTHietBiDuocChon,
                                          isDuyet: false,
                                        );
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
                              onChange: (vl) {
                                if (vl) {
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
              StreamBuilder<ThongTinPhongHopModel?>(
                stream: widget.cubit.getThongTinPhongHop,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (!snapshot.hasData &&
                      data == null &&
                      widget.cubit.checkPermissionDKT()) {
                    return const SizedBox();
                  }
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
                              ButtonOtherWidget(
                                text: S.current.duyet_ky_thuat,
                                color: itemWidgetUsing,
                                ontap: () {
                                  widget.cubit.duyetOrHuyDuyetKyThuat(true);
                                },
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ButtonOtherWidget(
                                  text: S.current.tu_choi_ky_thuat,
                                  color: statusCalenderRed,
                                  ontap: () {
                                    widget.cubit.duyetOrHuyDuyetKyThuat(false);
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
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
    bool check = false;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderItemCalender.withOpacity(0.1),
        border: Border.all(color: borderItemCalender),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              RowDataWidget(
                keyTxt: S.current.loai_thiet_bi,
                value: model.loaiThietBi ?? '',
              ),
              CustomCheckBox(
                isOnlyCheckbox: true,
                title: '',
                isCheck: check,
                onChange: (vl) {
                  onChange(vl);
                },
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
  final Function ontap;

  const ButtonOtherWidget(
      {Key? key, required this.text, required this.color, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
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
