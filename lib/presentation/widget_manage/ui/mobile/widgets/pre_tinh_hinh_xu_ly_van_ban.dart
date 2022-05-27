import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class PreTinhHinhXuLyVanBan extends StatelessWidget {
  final String sourceImg;

  const PreTinhHinhXuLyVanBan({Key? key, required this.sourceImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return PreContainerWidget(
    //   title: S.current.word_processing_state,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       titleChart(
    //         S.current.document_incoming,
    //         Column(
    //           children: [
    //             PieChart(
    //               paddingTop: 0,
    //               chartData: [
    //                 ChartData(
    //                   S.current.cho_vao_so,
    //                   10,
    //                   choVaoSoColor,
    //                 ),
    //                 ChartData(
    //                   S.current.dang_xu_ly,
    //                   20,
    //                   dangXyLyColor,
    //                 ),
    //                 ChartData(
    //                   S.current.cho_xu_ly,
    //                   15,
    //                   choXuLyColor,
    //                 ),
    //                 ChartData(
    //                   S.current.da_xu_ly,
    //                   25,
    //                   daXuLyColor,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 26,
    //             ),
    //             HanXuLyWidget(
    //               data: [
    //                 ChartData(S.current.qua_han, 5, statusCalenderRed),
    //                 ChartData(S.current.den_han,
    //                    10, yellowColor),
    //                 ChartData(S.current.trong_han,
    //                    15, choTrinhKyColor,)
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       titleChart(
    //         S.current.document_out_going,
    //           PieChart(
    //             chartData: [
    //               ChartData(
    //                   S.current.cho_trinh_ky,
    //                   4,
    //                   choTrinhKyColor),
    //               ChartData(
    //                   S.current.cho_xu_ly,
    //                   12,
    //                   choXuLyColor,),
    //               ChartData(
    //                   S.current.da_xu_ly,
    //                   15,
    //                   daXuLyColor,),
    //               ChartData(
    //                   S.current.cho_cap_so,
    //                   data.soLuongChoCapSo?.toDouble() ?? 0,
    //                   choCapSoColor,
    //                   SelectKey.CHO_CAP_SO),
    //               ChartData(
    //                   S.current.cho_ban_hanh,
    //                   data.soLuongChoBanHanh?.toDouble() ?? 0,
    //                   choBanHanhColor,
    //                   SelectKey.CHO_BAN_HANH)
    //             ],
    //             onTap: (value, key) {
    //               if (key != null) {
    //                 _xuLyCubit.selectTrangThaiVBDi(key);
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                         IncomingDocumentScreenDashBoard(
    //                           startDate: _xuLyCubit.startDate.toString(),
    //                           endDate: _xuLyCubit.endDate.toString(),
    //                           title: S.current.danh_sach_van_ban_di,
    //                           trangThaiFilter: _xuLyCubit.trangThaiFilter,
    //                           isDanhSachChoTrinhKy:
    //                           _xuLyCubit.isDanhSachChoTrinhKy,
    //                           isDanhSachChoXuLy: _xuLyCubit.isDanhSachChoXuLy,
    //                           isDanhSachDaXuLy: _xuLyCubit.isDanhSachDaXuLy,
    //                         ),
    //                   ),
    //                 );
    //               }
    //             },
    //           ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget titleChart(String title, Widget child) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormalCustom(
              color: infoColor,
              fontSize: 16,
            ),
          ),
          child
        ],
      ),
    );
  }
}
