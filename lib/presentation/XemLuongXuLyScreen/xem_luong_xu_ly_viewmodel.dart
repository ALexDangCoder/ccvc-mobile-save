
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:rxdart/rxdart.dart';

class XemLuongXuLyViewModel  {
  // XemLuongXuLyService get service => getIt<XemLuongXuLyService>();
  final BehaviorSubject<NodePhanXuLy<DonViLuongModel>> _getPhanXuLy =
      BehaviorSubject<NodePhanXuLy<DonViLuongModel>>();

  Future<void> xemLuongXuLyVbDen(String id) async {
    // EasyLoading.show();
    // final result = await service.getTreeLuongXuLyVanBanDen(id);
    // EasyLoading.dismiss();
    // if (result.hasData) {
    //   // final node = NodePhanXuLy(_value);
    //   _getPhanXuLy.sink.add(result.data!);
    // }
  }

  Stream<NodePhanXuLy<DonViLuongModel>> get getPhanXuLy => _getPhanXuLy.stream;
}
