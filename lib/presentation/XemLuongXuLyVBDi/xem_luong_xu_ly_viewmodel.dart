import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qlvb_mobile/BusinessLayer/DataAccess/Http/Core/Di/di.dart';
import 'package:qlvb_mobile/BusinessLayer/DataAccess/Http/Services/detail_income_document_service.dart';
import 'package:qlvb_mobile/Model/JobProcessor/tree_don_vi_phan_xu_ly_model.dart';
import 'package:qlvb_mobile/Model/luong_xu_ly_vb_di_model.dart';
import 'package:rxdart/rxdart.dart';

class XemLuongXuLyVBDIViewModel {
  DetailInComeDocumentService get service =>
      getIt<DetailInComeDocumentService>();
  final BehaviorSubject<NodePhanXuLy<LuongXuLyVBDiModel>> _luongXuLy =
      BehaviorSubject();
  List<LuongXuLyVBDiModel> dataList = [];
  Stream<NodePhanXuLy<LuongXuLyVBDiModel>> get luongXuLy => _luongXuLy.stream;

  Future<void> getLuongXuLyVanBanDen(String id) async {
    EasyLoading.show();
    final result =
        await service.getLuongXuLyVBDi(id);
    EasyLoading.dismiss();
    if (result.hasData) {
      dataList = result.data ?? [];
      final listParent = dataList.where((element) => element.idCha == null);
      if (listParent.isNotEmpty) {
        final parent = listParent.first;
        final NodePhanXuLy<LuongXuLyVBDiModel> nodeParent =
            NodePhanXuLy<LuongXuLyVBDiModel>(parent);
        makeBuildTree(nodeParent,
            dataList.where((element) => element.idCha == parent.id).toList());
        _luongXuLy.sink.add(nodeParent);
      }
    }
  }

  void makeBuildTree(NodePhanXuLy<LuongXuLyVBDiModel> node,
      List<LuongXuLyVBDiModel> children) {
    if (children.isNotEmpty) {
      for (var element in children) {
        final NodePhanXuLy<LuongXuLyVBDiModel> nodeParent =
            NodePhanXuLy<LuongXuLyVBDiModel>(element);
        node.addChild(nodeParent);
        makeBuildTree(
            nodeParent, dataList.where((e) => e.idCha == element.id).toList());
      }
    }
  }
}
