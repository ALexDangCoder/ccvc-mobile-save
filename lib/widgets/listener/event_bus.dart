import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/tab_widget_extension.dart';
import 'package:event_bus/event_bus.dart';

final EventBus eventBus = EventBus();

class UnAuthEvent {
  final String message;

  UnAuthEvent(this.message);
}

class FireTopic {
  final int topic;

  FireTopic(this.topic);
}

class ApiSuccessAttendance {
  final bool update;

  ApiSuccessAttendance(this.update);
}

class RefreshCalendar {
  RefreshCalendar();
}

class ListSearchListNode {
  final List<Node<DonViModel>> listNode;

  ListSearchListNode(this.listNode);
}

class CallBackNguoiGan {
  final String id;

  CallBackNguoiGan(this.id);
}

class DateSearchEvent {
  final String startDate;
  final String endDate;

  DateSearchEvent(this.startDate, this.endDate);
}

class RefreshThanhPhanThamGia {
  RefreshThanhPhanThamGia();
}

class RefreshPhanCongThuKi {
  RefreshPhanCongThuKi();
}

class ReloadMeetingDetail {
  final List<TabWidgetDetailMeet> tabReload;
  const ReloadMeetingDetail(this.tabReload);
}
