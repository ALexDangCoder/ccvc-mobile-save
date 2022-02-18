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
