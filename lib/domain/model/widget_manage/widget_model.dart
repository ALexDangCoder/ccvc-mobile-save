import 'package:ccvc_mobile/utils/constants/app_constants.dart';

enum WidgetType {
  wordProcessState,
  document,
  summaryOfTask,
  nhiemVu,
  situationHandlingPeople,
  peopleOpinions,
  workSchedule,
  meetingSchedule,
  pressSocialNetWork,
  listWork,
  eventOfDay,
  sinhNhat,
}

class WidgetModel {
  String id = '';
  String name = '';
  String component = '';
  WidgetType? widgetType;
  WidgetModel({
    required this.id,
    required this.name,
    required this.component,
  }) {
    widgetType = fromEnum();
  }
  WidgetType? fromEnum() {
    switch (component) {
      case WidgetTypeConstant.TINH_HINH_XU_LY_VAN_BAN:
        return WidgetType.wordProcessState;
      case WidgetTypeConstant.VAN_BAN:
        return WidgetType.document;
      case WidgetTypeConstant.TONG_HOP_NHIEM_VU:
        return WidgetType.summaryOfTask;
      case WidgetTypeConstant.Y_KIEN_NGUOI_DAN:
        return WidgetType.peopleOpinions;
      case WidgetTypeConstant.LICH_LAM_VIEC:
        return WidgetType.workSchedule;
      case WidgetTypeConstant.LICH_HOP:
        return WidgetType.meetingSchedule;
      case WidgetTypeConstant.BAO_CHI:
        return WidgetType.pressSocialNetWork;
      case WidgetTypeConstant.DANH_SANH_CONG_VIEC:
        return WidgetType.listWork;
      case WidgetTypeConstant.SU_KIEN_TRONG_NGAY:
        return WidgetType.eventOfDay;
      case WidgetTypeConstant.SINH_NHAT:
        return WidgetType.sinhNhat;
      case WidgetTypeConstant.TINH_HINH_XU_LY_Y_KIEN:
        return WidgetType.situationHandlingPeople;
      case WidgetTypeConstant.NHIEM_VU:
        return WidgetType.nhiemVu;
    }
  }
}
