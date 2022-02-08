import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:rxdart/rxdart.dart';

class ThanhPhanThamGiaCubit {
  final List<DonViModel> listPeople = [];
  final List<Node<DonViModel>> listNode = [];
  bool phuongThucNhan = false;
  final BehaviorSubject<List<DonViModel>> _listPeopleThamGia =
      BehaviorSubject<List<DonViModel>>();

  Stream<List<DonViModel>> get listPeopleThamGia => _listPeopleThamGia.stream;
  final BehaviorSubject<bool> _phuongThucNhan = BehaviorSubject.seeded(false);
  Stream<bool> get phuongThucNhanStream => _phuongThucNhan.stream;
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
  }
}
