class MessageModel {
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  MessageModel({
    required this.statusCode,
    required this.succeeded,
    required this.code,
    required this.message,
  });
}
