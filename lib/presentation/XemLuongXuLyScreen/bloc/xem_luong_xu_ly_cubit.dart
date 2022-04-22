import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/bloc/xem_luong_xu_ly_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class XemLuongXuLyCubit extends BaseCubit<XemLuongXuLyVBDenState> {
  XemLuongXuLyCubit() : super(XemLuongXuLyVBDenStateInitial());

  QLVBRepository get service => Get.find();

  final BehaviorSubject<NodePhanXuLy<DonViLuongModel>> _getPhanXuLy =
      BehaviorSubject<NodePhanXuLy<DonViLuongModel>>();

  Future<void> xemLuongXuLyVbDen(String id) async {
    showLoading();
    final result = await service.getLuongXuLyVanBanDen(id);
    showContent();
    result.when(
        success: (res) {
          if (res != null) {
            // final node = NodePhanXuLy(_value);
            _getPhanXuLy.sink.add(res);
          }
        },
        error: (err) {});
  }

  Stream<NodePhanXuLy<DonViLuongModel>> get getPhanXuLy => _getPhanXuLy.stream;
}
