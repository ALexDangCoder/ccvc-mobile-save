import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_state.dart';

class ChiTietCongViecNhiemVuCubit
    extends BaseCubit<ChiTietCongViecNhiemVuState> {
  ChiTietCongViecNhiemVuCubit() : super(const ChiTietCongViecNhiemVuIntial());

  ChiTietCongViecNhiemVuModel chiTietCongViecNhiemVuModel =
      ChiTietCongViecNhiemVuModel(
          dvGiaoviec: 'UBND tỉnh Đồng Nai',
          nguoiGiaoViec: 'Nguyễn Kim Long',
          dvCaNhanThucHien: 'UBND tỉnh Đồng Nai',
          hanXuLy: '2022-01-11T00:00:00',
          mucDoCongViec: 'Thường',
          noiDung: 'Chủ trì, phối hợp với các cơ quan chức năng');
}
