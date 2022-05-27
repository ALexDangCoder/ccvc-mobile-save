import '../chi_tiet_lich_hop_cubit.dart';

///Công tác chuẩn bị
extension CongTacChuanBi on DetailMeetCalenderCubit {
  Future<void> getThongTinPhongHopApi() async {
    final result = await hopRp.getListThongTinPhongHop(id);
    result.when(
      success: (res) {
        getThongTinPhongHopSb.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> getDanhSachThietBi() async {
    final result = await hopRp.getListThietBiPhongHop(id);
    result.when(
      success: (res) {
        showContent();
        getListThietBiPhongHop.sink.add(res);
      },
      error: (err) {
        showError();
      },
    );
  }
}
