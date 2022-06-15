import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DiemDanhCubit extends BaseCubit<DiemDanhState> {
  DiemDanhCubit() : super(const DiemDanhStateIntial());

  DiemDanhRepository get repo => Get.find();

  String xeMay = 'Xe máy';
  String bienKiemSoat = '29x5 38534';
  String loaiSoHuu = 'Xe cán bộ';

  BehaviorSubject<List<LoaiXeModel>> loaiXeSubject = BehaviorSubject.seeded(
    [
      LoaiXeModel(ten: S.current.xe_may),
      LoaiXeModel(ten: S.current.xe_o_to),
    ],
  );
  BehaviorSubject<bool> nhanDienbienSoxe=BehaviorSubject.seeded(false);

  // List<String> loaiXeList = ['Xe máy', 'Ô tô'];
  BehaviorSubject<List<bool>> selectTypeDiemDanhSubject =
      BehaviorSubject.seeded([true, false, false]);
  List<ThongKeDiemDanhCaNhanModel> listThongKeDiemDanh = [
    ThongKeDiemDanhCaNhanModel(title: 'Số lần đi muộn', number: 8),
    ThongKeDiemDanhCaNhanModel(title: 'Số lần về sớm', number: 12),
    ThongKeDiemDanhCaNhanModel(title: 'Số ngày nghỉ', number: 1),
    ThongKeDiemDanhCaNhanModel(title: 'Số ngày phép còn lại', number: 3),
  ];
}
