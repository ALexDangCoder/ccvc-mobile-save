import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/fake_date_tao_lich_hop.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ThemCanBoCubit extends BaseCubit<ThemCanBoState> {
  final List<DonViModel> listSelectCanBo = [];
  List<DonViModel> listCanBo = [];
  ThanhPhanThamGiaReponsitory get thanhPhanThamGiaRp => Get.find();
  final BehaviorSubject<List<DonViModel>> _getCanbo =
      BehaviorSubject<List<DonViModel>>();

  Stream<List<DonViModel>> get getCanbo => _getCanbo.stream;

  ThemCanBoCubit() : super(MainStateInitial());
  Future<void> getCanBo(DonViModel donViModel) async {
    emit(Loading());
    final result = await thanhPhanThamGiaRp.getSeachCanBo(
      SearchCanBoRequest(iDDonVi: donViModel.id, pageIndex: 1, pageSize: 100),
    );
    emit(MainStateInitial());
    listSelectCanBo.clear();
    result.when(
      success: (res) {
        listCanBo = res;
        _getCanbo.sink.add(listCanBo);
      },
      error: (err) {},
    );
  }

  void selectCanBo(DonViModel canBoModel, {bool isCheck = false}) {
    if (isCheck) {
      listSelectCanBo.add(canBoModel);
    } else {
      listSelectCanBo.remove(canBoModel);
    }
  }

  void search(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(DonViModel canBo) {
      return canBo.name.toLowerCase().vietNameseParse().contains(searchTxt) ||
          canBo.chucVu.toLowerCase().vietNameseParse().contains(searchTxt) ||
          canBo.tenCanBo.toLowerCase().vietNameseParse().contains(searchTxt);
    }

    final vl = listCanBo.where((element) => isListCanBo(element)).toList();
    _getCanbo.sink.add(vl);
  }

  void dispose() {
    _getCanbo.close();
  }
}
