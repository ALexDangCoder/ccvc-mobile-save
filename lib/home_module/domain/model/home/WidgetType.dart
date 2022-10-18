import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import '/home_module/utils/constants/app_constants.dart';

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
  sinhNhat,
  vanBanDonVi,
  phanAnhKienNghiDonVi,
}

class WidgetModel {
  String id = '';
  String name = '';
  String component = '';
  String? widgetTypeId;
  String? description;
  String? code;
  int? width;
  int? height;
  int? minWidth;
  int? minHeight;
  int? maxHeight;
  int? maxWidth;
  Map<String, dynamic>? props = {};
  bool? static;
  bool? isResizable;
  String? thumbnail;
  String? appId;
  int? order;
  bool? isShowing;
  int? x;
  int? y;
  int? i;
  bool? enable;
  bool? moved;
  int? w;
  int? h;
  int? maxH;
  int? maxW;
  int? minH;
  int? minW;
  WidgetType? widgetType;
  String? imagePre;

  WidgetModel({
    required this.id,
    required this.name,
    required this.component,
    this.widgetTypeId,
    this.description,
    this.code,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxHeight,
    this.maxWidth,
    this.props,
    this.static,
    this.isResizable,
    this.thumbnail,
    this.appId,
    this.order,
    this.isShowing,
    this.x,
    this.y,
    this.i,
    this.enable,
    this.moved,
    this.w,
    this.h,
    this.maxH,
    this.maxW,
    this.minH,
    this.minW,
    this.widgetType,
  }) {
    widgetType = fromEnum();
  } //

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
      case WidgetTypeConstant.SINH_NHAT:
        return WidgetType.sinhNhat;
      case WidgetTypeConstant.TINH_HINH_XU_LY_PAKN_DON_VI:
        return WidgetType.phanAnhKienNghiDonVi;
      case WidgetTypeConstant.NHIEM_VU:
        return WidgetType.nhiemVu;
      case WidgetTypeConstant.TINH_HINH_XU_LY_PAKN_CA_NHAN:
        return WidgetType.situationHandlingPeople;
      case WidgetTypeConstant.VAN_BAN_DON_VI:
        return WidgetType.vanBanDonVi;
    }
  }
}

class Props {
  Props();

  Props.fromJson();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

Map<String, dynamic> widgetModelToJson(WidgetModel instance) {
  String? setAppId;
  if (instance.appId == '') {
    setAppId = null;
  } else {
    setAppId = instance.appId;
  }
  return <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'widgetTypeId': instance.widgetTypeId,
    'description': instance.description,
    'code': instance.code,
    'width': instance.width,
    'height': instance.height,
    'minWidth': instance.minWidth,
    'minHeight': instance.minHeight,
    'maxHeight': instance.maxHeight,
    'maxWidth': instance.maxWidth,
    'component': instance.component,
    'static': instance.static,
    'isResizable': instance.isResizable,
    'thumbnail': instance.thumbnail,
    'appId': setAppId,
    'order': instance.order,
    'isShowing': instance.isShowing,
    'x': instance.x,
    'y': instance.y,
    'i': instance.i,
    'enable': instance.enable,
    'moved': instance.moved,
    'w': instance.w,
    'h': instance.h,
    'maxH': instance.maxH,
    'maxW': instance.maxW,
    'minH': instance.minH,
    'minW': instance.minW,
    'props': instance.props
  };
}
