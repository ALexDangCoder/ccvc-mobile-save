import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:flutter/material.dart';

enum TypeDetail {
  LICH_HOP,
  LICH_LAM_VIEC,
  VAN_BAN_DI,
  VAN_BAN_DEN,
  NHIEM_VU,
  CONG_VIEC
}

extension StringToEnum on String {
  TypeDetail get getEnumDetail {
    switch (this) {
      case 'LICH_HOP':
        return TypeDetail.LICH_HOP;

      case 'LICH_LAM_VIEC':
        return TypeDetail.LICH_LAM_VIEC;

      case 'VAN_BAN_DI':
        return TypeDetail.VAN_BAN_DEN;

      case 'VAN_BAN_DEN':
        return TypeDetail.VAN_BAN_DI;

      case 'CONG_VIEC':
        return TypeDetail.CONG_VIEC;

      case 'NHIEM_VU':
        return TypeDetail.NHIEM_VU;

      default:
        return TypeDetail.LICH_HOP;
    }
  }
}

extension GetScreenDetail on TypeDetail {
  void getScreenDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (this) {
            case TypeDetail.LICH_HOP:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            case TypeDetail.LICH_LAM_VIEC:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            case TypeDetail.NHIEM_VU:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            case TypeDetail.CONG_VIEC:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            case TypeDetail.VAN_BAN_DI:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            case TypeDetail.VAN_BAN_DEN:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );

            default:
              return const DetailMeetCalenderScreen(
                id: 'f163c296-a2b7-4dbf-9d3c-1d8b62e122d0',
              );
          }
        },
      ),
    );
  }
}
