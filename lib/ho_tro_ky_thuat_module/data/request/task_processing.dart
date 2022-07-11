class TaskProcessing {
  TaskProcessing({
    this.id,
    this.taskId,
    this.comment,
    this.code,
    this.name,
    this.finishDay,
    this.handlerId,
    this.description,
  });

  String? id;
  String? taskId;
  String? comment;
  String? code;
  String? name;
  DateTime? finishDay;
  String? handlerId;
  String? description;

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskId': taskId,
    'comment': comment,
    'code': code,
    'name': name,
    'finishDay': finishDay?.toIso8601String(),
    'handlerId': handlerId,
    'description': description,
  };
}