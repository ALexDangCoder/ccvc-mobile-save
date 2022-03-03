import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/nguoi_dan_model.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:rxdart/rxdart.dart';

class DanhSachYKienNguoiDanCubit extends BaseCubit<YKienNguoiDanState> {
  DanhSachYKienNguoiDanCubit() : super(YKienNguoiDanStateInitial());

  final BehaviorSubject<List<NguoiDanModel>> _listYKienNguoiDan =
      BehaviorSubject<List<NguoiDanModel>>();

  final BehaviorSubject<bool> _selectSreach = BehaviorSubject.seeded(false);

  Stream<List<NguoiDanModel>> get listYKienNguoiDan =>
      _listYKienNguoiDan.stream;

  Stream<bool> get selectSreach => _selectSreach.stream;

  void setSelectSearch() {
    _selectSreach.sink.add(!_selectSreach.value);
  }

  void getListYKien() {
    _listYKienNguoiDan.sink.add(listYKienNguoiDanFake);
  }

  List<NguoiDanModel> listYKienNguoiDanFake = [
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.DANG_XU_LY),
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.QUA_HAN),
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.DANG_XU_LY),
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.DANG_XU_LY),
    NguoiDanModel(
      ngheNghiep: 'Nhan vien van phong that nghiep',
      ngayThang: '18/10/2021',
      ten: 'Ha Kieu Anh',
      statusData: StatusYKien.QUA_HAN,
    ),
    NguoiDanModel(
      ngheNghiep: 'Nhan vien van phong that nghiep',
      ngayThang: '18/10/2021',
      ten: 'Ha Kieu Anh',
      statusData: StatusYKien.DANG_XU_LY,
    ),
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.DANG_XU_LY),
  ];
}
