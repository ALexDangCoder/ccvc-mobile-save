import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/domain/model/cap_nhat_thong_tin_khach/LoaiTheModel.dart';
import 'package:ccvc_mobile/domain/repository/thong_tin_khach/thong_tin_khach_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/services/thong_tin_khach/thong_tin_khach_service.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/bloc/cap_nhat_tong_tin_khach_hang_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class CapNhatThongTinKhachHangCubit
    extends BaseCubit<CapNhatThongTinKhachHangState> {
  CapNhatThongTinKhachHangCubit()
      : super(
    CapNhatThongTinKhachHangStateIntial(),
  );

  ThongTinKhachRepository get _thongTinKhach => Get.find();
  BehaviorSubject<List<LoaiTheModel>> loaiTheSubject = BehaviorSubject.seeded([
    LoaiTheModel(ten: S.current.chung_minh_nhan_dan),
    LoaiTheModel(ten: S.current.can_cuoc_cong_dan),
  ]);
  List<String> dataGioiTinh = [
    'Nam',
    'Nữ',
  ];

  Future<void> postThongTinKhach(
      ) async {
    TaoThongTinKhachRequest taoThongTinKhachRequest = TaoThongTinKhachRequest(
      birth: DateTime.now().millisecondsSinceEpoch,
      cardId: 'cardId',
      department: 'department',
      homeTown: 'homeTown',
      name: 'name ',
      no: 'no',
      place: 'place',
      reason: 'reason',
      receptionPerson: 'receptionPerson',
      sex: 'sex',
      typeDoc: 'typeDoc',);
    print(taoThongTinKhachRequest.name);
    final result =
    await _thongTinKhach.taoThongTinKhach(taoThongTinKhachRequest);
    result.when(success: (res) {
      print(res.desc);
    }, error: (err) {});
  }
}
