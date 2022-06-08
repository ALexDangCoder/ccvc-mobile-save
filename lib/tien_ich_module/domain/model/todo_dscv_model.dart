import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';

class TodoListModelTwo {
  final List<TodoDSCVModel> listTodoImportant;
  final List<TodoDSCVModel> listTodoDone;

  TodoListModelTwo(
      {required this.listTodoImportant, required this.listTodoDone});

  factory TodoListModelTwo.formList(List<TodoDSCVModel> data) {
    final List<TodoDSCVModel> important = [];
    final List<TodoDSCVModel> done = [];
    for (final TodoDSCVModel e in data) {
      if (e.inUsed ?? true) {
        important.add(e);
      } else {
        done.add(e);
      }
    }
    return TodoListModelTwo(listTodoImportant: important, listTodoDone: done);
  }
}

class TodoDSCVModel {
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
  String? note;
  String? performer;
  String? groupId;
  String? filePath;

  TodoDSCVModel({
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
    this.note,
    this.performer,
    this.groupId,
    this.filePath,
  });

  bool showDotOne() {
    if (performer != '' && createdOn != '' && performer != null) {
      return true;
    } else {
      return false;
    }
  }

  bool showDotTwo() {
    if (performer != '' && showIconNote()) {
      return true;
    } else {
      return false;
    }
  }

  bool showIconFile() {
    if (performer != '' && createdOn != '') {
      return true;
    } else {
      return false;
    }
  }

  bool showIconNote() {
    if (note == null || note == '') {
      return false;
    } else {
      return true;
    }
  }
}
