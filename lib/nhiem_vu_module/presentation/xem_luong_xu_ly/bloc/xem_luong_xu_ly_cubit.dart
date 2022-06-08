import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/luong_xu_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/bloc/xem_luong_xu_ly_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class XemLuongXuLyNhiemVuCubit extends BaseCubit<XemLuongXuLyVBDenState> {
  XemLuongXuLyNhiemVuCubit() : super(XemLuongXuLyVBDenStateInitial());

  NhiemVuRepository get service => Get.find();

  final BehaviorSubject<NodePhanXuLy<DonViLuongNhiemVuModel>> _getPhanXuLy =
      BehaviorSubject<NodePhanXuLy<DonViLuongNhiemVuModel>>();

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

  Stream<NodePhanXuLy<DonViLuongNhiemVuModel>> get getPhanXuLy =>
      _getPhanXuLy.stream;
}
