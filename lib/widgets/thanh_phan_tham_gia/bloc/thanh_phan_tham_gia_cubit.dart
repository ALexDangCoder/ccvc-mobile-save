import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_state.dart';
import 'package:get/get.dart' as get_it;
import 'package:rxdart/rxdart.dart';

class ThanhPhanThamGiaCubit extends BaseCubit<ThanhPhanThamGiaState> {
  final List<DonViModel> listPeople = [];

  ThanhPhanThamGiaCubit() : super(MainStateInitial());
  DonViModel donViModel = DonViModel();

  ThanhPhanThamGiaReponsitory get hopRp => get_it.Get.find();
  bool phuongThucNhan = false;
  String idCanBoItem = '';
  String noiDung = '';
  final BehaviorSubject<List<DonViModel>> _listPeopleThamGia =
      BehaviorSubject<List<DonViModel>>();
  final BehaviorSubject<List<DonViModel>> listCanBoThamGia =
      BehaviorSubject<List<DonViModel>>();

  Stream<List<DonViModel>> get listPeopleThamGia => _listPeopleThamGia.stream;
  final List<DonViModel> listCanBo = [];
  final BehaviorSubject<bool> _phuongThucNhan = BehaviorSubject.seeded(false);

  Stream<bool> get phuongThucNhanStream => _phuongThucNhan.stream;

  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;

  String timeStart = '';
  String timeEnd = '';
  String dateStart = '';
  String dateEnd = '';

  void addPeopleThamGia(
    List<DonViModel> donViModel,
  ) {
    for (final vl in donViModel) {
      if (listPeople.indexWhere((element) => element.id == vl.id) == -1) {
        listPeople.add(vl);
      }
    }
    _listPeopleThamGia.sink.add(listPeople);
  }

  void addCanBoThamGia(
    List<DonViModel> donViModel,
  ) {
    listCanBoThamGia.sink.add(donViModel);
  }

  void xoaCanBoThamGia(
    DonViModel donViModel,
  ) {
    listCanBo.remove(donViModel);
    listCanBoThamGia.sink.add(listCanBo);
  }
  void addDonViPhoiHopKhac(DonViModel model) {
    listPeople.add(model);
    _listPeopleThamGia.add(listPeople);
  }

  void removeDonViPhoiHop(DonViModel model) {
    listPeople.remove(model);
    _listPeopleThamGia.add(listPeople);
  }

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

  void nhapNoiDungDonVi(String text, DonViModel donViModel) {
    donViModel.noidung = text.trim();
  }

  void deletePeopleThamGia(DonViModel donViModel) {
    listPeople.remove(donViModel);

    _listPeopleThamGia.sink.add(listPeople);
  }

  void changePhuongThucNhan({required bool value}) {
    _phuongThucNhan.sink.add(!value);
  }

  void dispose() {
    _phuongThucNhan.close();
    _listPeopleThamGia.close();
    _getTreeDonVi.close();
    listCanBoThamGia.close();
  }
}
