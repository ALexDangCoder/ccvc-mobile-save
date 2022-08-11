import 'package:flutter/material.dart';

class TodoListModel {
  List<TodoModel> listTodoImportant;
  List<TodoModel> listTodoDone;

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
  String? performer;
  String? name;

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
    this.performer,
    this.name = '',
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

class NguoiGanModel {
  final String id;
  final String name;

  NguoiGanModel({required this.id, required this.name});
}
