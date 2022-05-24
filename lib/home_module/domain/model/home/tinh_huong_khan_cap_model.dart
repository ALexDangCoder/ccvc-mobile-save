class TinBuonModel {
  String id = '';
  bool isLink = false;
  String? linkOrContent;
  String title = '';

  TinBuonModel({
    required this.id,
    required this.isLink,
    this.linkOrContent,
    required this.title,
  });
}
