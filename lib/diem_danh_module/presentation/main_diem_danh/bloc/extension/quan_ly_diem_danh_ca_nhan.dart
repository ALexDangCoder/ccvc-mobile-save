import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';

extension QuanLyDiemDanhCaNhan on DiemDanhCubit {
  Future<void> postDiemDanhThongKe() async {
    final thongKeDiemDanhCaNhanRequest = ThongKeDiemDanhCaNhanRequest(
        thoiGian: '2022-06-01T00:00:00.00Z',
        userId: '93114dcb-dfe1-487b-8e15-9c378c168994');
    showLoading();
    final result =
    await diemDanhRepo.thongKeDiemDanh(thongKeDiemDanhCaNhanRequest);
    result.when(success: (res) {
      thongKeSubject.sink.add(res);
      showContent();
    }, error: (error) {
      showContent();
    });
  }

  Future<void> postBangDiemDanhCaNhan()
  async {
    final bangDiemDanhCaNhanRequest = BangDiemDanhCaNhanRequest(
        thoiGian: '2022-06-01T00:00:00.00Z',
        userId: '93114dcb-dfe1-487b-8e15-9c378c168994');
    showLoading();
    final result = await diemDanhRepo.bangDiemDanh(bangDiemDanhCaNhanRequest);
    result.when(success: (res) {
      listBangDiemDanh.sink.add(res.items ?? []);
    }, error: (err) {
      showContent();
    },);
  }
}
