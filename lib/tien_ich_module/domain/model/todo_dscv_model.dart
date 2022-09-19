import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
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

class NguoiGiaoModel {
  String? tenCanBo;
  String? chucVu;
  String? idCanBo;

  NguoiGiaoModel({
    this.tenCanBo,
    this.chucVu,
    this.idCanBo,
  });

  String dataWithChucVu() {
    return '$tenCanBo${(chucVu ?? '').isNotEmpty ? ' - $chucVu' : ''}';
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
  String? finishDay;
  NguoiGiaoModel? nguoiGiao;

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
    this.finishDay,
    this.nguoiGiao,
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
      case DSCVScreen.CVCB:
        return ImageAssets.icCVCuaBan;
      case DSCVScreen.DHT:
        return ImageAssets.icHT;
      case DSCVScreen.CVQT:
        return ImageAssets.icCVQT;
      case DSCVScreen.DBX:
        return ImageAssets.icXoa;
      case DSCVScreen.DG:
        return ImageAssets.daGanSvg;
      case DSCVScreen.GCT:
        return ImageAssets.icGanChoToi;
      case DSCVScreen.NCVM:
        return ImageAssets.ic_nhomCVMoi;
    }
    return '';
  }

  CountTodoModel({
    this.id,
    this.name,
    this.code,
    this.count,
    this.childrenTodoViewModel,
  });
}
