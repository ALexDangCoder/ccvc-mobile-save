import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/status_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tham_gia_cuoc_hop_button.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../permission_type.dart';

class ThongTinCuocHopTabletWidget extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;

  const ThongTinCuocHopTabletWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietLichHopModel>(
      stream: cubit.chiTietLichHopSubject,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final data = snapshot.data ?? ChiTietLichHopModel();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Expanded(
                  child: Text(
                    data.title,
                    style: textNormalCustom(
                      color: titleCalenderWork,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                spaceW18,
                StreamBuilder<List<PERMISSION_DETAIL>>(
                  stream: cubit.listButtonSubject.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    if (data.contains(
                          PERMISSION_DETAIL.XAC_NHAN_THAM_GIA,
                        ) &&
                        data.contains(
                          PERMISSION_DETAIL.TU_CHOI_THAM_GIA,
                        ) &&
                        !cubit.trangThaiHuy() &&
                        !cubit.trangThaiThuHoi()) {
                      return SizedBox(
                        width: 300,
                        height: 40,
                        child: DoubleButtonBottom(
                          title1: S.current.tu_choi,
                          title2: S.current.tham_du,
                          onClickRight: () {
                            showDiaLog(
                              context,
                              btnLeftTxt: S.current.khong,
                              funcBtnRight: () {
                                cubit
                                    .confirmThamGiaHop(
                                  lichHopId: cubit.getChiTietLichHopModel.id,
                                  isThamGia: true,
                                )
                                    .then((value) {
                                  if (value) {
                                    MessageConfig.show(
                                      title: '${S.current.xac_nhan_tham_gia}'
                                          ' ${S.current.thanh_cong.toLowerCase()}',
                                    );
                                    cubit.initDataChiTiet(
                                      needCheckPermission: true,
                                    );
                                  } else {
                                    MessageConfig.show(
                                      messState: MessState.error,
                                      title: '${S.current.xac_nhan_tham_gia}'
                                          ' ${S.current.that_bai.toLowerCase()}',
                                    );
                                  }
                                });
                              },
                              title: S.current.xac_nhan_tham_gia,
                              btnRightTxt: S.current.dong_y,
                              icon: SvgPicture.asset(
                                ImageAssets.img_tham_gia,
                              ),
                              textContent: S.current.confirm_tham_gia,
                            );
                          },
                          onClickLeft: () {
                            showDiaLog(
                              context,
                              btnLeftTxt: S.current.khong,
                              funcBtnRight: () {
                                cubit
                                    .confirmThamGiaHop(
                                  lichHopId: cubit.getChiTietLichHopModel.id,
                                  isThamGia: false,
                                )
                                    .then((value) {
                                  if (value) {
                                    MessageConfig.show(
                                      title: '${S.current.tu_choi_tham_gia} '
                                          '${S.current.thanh_cong.toLowerCase()}',
                                    );
                                    cubit.initDataChiTiet(
                                      needCheckPermission: true,
                                    );
                                  } else {
                                    MessageConfig.show(
                                      messState: MessState.error,
                                      title: '${S.current.tu_choi_tham_gia}'
                                          ' ${S.current.that_bai.toLowerCase()}',
                                    );
                                  }
                                });
                              },
                              title: S.current.tu_choi_tham_gia,
                              btnRightTxt: S.current.dong_y,
                              icon: SvgPicture.asset(
                                ImageAssets.img_tu_choi_tham_gia,
                              ),
                              textContent: S.current.confirm_tu_choi_tham_gia,
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.valueData().map(
                      (element) {
                        if (element is HopTrucTuyenRow) {
                          return ThamGiaCuocHopWidget(
                            link: element.link,
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: RowDataWidget(
                            urlIcon: element.urlIcon,
                            text: element.text,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                spaceW16,
                Expanded(
                  child: Column(
                    children: [
                      spaceH24,
                      StatusWidget(
                        status: data.getStatus,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 16),
                        child: ThongTinLienHeWidget(
                          thongTinTxt: data.chuTriModel.dauMoiLienHe,
                          sdtTxt: data.chuTriModel.soDienThoai,
                          dsDiemCau: data.dsDiemCau ?? [],
                          thuMoiFiles: data.fileDinhKemWithDecode ?? [],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
