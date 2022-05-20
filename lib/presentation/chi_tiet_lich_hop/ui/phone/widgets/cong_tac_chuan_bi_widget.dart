import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/row_data_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class CongTacChuanBiWidget extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  const CongTacChuanBiWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.cong_tac_chuan_bi,
                style: textNormalCustom(color: color667793, fontSize: 16),
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
            stream: cubit.getThongTinPhongHop,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: NodataWidget(),
                );
              }
              return ThongTinPhongWidget(
                thongTinPhongHopModel: data,
              );
            },
          ),
        ),
        spaceH20,
        titleType(
          title: S.current.yeu_cau_de_chuan_bi_phong,
          child: StreamBuilder<List<ThietBiPhongHopModel>>(
            stream: cubit.getListThietBi,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <ThietBiPhongHopModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: NodataWidget(),
                );
              }
              return Column(
                children: List.generate(
                  data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ThongTinYeuCauThietBiWidget(
                      model: data[index],
                    ),
                  ),
                ),
              );
            },
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
          style: textNormalCustom(color: color667793, fontSize: 14),
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
        color: colorE2E8F0.withOpacity(0.1),
        border: Border.all(color: colorE2E8F0),
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
  final ThietBiPhongHopModel model;
  const ThongTinYeuCauThietBiWidget({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorE2E8F0.withOpacity(0.1),
        border: Border.all(color: colorE2E8F0),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          RowDataWidget(
            keyTxt: S.current.loai_thiet_bi,
            value: model.loaiThietBi ?? '',
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
