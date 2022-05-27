import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/bloc/danh_sach_yknd_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class DanhSachYKienNguoiDanCubit extends BaseCubit<BaseState> {
  DanhSachYKienNguoiDanCubit() : super(DanhSachYKienNguoiDanStateInitial());

  final BehaviorSubject<List<YKienNguoiDanModel>> _listYKienNguoiDan =
      BehaviorSubject<List<YKienNguoiDanModel>>();

  final BehaviorSubject<bool> _selectSreach = BehaviorSubject.seeded(false);

  Stream<List<YKienNguoiDanModel>> get listYKienNguoiDan =>
      _listYKienNguoiDan.stream;

  Stream<bool> get selectSreach => _selectSreach.stream;
  String donViId = '';
  String userId = '';
  String search = '';

  void setSelectSearch() {
    _selectSreach.sink.add(!_selectSreach.value);
  }

  void callApi(String startDate, String endDate, {String? trangThai}) {
    getUserData();
    getDanhSachYKienNguoiDan(
      startDate,
      endDate,
      trangThai ?? '',
      10,
      1,
    );
  }

  final YKienNguoiDanRepository _YKNDRepo = Get.find();

  Future<void> getDanhSachYKienNguoiDan(
    String tuNgay,
    String denNgay,
    String trangThai,
    int pageSize,
    int pageNumber,
  ) async {
    showLoading();
    final result = await _YKNDRepo.danhSachYKienNguoiDan(
      tuNgay,
      denNgay,
      trangThai,
      pageSize,
      pageNumber,
      userId,
      donViId,
    );
    showContent();
    result.when(
      success: (res) {
        _listYKienNguoiDan.sink.add(res.listYKienNguoiDan);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> searchDanhSachYKienNguoiDan({
    required String tuNgay,
    required String denNgay,
    String trangThai = '',
    required int pageSize,
    required int pageNumber,
  }) async {
    loadMorePage = pageNumber;
    final result = await _YKNDRepo.searchYKienNguoiDan(
      tuNgay,
      denNgay,
      trangThai,
      pageSize,
      pageNumber,
      search,
      userId,
      donViId,
    );
    showContent();
    result.when(
      success: (res) {
        if (pageNumber == ApiConstants.PAGE_BEGIN) {
          if (res.isEmpty) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
        }
      },
      error: (err) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  void getUserData() {
    final DataUser? dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser.userId ?? '';
    }
  }
}
