import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/bao_cao/report_repository.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart'as get_dart;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

part 'chia_se_bao_cao_state.dart';

class ChiaSeBaoCaoCubit extends BaseCubit<ChiaSeBaoCaoState> {
  ChiaSeBaoCaoCubit() : super(ChiaSeBaoCaoInitial()) {
    showContent();
  }

  ReportRepository get _repo => get_dart.Get.find();

  BehaviorSubject<List<NhomCungHeThong>> themNhomStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<String> callAPI =
  BehaviorSubject.seeded('');
  final BehaviorSubject<bool> _isDuocTruyCapSubject = BehaviorSubject<bool>();

  Stream<bool> get isDuocTruyCapStream => _isDuocTruyCapSubject.stream;

  Sink<bool> get isDuocTruyCapSink => _isDuocTruyCapSubject.sink;


  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
  BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;


  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();
  void getTree() {
    hopRp.getTreeDonVi().then((value) {
      value.when(
        success: (res) {
          _getTreeDonVi.sink.add(res);
        },
        error: (err) {},
      );
    });
  }

  Future<void> getGroup() async {
    listResponse.clear();
    listDropDown.clear();
    listCheck.clear();
    showLoading();
    final rs = await _repo.getListGroup();
    rs.when(
      success: (res) {
        for (int i = 0; i < res.length; i++) {
          getMemberInGroup(res[i].idNhom ?? '', res[i]);
        }
      },
      error: (error) {},
    );
  }

  Future<void> getMemberInGroup(
      String idGroup, NhomCungHeThong nhomCungHeThong) async {
    final rs = await _repo.getListThanhVien(idGroup);
    rs.when(
      success: (res) {
        listResponse.add(
          NhomCungHeThong(
            tenNhom: nhomCungHeThong.tenNhom,
            idNhom: nhomCungHeThong.idNhom,
            listThanhVien: res,
          ),
        );
        listDropDown.add(nhomCungHeThong.tenNhom ?? '');
        callAPI.add(SUCCESS);
        showContent();
      },
      error: (error) {},
    );
  }

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

  List<NhomCungHeThong> listResponse = [];
  List<String> listDropDown = [];

  List<NhomCungHeThong> listCheck = [];

}
