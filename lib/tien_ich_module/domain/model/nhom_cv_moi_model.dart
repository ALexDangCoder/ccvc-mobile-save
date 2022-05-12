class NhomCVMoiModel {
  String createdBy;
  String createdOn;
  String id;
  bool isDeleted;
  String label;
  String updatedBy;
  String updatedOn;
  int? number;

  NhomCVMoiModel(
      {this.createdBy = '',
      this.createdOn = '',
      this.id = '',
      this.isDeleted = false,
      this.label = '',
      this.updatedBy = '',
      this.updatedOn = '',
      this.number});
}
