import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/fake_date_tao_lich_hop.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:rxdart/rxdart.dart';

class ThemCanBoCubit extends BaseCubit<ThemCanBoState> {
  final List<DonViModel> listSelectCanBo = [];
  List<DonViModel> listCanBo = [];
  final BehaviorSubject<List<DonViModel>> _getCanbo =
      BehaviorSubject<List<DonViModel>>();

  Stream<List<DonViModel>> get getCanbo => _getCanbo.stream;

  ThemCanBoCubit() : super(MainStateInitial());
  Future<void> getCanBo(DonViModel donViModel) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 1));
    listSelectCanBo.clear();
    listCanBo = FakeDataTaoLich.canBo;
    _getCanbo.sink.add(listCanBo);
    emit(MainStateInitial());
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
