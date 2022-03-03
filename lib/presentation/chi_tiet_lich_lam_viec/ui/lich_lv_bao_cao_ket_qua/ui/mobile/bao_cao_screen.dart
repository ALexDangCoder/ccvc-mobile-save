import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bao_cao_item.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoCaoScreen extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  const BaoCaoScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _BaoCaoScreenState createState() => _BaoCaoScreenState();
}

class _BaoCaoScreenState extends State<BaoCaoScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 20),
      child: LoadingOnly(

        stream: widget.cubit.stateStream,
        child: StreamBuilder<List<BaoCaoModel>>(
          stream: widget.cubit.listBaoCaoKetQua,
          builder: (context, snapshot) {
            final listData = snapshot.data ?? [];
            if (listData.isNotEmpty) {
              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return BaoCaoItem(
                      statusColor: listData[index].status.getText().color,
                      fileNames: listData[index]
                          .listFile
                          .map((e) => e.name ?? '')
                          .toList(),
                      status: listData[index].status.getText().text,
                      content: listData[index].content,
                      funcEdit: () {
                        showBottomSheetCustom<BaoCaoModel>(
                          context,
                          child: ChinhSuaBaoCaoBottomSheet(
                            baoCaoModel: listData[index],
                            cubit: widget.cubit,
                          ),
                          title: S.current.chinh_sua_bao_cao_ket_qua,
                        ).then((value) {});
                      },
                      funcDelete: () {
                        showDiaLog(
                          context,
                          funcBtnRight: () {
                            widget.cubit.xoaBaoCaoKetQua(listData[index].id);
                          },
                          icon: SvgPicture.asset(
                            ImageAssets.ic_delete_baocao,
                          ),
                          title: S.current.xoa_bao_cao_ket_qua,
                          textContent: S.current.chan_chan_xoa_bao_cao_khong,
                          btnLeftTxt: S.current.huy,
                          btnRightTxt: S.current.xoa,
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return const NodataWidget();
            }
          },
        ),
      ),
    );
  }
}
