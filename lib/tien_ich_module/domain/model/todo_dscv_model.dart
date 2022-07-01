import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';

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
    if (performer != '' && (showIconNote() || showIconFile())) {
      return true;
    } else {
      return false;
    }
  }

  bool showIconFile() {
    if (filePath != '' && filePath != null) {
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

class CountTodoModel {
  String? id;
  String? name;
  String? code;
  int? count;
  List<CountTodoModel>? childrenTodoViewModel;

  String icon() {
    switch (code) {
      case 'TodoMe':
        return isMobile() ? ImageAssets.icCVCuaBan : ImageAssets.ic01;
      case 'Ticked':
        return isMobile() ? ImageAssets.icHT : ImageAssets.ic03;
      case 'Important':
        return isMobile() ? ImageAssets.icCVQT : ImageAssets.ic02;
      case 'Deleted':
        return isMobile() ? ImageAssets.icXoa : ImageAssets.ic05;
      case 'TaskOfGiveOther':
        return isMobile() ? ImageAssets.icGanChoToi : ImageAssets.ic04;
      case 'GroupTodo':
        return ImageAssets.ic_nhomCVMoi;
    }
    return isMobile() ? ImageAssets.icCVCuaBan : ImageAssets.ic01;
  }

  CountTodoModel({
    this.id,
    this.name,
    this.code,
    this.count,
    this.childrenTodoViewModel,
  });
}
