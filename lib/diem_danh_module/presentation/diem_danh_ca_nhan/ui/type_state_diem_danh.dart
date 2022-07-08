import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TypeStateDiemDanh { MUON, NGHI_LAM, DI_LAM, VE_SOM, NGHI_PHEP }

extension StateDiemDanh on TypeStateDiemDanh {
  String get getIcon {
    switch (this) {
      case TypeStateDiemDanh.MUON:
        return ImageAssets.icMuon;
      case TypeStateDiemDanh.DI_LAM:
        return ImageAssets.icDiLam;
      case TypeStateDiemDanh.NGHI_LAM:
        return ImageAssets.icNghiLam;
      case TypeStateDiemDanh.VE_SOM:
        return ImageAssets.icDiLam;
      case TypeStateDiemDanh.NGHI_PHEP:
        return ImageAssets.icDiLam;
    }
  }

  ///TODO
  // Widget getView({
  //   required String? timeIn,
  //   required String? timeOut,
  //   required bool islate,
  //   required double leave,
  // }) {
  //   switch (this) {
  //     case TypeStateDiemDanh.NGHI_LAM:
  //       return SvgPicture.asset(ImageAssets.icNghiLam);
  //     case TypeStateDiemDanh.MUON:
  //       return Column(
  //         children: [
  //           SvgPicture.asset(ImageAssets.icMuon),
  //           spaceH10,
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               vertical: 4,
  //               horizontal: 12,
  //             ),
  //             decoration: BoxDecoration(
  //               color: colorEA5455,
  //               borderRadius: BorderRadius.circular(2),
  //             ),
  //             child: Text(
  //               getStringDate(timeIn, timeOut),
  //               style: textNormalCustom(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     case TypeStateDiemDanh.DI_LAM:
  //       return Column(
  //         children: [
  //           // Row(
  //           //   children: [Text(
  //           //     rangeDate(timeIn, timeOut).toString()
  //           //   )],
  //           // ),spaceH10,
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               vertical: 4,
  //               horizontal: 12,
  //             ),
  //             decoration: BoxDecoration(
  //               color: colorEA5455,
  //               borderRadius: BorderRadius.circular(2),
  //             ),
  //             child: Text(
  //               getStringDate(timeIn, timeOut),
  //               style: textNormalCustom(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //
  //     case TypeStateDiemDanh.VE_SOM:
  //       return Column(
  //         children: [
  //           // Row(
  //           //   children: [Text(
  //           //     rangeDate(timeIn, timeOut).toString()
  //           //   )],
  //           // ),spaceH10,
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               vertical: 4,
  //               horizontal: 12,
  //             ),
  //             decoration: BoxDecoration(
  //               color: colorEA5455,
  //               borderRadius: BorderRadius.circular(2),
  //             ),
  //             child: Text(
  //               getStringDate(timeIn, timeOut),
  //               style: textNormalCustom(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //   }
  // }

  String getStringDate(String? timeIn, String? timeOut) {
    if (timeIn == null && timeOut != null) {
      return '??:$timeOut';
    }

    if (timeOut == null && timeIn != null) {
      return '$timeIn:??';
    }

    if (timeIn == null && timeOut == null) {
      return '??:??';
    }

    if (timeIn != null && timeOut != null) {
      return '$timeIn:$timeOut';
    }

    return '??:??';
  }
}
