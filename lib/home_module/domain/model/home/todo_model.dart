import 'package:flutter/material.dart';

class TodoListModel {
  final List<TodoModel> listTodoImportant;
  final List<TodoModel> listTodoDone;

  TodoListModel({required this.listTodoImportant, required this.listTodoDone});
}

class TodoModel {
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

  TodoModel({
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
  });
}

enum IconListCanBo { UP, DOWN, CLOSE }

class IconModdel {
  Widget icon;
  void Function() onTapItem;

  IconModdel({required this.icon, required this.onTapItem});
}

class ItemRowData {
  final String infor;
  final String? id;

  ItemRowData({required this.infor, this.id});
}
