import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/buttom_chi_tiet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
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
    chiTietLichLamViecCubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_lam_viec,
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(ImageAssets.icMenuDot),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        leadingIcon: GestureDetector(
          onTap: () {},
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
                  const SizedBox(height: 28,),
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
                              child: ButtomChiTietWidget(
                                title: S.current.danh_sach_bao_cao_ket_qua,
                                icon: ImageAssets.icGraph,
                                onTap: () {},
                              ),
                            ),
                            ButtomChiTietWidget(
                              onTap: () {},
                              title: S.current.danh_sach_y_kien,
                              icon: ImageAssets.icMess,
                            )
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
    ;
  }
}
