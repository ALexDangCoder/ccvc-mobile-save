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
