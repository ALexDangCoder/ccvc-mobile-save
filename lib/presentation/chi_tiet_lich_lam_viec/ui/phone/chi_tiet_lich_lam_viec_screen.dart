import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/widgets/btn_show_chinh_sua_bao_cao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/show_bottom_sheet_ds_y_Kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/phone/sua_lich_cong_tac_trong_nuoc_screen.dart';
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

  @override
  void initState() {
    super.initState();
    // chiTietLichLamViecCubit.initData();

    chiTietLichLamViecCubit.loadApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_lam_viec,
        actions: [
          MenuSelectWidget(
            listSelect: [
              QData(
                urlImage: ImageAssets.icHuy,
                text: S.current.huy,
                onTap: () {
                  showDiaLog(
                    context,
                    textContent: S.current.ban_chan_chan_huy_lich_nay,
                    btnLeftTxt: S.current.khong,
                    funcBtnRight: () async{
                      await chiTietLichLamViecCubit.cancel(widget.id);
                      Navigator.pop(context,true);
                    },
                    title: S.current.huy_lich,
                    btnRightTxt: S.current.dong_y,
                    icon: SvgPicture.asset(ImageAssets.icHuyLich),
                  );
                },
              ),
              QData(
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
              QData(
                urlImage: ImageAssets.icChoYKien,
                text: S.current.cho_y_kien,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.cho_y_kien,
                    child: const YKienBottomSheet(),
                  );
                },
              ),
              QData(
                  urlImage: ImageAssets.icDelete,
                  text: S.current.xoa_lich,
                  onTap: () {
                    showDiaLog(
                      context,
                      textContent: S.current.ban_co_muon_xoa_lich_lam_viec,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: ()async {
                       await chiTietLichLamViecCubit.dataDelete(widget.id);
                       Navigator.pop(context,true);
                      },
                      title: S.current.xoa_lich_lam_viec,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.icDeleteLichHop),
                    );
                  }),
              QData(
                urlImage: ImageAssets.icEditBlue,
                text: S.current.sua_lich,
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.sua_lich_cong_tac_trong_nuoc,
                    child: const SuaLichCongTacTrongNuocPhone(),
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
            color: AqiColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    S.current.hop_noi_bo_cong_ty,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              StreamBuilder<ChiTietLichLamViecModel>(
                stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final data = snapshot.data;

                  return Column(
                    children: data
                            ?.dataRow()
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.only(top: 24),
                                child: RowValueWidget(
                                  row: e,
                                  isTablet: false,
                                ),
                              ),
                            )
                            .toList() ??
                        [Container()],
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: BtnShowChinhSuaBaoCao(
                    chiTietLichLamViecCubit: chiTietLichLamViecCubit),
              ),
              DanhSachYKienButtom(
                cubit: chiTietLichLamViecCubit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
