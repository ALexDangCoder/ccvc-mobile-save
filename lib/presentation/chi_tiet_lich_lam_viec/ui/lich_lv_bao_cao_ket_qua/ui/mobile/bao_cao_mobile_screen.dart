import 'dart:math';

import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bao_cao_item.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class BaoCaoScreen extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;

  const BaoCaoScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _BaoCaoScreenState createState() => _BaoCaoScreenState();
}

class _BaoCaoScreenState extends State<BaoCaoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BaoCaoModel>>(
      stream: widget.cubit.listBaoCaoKetQua,
      builder: (context, snapshot) {
        final listData = snapshot.data ?? [];
        if (listData.isNotEmpty) {
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = listData[index];

                ///Báo cáo kết quả do ai tạo ra thì chỉ người đó mới có quyền sửa xóa
                return BaoCaoItem(
                  isShowEdit: isEditOrDelete(data),
                  isShowDelete: isEditOrDelete(data),
                  statusColor: data.status.getText().color,
                  files: data.listFile,
                  status: data.status.getText().text,
                  content: data.content,
                  funcEdit: () {
                    onEditBaoCao(context, data);
                  },
                  funcDelete: () {
                    showDiaLog(
                      context,
                      funcBtnRight: () {
                        widget.cubit.xoaBaoCaoKetQua(listData[index].id);
                      },
                      showTablet: !isMobile(),
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
          return const NodataWidget(
            height: 50,
          );
        }
      },
    );
  }

  bool isEditOrDelete(BaoCaoModel data) {
    return (HiveLocal.getDataUser()?.userId ?? '') == data.createBy;
  }

  void onEditBaoCao(BuildContext context, BaoCaoModel data) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        child: BaoCaoBottomSheet(
          id: data.id,
          cubit: BaoCaoKetQuaCubit(
            content: data.content,
            tinhTrangBaoCaoModel: TinhTrangBaoCaoModel(
              displayName: data.status.getText().text,
              id: data.reportStatusId,
            ),
            fileInit: data.listFile,
          ),
          scheduleId: widget.cubit.idLichLamViec,
          listTinhTrangBaoCao: widget.cubit.listTinhTrang,
          isEdit: true,
        ),
        title: S.current.chinh_sua_bao_cao_ket_qua,
      ).then((value) {
        if (value is bool && value) {
          widget.cubit.getDanhSachBaoCaoKetQua(widget.cubit.idLichLamViec);
        }
      });
    } else {
      showDiaLogTablet(
        context,
        title: S.current.bao_cao_ket_qua,
        child: BaoCaoBottomSheet(
          id: data.id,
          cubit: BaoCaoKetQuaCubit(
            content: data.content,
            tinhTrangBaoCaoModel: TinhTrangBaoCaoModel(
              displayName: data.status.getText().text,
              id: data.reportStatusId,
            ),
            fileInit: data.listFile,
          ),
          scheduleId: widget.cubit.idLichLamViec,
          listTinhTrangBaoCao: widget.cubit.listTinhTrang,
          isEdit: true,
        ),
        isBottomShow: false,
        funcBtnOk: () {
          Navigator.pop(context);
        },
      ).then((value) {
        if (value is bool && value) {
          widget.cubit.getDanhSachBaoCaoKetQua(widget.cubit.idLichLamViec);
        }
      });
    }
  }
}
