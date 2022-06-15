import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/btn_show_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/show_bottom_sheet_ds_y_Kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/phone/sua_lich_cong_tac_trong_nuoc_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiTietLichLamViecScreen extends StatefulWidget {
  final String id;

  const ChiTietLichLamViecScreen({Key? key, this.id = ''}) : super(key: key);

  @override
  State<ChiTietLichLamViecScreen> createState() =>
      _ChiTietLichLamViecScreenState();
}

class _ChiTietLichLamViecScreenState extends State<ChiTietLichLamViecScreen> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();
  final TaoLichLamViecCubit cubit = TaoLichLamViecCubit();

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
      child: StreamBuilder<ChiTietLichLamViecModel>(
          stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? ChiTietLichLamViecModel();
            return snapshot.data != null
                ? Scaffold(
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
                                  textContent:
                                      S.current.ban_chan_chan_huy_lich_nay,
                                  btnLeftTxt: S.current.khong,
                                  funcBtnRight: () async {
                                    await chiTietLichLamViecCubit
                                        .cancel(widget.id);
                                    Navigator.pop(context, true);
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
                                showBottomSheetCustom(
                                  context,
                                  title: S.current.y_kien,
                                  child: YKienBottomSheet(
                                    id: widget.id,
                                  ),
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
                                  textContent:
                                      S.current.ban_co_muon_xoa_lich_lam_viec,
                                  btnLeftTxt: S.current.khong,
                                  funcBtnRight: () async {
                                    await chiTietLichLamViecCubit
                                        .dataDelete(widget.id);
                                    Navigator.pop(context, true);
                                  },
                                  title: S.current.xoa_lich_lam_viec,
                                  btnRightTxt: S.current.dong_y,
                                  icon: SvgPicture.asset(
                                      ImageAssets.icDeleteLichHop),
                                );
                              },
                            ),
                            CellPopPupMenu(
                              urlImage: ImageAssets.icEditBlue,
                              text: S.current.sua_lich,
                              onTap: () {
                                showBottomSheetCustom(
                                  context,
                                  title: '',
                                  textOption: false,
                                  child: SuaLichCongTacTrongNuocPhone(
                                    cubit: chiTietLichLamViecCubit,
                                    event: data,
                                  ),
                                ).then((value){
                                  if (value == true) {
                                    Navigator.pop(context,true);
                                  } else if (value == null) {
                                    return;
                                  }
                                });
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
                          color: AqiColor,
                        ),
                      ),
                    ),
                    body: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: statusCalenderRed,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      data.title ?? '',
                                      style: textNormalCustom(
                                        color: textTitle,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                ItemRowChiTiet(
                                  data: data,
                                  cubit: chiTietLichLamViecCubit,
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              child: BtnShowChinhSuaBaoCao(
                                chiTietLichLamViecCubit:
                                    chiTietLichLamViecCubit,
                              ),
                            ),
                            DanhSachYKienButtom(
                              cubit: chiTietLichLamViecCubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold();
          }),
    );
  }
}
