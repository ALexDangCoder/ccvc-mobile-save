import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/don_vi_con_phong_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'chon_phong_hoc_state.dart';

class ChonPhongHopCubit extends BaseCubit<ConPhongHopState> {
  LoaiPhongHopEnum loaiPhongHopEnum = LoaiPhongHopEnum.PHONG_HOP_THUONG;
  final List<ThietBiValue> listThietBi = [];
  final BehaviorSubject<List<ThietBiValue>> _listThietBi =
      BehaviorSubject<List<ThietBiValue>>();

  ChonPhongHopCubit() : super(ConPhongHopStateInitial()) {
    showContent();
  }

  Stream<List<ThietBiValue>> get listThietBiStream => _listThietBi.stream;

  final BehaviorSubject<List<DonViConPhong>> donViSubject = BehaviorSubject();

  final BehaviorSubject<bool> isShowPhongHopSubject =
      BehaviorSubject.seeded(false);

  final BehaviorSubject<List<PhongHopModel>> phongHopSubject =
      BehaviorSubject();

  final BehaviorSubject<ChonPhongHopModel> thongTinPhongHopSubject =
      BehaviorSubject();

  HopRepository get hopRepository => Get.find();

  PhongHop phongHop = PhongHop();
  String donViSelected = '';
  String donViSelectedId = '';

  Future<void> getDonViConPhong(String id) async {
    showLoading();
    final rs = await hopRepository.getDonViConPhongHop(id);
    rs.when(
      success: (res) {
        donViSubject.add(res);
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> getPhongHop({
    required String id,
    required String from,
    required String to,
    required bool isTTDH,
  }) async {
    final rs = await hopRepository.getDanhSachPhongHop(id, from, to, isTTDH);
    rs.when(
      success: (res) {
        phongHopSubject.add(res);
      },
      error: (error) {},
    );
  }

  void addThietBi(ThietBiValue value) {
    listThietBi.add(value);
    _listThietBi.sink.add(listThietBi);
  }

  void initListThietBi(List<PhongHopThietBi> value) {
    final listParsed = value.map(
      (e) => ThietBiValue(
        soLuong: e.soLuong?.stringToInt() ?? 0,
        tenThietBi: e.tenThietBi ?? '',
      ),
    );
    listThietBi.clear();
    listThietBi.addAll(listParsed);
    _listThietBi.sink.add(listThietBi);
  }

  void removeThietBi(ThietBiValue value) {
    listThietBi.remove(value);
    _listThietBi.sink.add(listThietBi);
  }

  void setLoaiPhongHop(LoaiPhongHopEnum loaiPhongHopEnum) {
    this.loaiPhongHopEnum = loaiPhongHopEnum;
  }

  void clearDataChonPhongHop() {
    _listThietBi.sink.add([]);
    loaiPhongHopEnum = LoaiPhongHopEnum.PHONG_HOP_THUONG;
    phongHopSubject.sink.add([]);
    isShowPhongHopSubject.sink.add(false);
    phongHop.noiDungYeuCau = '';
    donViSelected = '';
    donViSelectedId = '';
  }
}
