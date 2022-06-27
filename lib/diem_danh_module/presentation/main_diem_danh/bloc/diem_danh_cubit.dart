import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DiemDanhCubit extends BaseCubit<DiemDanhState> {
  DiemDanhCubit() : super(const DiemDanhStateIntial());

  DiemDanhRepository get diemDanhRepo => Get.find();

  final DataUser? dataUser = HiveLocal.getDataUser();

  ///variable menu
  BehaviorSubject<TypeDiemDanh> typeDiemDanhSubject =
      BehaviorSubject.seeded(TypeDiemDanh.CA_NHAN);

  Stream<TypeDiemDanh> get typeDiemDanhStream => typeDiemDanhSubject.stream;

  /// nhan dien khuon mat
  BehaviorSubject<File> imagePickerSubject = BehaviorSubject();
  Stream<File> get imagePickerStream => imagePickerSubject.stream;

  ///Fake data
  String xeMay = 'Xe máy';
  String bienKiemSoat = '29x5 38534';
  String loaiSoHuu = 'Xe cán bộ';

  ///dang ky bien so xe
  BehaviorSubject<List<LoaiXeModel>> loaiXeSubject = BehaviorSubject.seeded(
    [
      LoaiXeModel(ten: S.current.xe_may),
      LoaiXeModel(ten: S.current.xe_o_to),
    ],
  );

  BehaviorSubject<bool> nhanDienbienSoxe = BehaviorSubject.seeded(false);

  ///Diem danh ca nhan
  BehaviorSubject<ThongKeDiemDanhCaNhanModel> thongKeSubject =
      BehaviorSubject();
  BehaviorSubject<List<BangDiemDanhCaNhanModel>> listBangDiemDanh =
      BehaviorSubject<List<BangDiemDanhCaNhanModel>>();
}
