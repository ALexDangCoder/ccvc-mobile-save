import 'dart:developer';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/document/luong_xu_ly_vb_di.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyVBDi/bloc/xem_luong_xu_ly_state.dart';
import 'package:get/get.dart';

import 'package:rxdart/rxdart.dart';

class XemLuongXuLyVBDICubit extends BaseCubit<XemLuongXuLyState> {
  XemLuongXuLyVBDICubit() : super(XemLuongXuLyStateInitial());

  QLVBRepository get service => Get.find();
  final BehaviorSubject<NodePhanXuLy<LuongXuLyVBDiModel>> _luongXuLy =
      BehaviorSubject();
  List<LuongXuLyVBDiModel> dataList = [];
  Stream<NodePhanXuLy<LuongXuLyVBDiModel>> get luongXuLy => _luongXuLy.stream;

  Future<void> getLuongXuLyVanBanDen(String id) async {
    showLoading();
    final result = await service.getLuongXuLyVanBanDi(id);
    showContent();
    result.when(
      success: (res) {
        dataList = res;
        // log('>>>>>>>>><<<<<<<<${dataList}');
        final listParent = dataList.where((element) => element.idCha == null);
        if (listParent.isNotEmpty) {
          final parent = listParent.last;
          final NodePhanXuLy<LuongXuLyVBDiModel> nodeParent =
              NodePhanXuLy<LuongXuLyVBDiModel>(parent);
          makeBuildTree(
            nodeParent,
            dataList.where((element) => element.idCha == parent.id).toList(),
          );
          _luongXuLy.sink.add(nodeParent);
        }
      },
      error: (err) {},
    );
  }

  void makeBuildTree(
    NodePhanXuLy<LuongXuLyVBDiModel> node,
    List<LuongXuLyVBDiModel> children,
  ) {
    if (children.isNotEmpty) {
      for (final element in children) {
        final NodePhanXuLy<LuongXuLyVBDiModel> nodeParent =
            NodePhanXuLy<LuongXuLyVBDiModel>(element);
        node.addChild(nodeParent);
        log('>>>>>>>>>>>>>>>>>>>>>${element}');
        makeBuildTree(
          nodeParent,
          dataList.where((e) => e.idCha == element.id).toList(),
        );
      }
    }
  }
}
