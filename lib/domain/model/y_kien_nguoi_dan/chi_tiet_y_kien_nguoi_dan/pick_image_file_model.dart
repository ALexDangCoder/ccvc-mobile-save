class PickImageFileModel {
  String? path;
  int? size;
  String? name;
  bool isInput;
  String? extension;

  PickImageFileModel({
    this.path,
    this.size,
    this.name,
    this.extension,
    this.isInput = false,
  });
}
