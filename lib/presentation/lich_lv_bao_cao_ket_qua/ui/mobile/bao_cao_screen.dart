import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/bloc/bao_cao_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bao_cao_item.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoCaoScreen extends StatefulWidget {
  const BaoCaoScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoScreenState createState() => _BaoCaoScreenState();
}

class _BaoCaoScreenState extends State<BaoCaoScreen> {
  BaoCaoCubit cubit = BaoCaoCubit();

  @override
  void initState() {
    super.initState();
    cubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: StreamBuilder<List<BaoCaoModel>>(
          stream: cubit.listBaoCao,
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
                    return BaoCaoItem(
                      statusColor: listData[index].status.getText().color,
                      fileNames: listData[index].listFile.map<String>((e) {
                        return e.path.convertNameFile();
                      }).toList(),
                      status: listData[index].status.getText().text,
                      content: listData[index].content,
                      funcEdit: () {
                        showBottomSheetCustom<BaoCaoModel>(
                          context,
                          child: ChinhSuaBaoCaoBottomSheet(
                            baoCaoModel: listData[index],
                          ),
                          title: S.current.chinh_sua_bao_cao_ket_qua,
                        ).then((value) {});
                      },
                      funcDelete: () {
                        showDiaLog(
                          context,
                          funcBtnRight: () {
                            listData.removeAt(index);
                            cubit.getData(listData);
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
              return Center(
                child: Text(S.current.no_data),
              );
            }
          },
        ),
      ),
    );
  }
}
