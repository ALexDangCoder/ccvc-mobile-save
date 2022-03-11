import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:flutter/material.dart';

enum TypeCalendar { MeetingSchedule, Schedule }

extension GetTypeCalendar on String {
  TypeCalendar get getTypeCalendar {
    switch (this) {
      case 'MeetingSchedule':
        return TypeCalendar.MeetingSchedule;
      case 'Schedule':
        return TypeCalendar.Schedule;
      default:
        return TypeCalendar.MeetingSchedule;
    }
  }
}

extension typeCalendar on TypeCalendar {
  void navigatorDetail(BuildContext context, CalenderCubit cubit) {
    switch (this) {
      case TypeCalendar.Schedule:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietLichLamViecScreen(
                id: cubit.dataLichLvModel.listLichLVModel?[index].id ?? '',
              ),
            ),
          );

          break;
        }

      case TypeCalendar.MeetingSchedule:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMeetCalenderScreen(
                id: cubit.dataLichLvModel.listLichLVModel?[index].id ?? '',
              ),
            ),
          );

          break;
        }

      default:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietLichLamViecScreen(
                id: cubit.dataLichLvModel.listLichLVModel?[index].id ?? '',
              ),
            ),
          );

          break;
        }
    }
  }

  void navigatorDetailTablet(BuildContext context, String id) {
    switch (this) {
      case TypeCalendar.Schedule:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietLamViecTablet(
                id: id,
              ),
            ),
          );

          break;
        }

      case TypeCalendar.MeetingSchedule:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMeetCalenderTablet(
                id: id,
              ),
            ),
          );

          break;
        }

      default:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietLamViecTablet(
                id: id,
              ),
            ),
          );

          break;
        }
    }
  }
}
