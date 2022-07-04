import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DiemDanhCubit extends BaseCubit<DiemDanhState> {
  DiemDanhCubit() : super(const DiemDanhStateIntial());

  DiemDanhRepository get diemDanhRepo => Get.find();

  final DataUser? dataUser = HiveLocal.getDataUser();
  final String? tokken = PrefsService.getToken();

  ///variable menu
  BehaviorSubject<TypeDiemDanh> typeDiemDanhSubject =
      BehaviorSubject.seeded(TypeDiemDanh.CA_NHAN);

  Stream<TypeDiemDanh> get typeDiemDanhStream => typeDiemDanhSubject.stream;

  /// nhan dien khuon mat
  String idImg = '';
  BehaviorSubject<GetAllFilesIdModel> allFileDeokinhSubject = BehaviorSubject();

  Stream<GetAllFilesIdModel> get allFileDeokinhStream =>
      allFileDeokinhSubject.stream;

  BehaviorSubject<GetAllFilesIdModel> allFileKhongDeokinhSubject =
      BehaviorSubject();

  Stream<GetAllFilesIdModel> get allFileKhongDeokinhStream =>
      allFileKhongDeokinhSubject.stream;

  BehaviorSubject<GetAllFilesIdModel> getOnlyFileDataSubject =
      BehaviorSubject();

  Stream<GetAllFilesIdModel> get getOnlyFileDataStream =>
      getOnlyFileDataSubject.stream;

  ///item dang ky bien so xe
  String? xeMay;

  String? bienKiemSoat;
  String? loaiSoHuu;
  final toast = FToast();
  List<File>fileItemBienSoXe=[];
  BehaviorSubject<dynamic> idPicture = BehaviorSubject.seeded(null);

  BehaviorSubject<GetAllFilesIdModel>fileBienSoXeSubject = BehaviorSubject();

  Stream<GetAllFilesIdModel> get fileBienSoXeStream =>
      fileBienSoXeSubject.stream;

  ///dang ky bien so xe
  BehaviorSubject<List<LoaiXeModel>> loaiXeSubject = BehaviorSubject.seeded(
    [
      LoaiXeModel(ten: S.current.xe_may),
      LoaiXeModel(ten: S.current.xe_o_to),
    ],
  );

  BehaviorSubject<bool> nhanDienbienSoxeSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<List<ChiTietBienSoXeModel>> danhSachBienSoXeSubject =
      BehaviorSubject();

  ///Diem danh ca nhan
  BehaviorSubject<ThongKeDiemDanhCaNhanModel> thongKeSubject =
      BehaviorSubject();
  BehaviorSubject<List<BangDiemDanhCaNhanModel>> listBangDiemDanh =
      BehaviorSubject<List<BangDiemDanhCaNhanModel>>();
}
