class ToDoListRequest {
  String? id;
  String? label;
  bool? isTicked;
  bool? important;
  bool? inUsed;
  bool? isDeleted;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;
  String? groupId;
  String? finishDay;
  String? note;
  String? status;
  String? performer;

  ToDoListRequest({
    this.id,
    this.label,
    this.isTicked,
    this.important,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
    this.groupId,
    this.finishDay,
    this.note,
    this.status,
    this.performer,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['isTicked'] = isTicked;
    data['important'] = important;
    data['inUsed'] = inUsed;
    data['isDeleted'] = isDeleted;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['updatedOn'] = updatedOn;
    data['updatedBy'] = updatedBy;
    data['groupId'] = groupId;
    data['finishDay'] = finishDay;
    data['note'] = note;
    data['status'] = status;
    data['performer'] = performer;
    return data;
  }
}

class CreateToDoRequest {
  String? label;
  bool? isTicked;
  bool? important;
  bool? inUsed;
  String? groupId;
  String? finishDay;
  String? note;
  String? performer;

  CreateToDoRequest({
    this.label,
    this.isTicked,
    this.important,
    this.inUsed,
    this.groupId,
    this.finishDay,
    this.note,
    this.performer,
  });

  CreateToDoRequest.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    label = json['label'];
    isTicked = json['isTicked'];
    important = json['important'];
    finishDay = json['finishDay'];
    note = json['note'];
    performer = json['performer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupId'] = groupId;
    data['label'] = label;
    data['isTicked'] = isTicked;
    data['important'] = important;
    data['inUsed'] = inUsed;
    data['finishDay'] = finishDay;
    data['note'] = note;
    data['performer'] = performer;
    return data;
  }
}
