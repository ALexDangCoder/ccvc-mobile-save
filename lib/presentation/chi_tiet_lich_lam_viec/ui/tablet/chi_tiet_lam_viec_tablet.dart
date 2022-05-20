import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/tablet/widgets/btn_show_bao_cao_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/tablet/show_bottom_sheet_ds_y_Kien_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/phone/sua_lich_cong_tac_trong_nuoc_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietLamViecTablet extends StatefulWidget {
  final String id;

  const ChiTietLamViecTablet({Key? key, this.id = ''}) : super(key: key);

  @override
  _ChiTietLamViecTabletState createState() => _ChiTietLamViecTabletState();
}

class _ChiTietLamViecTabletState extends State<ChiTietLamViecTablet> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  @override
  void initState() {
    super.initState();
    chiTietLichLamViecCubit.loadApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      stream: chiTietLichLamViecCubit.stateStream,
      child: Scaffold(
        backgroundColor: colorF9FAFF,
        appBar: BaseAppBar(
          title: S.current.chi_tiet_lich_lam_viec,
          actions: [
            MenuSelectWidget(
              listSelect: [
                CellPopPupMenu(
                  urlImage: ImageAssets.icHuy,
                  text: S.current.huy,
                  onTap: () {
                    showDiaLog(
                      context,
                      showTablet: true,
                      textContent: S.current.ban_chan_chan_huy_lich_nay,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {
                        chiTietLichLamViecCubit.cancel(widget.id);
                      },
                      title: S.current.huy_lich,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.icHuyLich),
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icChartFocus,
                  text: S.current.bao_cao_ket_qua,
                  onTap: () {
                    showBottomSheetCustom(
                      context,
                      title: S.current.bao_cao_ket_qua,
                      child: const BaoCaoBottomSheet(),
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icChoYKien,
                  text: S.current.cho_y_kien,
                  onTap: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.cho_y_kien,
                      child: YKienBottomSheet(
                        id: widget.id,
                        isCheck: false,
                      ),
                      isBottomShow: false,
                      funcBtnOk: () {
                        Navigator.pop(context);
                      },
                    ).then((value) {
                      if (value == true) {
                        chiTietLichLamViecCubit.loadApi(widget.id);
                      } else if (value == null) {
                        return;
                      }
                    });
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icDelete,
                  text: S.current.xoa_lich,
                  onTap: () {
                    showDiaLog(
                      context,
                      showTablet: true,
                      textContent: S.current.ban_co_muon_xoa_lich_lam_viec,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {
                        chiTietLichLamViecCubit.dataDelete(widget.id);
                      },
                      title: S.current.xoa_lich_lam_viec,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.icDeleteLichHop),
                    );
                  },
                ),
                CellPopPupMenu(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {
                    showBottomSheetCustom(
                      context,
                      title: S.current.sua_lich_cong_tac_trong_nuoc,
                      child:  SuaLichCongTacTrongNuocPhone(cubit: chiTietLichLamViecCubit,),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          leadingIcon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: colorA2AEBD,
            ),
          ),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(top: 28, left: 30, right: 30, bottom: 28),
          margin:
              const EdgeInsets.only(top: 28, left: 30, right: 30, bottom: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorDBDFEF.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: color6566E9.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 12,
                      color: colorEA5455,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      S.current.hop_noi_bo_cong_ty,
                      style: textNormalCustom(
                        color: color3D5586,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                StreamBuilder<ChiTietLichLamViecModel>(
                  stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? ChiTietLichLamViecModel();
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(S.current.khong_co_du_lieu),
                      );
                    }
                    return ItemRowChiTiet(
                      data: data,
                      cubit: chiTietLichLamViecCubit,
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: BtnShowBaoCaoTablet(
                    cubit: chiTietLichLamViecCubit,
                  ),
                ),
                DanhSachYKienButtomTablet(
                  cubit: chiTietLichLamViecCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
