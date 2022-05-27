import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_theo_thoi_gian_request.g.dart';

@JsonSerializable()
class TreeNode {
  String title;
  int id;

  TreeNode({
    required this.title,
    required this.id,
  });

  factory TreeNode.fromJson(Map<String, dynamic> json) =>
      _$TreeNodeFromJson(json);

  Map<String, dynamic> toJson() => _$TreeNodeToJson(this);
}

@JsonSerializable()
class ThongKeTheoThoiGianRequest {
  List<TreeNode> treeNodes;
  int sourceId;
  String fromDate;
  String toDate;

  ThongKeTheoThoiGianRequest({
    required this.treeNodes,
    required this.sourceId,
    required this.fromDate,
    required this.toDate,
  });

  factory ThongKeTheoThoiGianRequest.fromJson(Map<String, dynamic> json) =>
      _$ThongKeTheoThoiGianRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeTheoThoiGianRequestToJson(this);
}
