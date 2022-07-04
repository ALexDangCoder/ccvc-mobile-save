import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class HoTroKyThuatCubit extends BaseCubit<BaseState> {
  HoTroKyThuatCubit() : super(HotroKyThuatStateInitial());

  static const DANG_CHO_XU_LY = 'Đang chờ sử lý';
  static const DANG_XU_LY = 'Đang xử lý';
  static const DA_XU_LY = 'Đã xử lý';
  static const TU_CHOI_XU_LY = 'Từ chối xử lý';

  ///variable menu
  BehaviorSubject<TypeHoTroKyThuat> typeHoTroKyThuatSubject =
      BehaviorSubject.seeded(TypeHoTroKyThuat.THONG_TIN_CHUNG);

  Stream<TypeHoTroKyThuat> get typeHoTroKyThuatStream =>
      typeHoTroKyThuatSubject.stream;
  List<bool> listCheckPopupMenu = [];
  BehaviorSubject<List<TongDaiModel>> listTongDai = BehaviorSubject.seeded([]);

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  void initListCheckPopup(int length) {
    listCheckPopupMenu = List<bool>.filled(
      length,
      false,
      growable: true,
    );
  }

  int getColor(String color) {
    if (color.isNotEmpty) {
      final String value = color.replaceAll('#', '0xff');
      return int.parse(value);
    }
    return int.parse('0xfffffff');
  }

  void onClickPopupMenu(DanhSachSuCoModel value, int index) {
    listCheckPopupMenu = List<bool>.filled(
      loadMoreList.length,
      false,
      growable: true,
    );
    listCheckPopupMenu[index] = true;
  }

  void onClosePopupMenu() {
    listCheckPopupMenu = List<bool>.filled(
      loadMoreList.length,
      false,
      growable: true,
    );
  }

  Future<void> getListDanhBaCaNhan({
    required int page,
  }) async {
    final result = await _hoTroKyThuatRepository.postDanhSachSuCo(
      page,
      ApiConstants.DEFAULT_PAGE_SIZE,
    );
    result.when(
      success: (res) {
        if (res.isEmpty) {
          showContent();
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getTongDai() async {
    final result = await _hoTroKyThuatRepository.getTongDai();
    result.when(
      success: (res) {
        listTongDai.add(res);
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }
}
