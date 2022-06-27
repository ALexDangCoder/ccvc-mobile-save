import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/nhan_dien_khuon_mat_ui_model.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DiemDanhCubit extends BaseCubit<DiemDanhState> {
  DiemDanhCubit() : super(const DiemDanhStateIntial());

  DiemDanhRepository get diemDanhRepo => Get.find();

  ///variable menu
  BehaviorSubject<TypeDiemDanh> typeDiemDanhSubject =
      BehaviorSubject.seeded(TypeDiemDanh.CA_NHAN);

  Stream<TypeDiemDanh> get typeDiemDanhStream => typeDiemDanhSubject.stream;

  /// ................................

  /// quan ly nhan dien khuon mat

  BehaviorSubject<File> imagePickerSubject = BehaviorSubject();
  Stream<File> get imagePickerStream => imagePickerSubject.stream;

  ///Fake data
  String xeMay = 'Xe máy';
  String bienKiemSoat = '29x5 38534';
  String loaiSoHuu = 'Xe cán bộ';

  /// ................................

  BehaviorSubject<List<LoaiXeModel>> loaiXeSubject = BehaviorSubject.seeded(
    [
      LoaiXeModel(ten: S.current.xe_may),
      LoaiXeModel(ten: S.current.xe_o_to),
    ],
  );

  BehaviorSubject<bool> nhanDienbienSoxe = BehaviorSubject.seeded(false);

  BehaviorSubject<ThongKeDiemDanhCaNhanModel> thongKeSubject =
      BehaviorSubject();
  BehaviorSubject<List<BangDiemDanhCaNhanModel>> listBangDiemDanh =
      BehaviorSubject<List<BangDiemDanhCaNhanModel>>();

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
