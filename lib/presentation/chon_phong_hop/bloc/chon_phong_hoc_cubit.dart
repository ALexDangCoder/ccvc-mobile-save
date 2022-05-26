import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:rxdart/rxdart.dart';

class ChonPhongHopCubit {
  LoaiPhongHopEnum loaiPhongHopEnum = LoaiPhongHopEnum.PHONG_HOP_THUONG;
  final List<ThietBiValue> listThietBi = [];
  final BehaviorSubject<List<ThietBiValue>> _listThietBi =
      BehaviorSubject<List<ThietBiValue>>();

  Stream<List<ThietBiValue>> get listThietBiStream => _listThietBi.stream;

  void addThietBi(ThietBiValue value) {
    listThietBi.add(value);
    _listThietBi.sink.add(listThietBi);
  }

  void removeThietBi(ThietBiValue value) {
    listThietBi.remove(value);
    _listThietBi.sink.add(listThietBi);
  }

  void setLoaiPhongHop(LoaiPhongHopEnum loaiPhongHopEnum) {
    this.loaiPhongHopEnum = loaiPhongHopEnum;
  }

  void dispose() {
    _listThietBi.close();
  }
}
