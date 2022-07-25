import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_state.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:get/get.dart' as get_it;
import 'package:rxdart/rxdart.dart';

class ThanhPhanThamGiaCubit extends BaseCubit<ThanhPhanThamGiaState> {
  final List<DonViModel> listPeople = [];
  Node<DonViModel>? nodeDonViThemCanBo;

  ThanhPhanThamGiaCubit() : super(MainStateInitial());
  DonViModel donViModel = DonViModel();
  DonViModel newCanBo = DonViModel();

  List<DonViModel> listCanBoDuocChon = [];

  ThanhPhanThamGiaReponsitory get hopRp => get_it.Get.find();
  bool phuongThucNhan = false;
  String idCanBoItem = '';
  String noiDung = '';
  final BehaviorSubject<List<DonViModel>> _listPeopleThamGia =
      BehaviorSubject<List<DonViModel>>();
  final BehaviorSubject<List<DonViModel>> listCanBoThamGia =
      BehaviorSubject<List<DonViModel>>();
  final BehaviorSubject<bool> isDuplicateCanBo = BehaviorSubject.seeded(false);

  Stream<List<DonViModel>> get listPeopleThamGia => _listPeopleThamGia.stream;
  final List<DonViModel> listCanBo = [];
  final BehaviorSubject<bool> _phuongThucNhan = BehaviorSubject.seeded(false);

  Stream<bool> get phuongThucNhanStream => _phuongThucNhan.stream;

  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();
  final BehaviorSubject<List<Node<DonViModel>>> _getTreeCaNhan =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;

  Stream<List<Node<DonViModel>>> get getTreeCaNhan => _getTreeCaNhan.stream;

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

  void addPeopleThamGiaDonVi(
    List<DonViModel> donViModel,
  ) {
    final listDonVi =
        listPeople.where((element) => element.tenCanBo.trim().isEmpty).toList();
    for (final canBo in listDonVi) {
      if (donViModel.indexWhere((element) => element.id == canBo.id) == -1) {
        listPeople.remove(canBo);
      }
    }
    addPeopleThamGia(donViModel);
  }

  void addCanBoThamGia(
    List<DonViModel> donViModel,
  ) {
    listCanBoThamGia.sink.add(donViModel);
  }

  void xoaCanBoDuocChon(DonViModel data) {
    for (final DonViModel canBo in listCanBoDuocChon) {
      if (canBo.id == data.id) {
        canBo.isXoa = true;
      }
    }
  }

  void addCanBoThamGiaCuCanBo(
    ThemCanBoCubit themCanBoCubit,
    ThemDonViCubit themDonViCubit,
  ) {
    if (isDuplicateItem(listCanBoThamGia.valueOrNull ?? [], newCanBo)) {
      isDuplicateCanBo.add(true);
    } else {
      isDuplicateCanBo.add(false);
      if ((themCanBoCubit.titleCanBo.valueOrNull ?? '').isEmpty) {
        final DonViModel donVi = themDonViCubit.listDonVi.last;
        (listCanBoThamGia.valueOrNull ?? []).add(donVi);
        listCanBo.add(donVi);
      } else {
        (listCanBoThamGia.valueOrNull ?? []).add(newCanBo);
        listCanBo.add(newCanBo);
      }
      listCanBoThamGia.sink.add(listCanBoThamGia.valueOrNull ?? []);
    }
  }

  bool isDuplicateItem(List<DonViModel> listRoot, DonViModel newCanBo) {
    for (final DonViModel canBo in listRoot) {
      if (canBo.id == newCanBo.id) {
        return true;
      }
    }
    return false;
  }

  void xoaCanBoThamGia(
    DonViModel donViModel,
  ) {
    listCanBo.remove(donViModel);
    listCanBoThamGia.sink.add(listCanBo);
  }

  void xoaCanBoThamGiaCuCanBo(
    DonViModel donViModel,
    List<DonViModel> listCanBoDaCu,
  ) {
    for (final DonViModel canBo in listCanBoDaCu) {
      if (canBo.id == donViModel.id) {
        canBo.isXoa = true;
      }
    }
    listCanBo.remove(donViModel);
    (listCanBoThamGia.valueOrNull ?? []).remove(donViModel);
    listCanBoThamGia.sink.add(listCanBoThamGia.valueOrNull ?? []);
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
          final data = <Node<DonViModel>>[];
          _getTreeDonVi.sink.add(res);
          for (final Node<DonViModel> element in res) {
            data.add(element.coppyWith());
          }
          _getTreeCaNhan.sink.add(data);
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
    _getTreeCaNhan.close();
    listCanBoThamGia.close();
  }
}
