import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
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

class RefreshList {
  RefreshList();
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
