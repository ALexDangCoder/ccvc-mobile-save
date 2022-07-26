import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ThemCanBoCubit extends BaseCubit<ThemCanBoState> {
  List<DonViModel> listSelectCanBo = [];
  final List<CanBoModel> listCaNhanRemove = [];
  DonViModel donViModel = DonViModel();
  List<DonViModel> listCanBo = [];
  BehaviorSubject<String> titleCanBo = BehaviorSubject();

  ThanhPhanThamGiaReponsitory get thanhPhanThamGiaRp => Get.find();
  final BehaviorSubject<List<DonViModel>> getCanbo =
      BehaviorSubject<List<DonViModel>>();

  Stream<List<DonViModel>> get getCanboStream => getCanbo.stream;

  ThemCanBoCubit() : super(MainStateInitial());

  Future<void> getCanBo(DonViModel donViModel) async {
    emit(Loading());
    final result = await thanhPhanThamGiaRp.getSeachCanBo(
      SearchCanBoRequest(iDDonVi: donViModel.id, pageIndex: 1, pageSize: 100),
    );
    emit(MainStateInitial());
    // listSelectCanBo.clear();
    result.when(
      success: (res) {
        listCanBo = res;
        listCanBo.removeWhere(
          (element) {
            final a = listCaNhanRemove
                .where(
                  (e) =>
              (e.canBoId ?? '').toLowerCase() ==
                  element.userId.toLowerCase(),
            )
                .isNotEmpty;
            return a;
          },
        );
        getCanbo.sink.add(listCanBo);
      },
      error: (err) {},
    );
  }

  void addDataList(int index) {
    for (final value in listCanBo) {
      value.isCheck = false;
      titleCanBo.sink.add('');
    }
    listCanBo[index].isCheck = true;
    titleCanBo.sink.add(listCanBo[index].tenCanBo);
    getCanbo.sink.add(listCanBo);
  }

  HopRepository get hopRepo => Get.find();

  Future<bool> checkLichTrung({
    required String donViId,
    required String canBoId,
    required String timeStart,
    required String timeEnd,
    required String dateStart,
    required String dateEnd,
  }) async {
    bool isDuplicate = false;
    emit(Loading());
    final rs = await hopRepo.checkLichHopTrung(
      null,
      donViId,
      canBoId,
      timeStart,
      timeEnd,
      dateStart,
      dateEnd,
    );
    emit(MainStateInitial());
    rs.when(
      success: (res) {
        isDuplicate = res.isNotEmpty;
      },
      error: (error) {
        isDuplicate = false;
      },
    );
    showContent();
    return isDuplicate;
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
    getCanbo.sink.add(vl);
  }

  void dispose() {
    getCanbo.close();
  }
}
