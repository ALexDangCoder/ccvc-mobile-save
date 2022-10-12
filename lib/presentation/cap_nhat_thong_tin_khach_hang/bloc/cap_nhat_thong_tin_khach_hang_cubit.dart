import 'package:ccvc_mobile/domain/model/cap_nhat_thong_tin_khach/LoaiTheModel.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';

class CapNhatThongTinKhachHangCubit {
  BehaviorSubject<List<LoaiTheModel>> loaiTheSubject = BehaviorSubject.seeded([
    LoaiTheModel(ten: S.current.chung_minh_nhan_dan),
    LoaiTheModel(ten: S.current.can_cuoc_cong_dan),
  ]);
  List<String> dataGioiTinh = [
    'Nam',
    'Nữ',
    'Khác',
  ];
}
