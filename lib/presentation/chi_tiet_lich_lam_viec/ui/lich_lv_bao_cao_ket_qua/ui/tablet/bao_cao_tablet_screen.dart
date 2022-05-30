import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/tablet/widgets/bao_cao_item_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/tablet/widgets/dialog_bao_cao_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoCaoTabletScreen extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;

  const BaoCaoTabletScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _BaoCaoTabletScreenState createState() => _BaoCaoTabletScreenState();
}

class _BaoCaoTabletScreenState extends State<BaoCaoTabletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.bao_cao_ket_qua,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 28, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<List<BaoCaoModel>>(
                  stream: widget.cubit.listBaoCaoKetQua,
                  builder: (context, snapshot) {
                    final listData = snapshot.data ?? [];
                    if (listData.isNotEmpty) {
                      return MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            return BaoCaoItemTablet(
                              statusColor:
                                  listData[index].status.getText().color,
                              fileNames:
                                  listData[index].listFile.map<String>((e) {
                                return e.name ?? '';
                              }).toList(),
                              status: listData[index].status.getText().text,
                              content: listData[index].content,
                              funcDelete: () {
                                showDiaLog(
                                  context,
                                  showTablet: true,
                                  funcBtnRight: () {},
                                  icon: SvgPicture.asset(
                                    ImageAssets.ic_delete_baocao,
                                  ),
                                  title: S.current.xoa_bao_cao_ket_qua,
                                  textContent:
                                      S.current.chan_chan_xoa_bao_cao_khong,
                                  btnLeftTxt: S.current.huy,
                                  btnRightTxt: S.current.xoa,
                                );
                              },
                              funcEdit: () {
                                showDiaLogTablet(
                                  context,
                                  child: BaoCaoDialogTablet(
                                    baoCaoModel: listData[index],
                                  ),
                                  title: S.current.chinh_sua_bao_cao_ket_qua,
                                  funcBtnOk: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(S.current.no_data),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
