import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

part 'chia_se_bao_cao_state.dart';

class ChiaSeBaoCaoCubit extends BaseCubit<ChiaSeBaoCaoState> {
  ChiaSeBaoCaoCubit() : super(ChiaSeBaoCaoInitial()){
    showContent();
  }

  BehaviorSubject<List<NhomCungHeThong>> themNhomStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<bool> _isDuocTruyCapSubject = BehaviorSubject<bool>();

  Stream<bool> get isDuocTruyCapStream => _isDuocTruyCapSubject.stream;

  Sink<bool> get isDuocTruyCapSink => _isDuocTruyCapSubject.sink;

  Future<void> getGroup() async {}

  Future<void> getDonVi() async {}

  Future<void> getDoiTuongTruyCap() async {}

  Future<void> themMoiDoiTuong() async {}

  Future<void> chiaSeBaoCao() async {}

  void themNhom(String tenNhom) {
    if (listCheck.where((element) => element.tenNhom == tenNhom).isEmpty) {
      listCheck.add(
        listResponse.firstWhere((element) => element.tenNhom == tenNhom),
      );
    }
    themNhomStream.add(listCheck);
  }

  void xoaNhom(String tenNhom) {
    listCheck.remove(
      listResponse.firstWhere((element) => element.tenNhom == tenNhom),
    );
    themNhomStream.add(listCheck);
  }

  List<NhomCungHeThong> listResponse = [
    NhomCungHeThong(
      tenNhom: 'Nhóm A',
      listThanhVien: [
        ThanhVien(tenThanhVien: 'Lê Sỹ Lâm'),
        ThanhVien(tenThanhVien: 'Hà Văn Cường'),
        ThanhVien(tenThanhVien: 'Đỗ Đức Doanh'),
        ThanhVien(tenThanhVien: 'Tạ Quang Huy'),
      ],
    ),
    NhomCungHeThong(
      tenNhom: 'Nhóm B',
      listThanhVien: [
        ThanhVien(tenThanhVien: 'Lê Sỹ Lâm'),
        ThanhVien(tenThanhVien: 'Hà Văn Cường'),
      ],
    ),
    NhomCungHeThong(
      tenNhom: 'Nhóm C',
      listThanhVien: [
        ThanhVien(tenThanhVien: 'Lê Sỹ Lâm'),
      ],
    ),
  ];
  List<String> listDropDown = [
    'Nhóm A',
    'Nhóm B',
    'Nhóm C',
  ];

  List<NhomCungHeThong> listCheck = [];

// void getTree() {
//   hopRp.getTreeDonVi().then((value) {
//     value.when(
//       success: (res) {
//         _getTreeDonVi.sink.add(res);
//       },
//       error: (err) {},
//     );
//   });
// }

}
