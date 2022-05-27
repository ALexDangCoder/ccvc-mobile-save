import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

class TreeDonViThamGiaResponse {
  List<dynamic>? data;
  int? statusCode;
  bool? succeeded;

  TreeDonViThamGiaResponse({this.data, this.statusCode, this.succeeded});

  TreeDonViThamGiaResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = json['data'];
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }

  List<Node<DonViModel>> toDomain() {
    final List<Node<DonViModel>> listTree = [];
    data?.forEach((element) {
      final Node<DonViModel> tree = Node(Data.fromJson(element).toDomain());
      tree.expand = true;
      final children = element['children'] as List<dynamic>;
      _makeBuildTree(tree, children);
      listTree.add(tree);
    });
    return listTree;
  }

  void _makeBuildTree(Node<DonViModel> tree, List<dynamic> list) {
    if (list.isNotEmpty) {
      for (final vl in list) {
        final Node<DonViModel> treeNode = Node(Data.fromJson(vl).toDomain());
        final children = vl['children'] as List<dynamic>;
        tree.addChild(treeNode);
        _makeBuildTree(treeNode, children);
      }
    }
  }
}

class Data {
  String? id;
  String? tenDonVi;

  Data({this.id, this.tenDonVi});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenDonVi = json['tenDonVi'];
  }

  DonViModel toDomain() => DonViModel(id: id ?? '', name: tenDonVi ?? '');
}
