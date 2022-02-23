import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/ui/tablet/widgets/btn_show_bao_cao_tablet.dart';
import 'package:ccvc_mobile/presentation/lichlv_danh_sach_y_kien/ui/tablet/show_bottom_sheet_ds_y_Kien_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietLamViecTablet extends StatefulWidget {
  const ChiTietLamViecTablet({Key? key}) : super(key: key);

  @override
  _ChiTietLamViecTabletState createState() => _ChiTietLamViecTabletState();
}

class _ChiTietLamViecTabletState extends State<ChiTietLamViecTablet> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  int count = 0;

  @override
  void initState() {
    super.initState();
    chiTietLichLamViecCubit.data('dcfb06d3-09df-44f6-adbc-ea31ba69697f');
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
                      showTablet: true,
                      textContent: S.current.ban_chan_chan_huy_lich_nay,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {
                        chiTietLichLamViecCubit.cancel('dcfb06d3-09df-44f6-adbc-ea31ba69697f');
                        Navigator.pop(context);
                      },
                      title: S.current.huy_lich,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.icHuyLich),
                    );
                  }),
              QData(
                  urlImage: ImageAssets.icChartFocus,
                  text: S.current.bao_cao_ket_qua,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icChoYKien,
                  text: S.current.cho_y_kien,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icDelete,
                  text: S.current.xoa_lich,
                  onTap: () {
                    showDiaLog(
                      context,
                      showTablet: true,
                      textContent: S.current.ban_co_muon_xoa_lich_lam_viec,
                      btnLeftTxt: S.current.khong,
                      funcBtnRight: () {},
                      title: S.current.xoa_lich_lam_viec,
                      btnRightTxt: S.current.dong_y,
                      icon: SvgPicture.asset(ImageAssets.icDeleteLichHop),
                    );
                  }),
              QData(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {}),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: toDayColor.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowContainerColor.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<ChiTietLichLamViecModel>(
            stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final data = snapshot.data;

              final listText = data
                      ?.dataRow()
                      .where((element) => element.type == typeData.text)
                      .toList() ??
                  [];

              final listText1 = listText.sublist(0, 2);
              final listText2 = listText.sublist(3, listText.length);

              return Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 16,
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: listText1
                                      .map(
                                        (e) => Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 24,
                                          ),
                                          child: RowValueWidget(
                                            row: e,
                                            isTablet: true,
                                            isMarinLeft: true,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Column(
                                  children: listText2
                                      .map(
                                        (e) => Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 24,
                                          ),
                                          child: RowValueWidget(
                                            row: e,
                                            isTablet: true,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              child: BtnShowBaoCaoTablet(
                                cubit: chiTietLichLamViecCubit,
                              ),
                            ),
                            const DanhSachYKienButtomTablet(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (data
                                      ?.dataRow()
                                      .where(
                                        (element) =>
                                            element.type == typeData.listperson,
                                      )
                                      .toList())
                                  ?.map(
                                    (e) => RowValueWidget(
                                      row: e,
                                      isTablet: true,
                                    ),
                                  )
                                  .toList() ??
                              [
                                Container(),
                              ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
