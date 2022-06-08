import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class TheoDoiBaiVietCubit extends BaseCubit<BaseState> {
  TheoDoiBaiVietCubit() : super(TheoDoiStateInitial());

  final BehaviorSubject<TheoDoiBaiVietModel> _listBaiVietTheoDoi =
      BehaviorSubject<TheoDoiBaiVietModel>();

  Stream<TheoDoiBaiVietModel> get listBaiVietTheoDoi =>
      _listBaiVietTheoDoi.stream;
  int totalPage = 1;

  final String startDate = DateTime.now().formatApiSS;
  final String endDate = DateTime(
    DateTime.now().year,
    DateTime.now().month - 3,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
  ).formatApiSS;

  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();
  List<BaiVietModel> list = [];

  Future<void> getListBaiVietTheoDoi(
      String startDate, String enDate, int topic, int page, int size) async {
    loadMorePage = page;
    // showLoading();
    final result = await _BCMXHRepo.getBaiVietTheoDoi(
      page,
      size,
      startDate,
      enDate,
      topic,
    );
    result.when(
      success: (res) {
        // totalPage=res.totalPages;
        // _listBaiVietTheoDoi.sink.add(res);
        list = res.listBaiViet;
        if (page == ApiConstants.PAGE_BEGIN) {
          if (list.isEmpty) {
            showEmpty();
          } else {
            showContent();
            emit(
              CompletedLoadMore(
                CompleteType.SUCCESS,
                posts: res.listBaiViet,
              ),
            );
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: list));
        }
      },
      error: (err) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
    // showContent();
  }

  Future<void> followTopic(String url) async {
    final result = await _BCMXHRepo.followTopic(url);
    showLoading();
    result.when(
      success: (res) {
        showContent();
        if (res != null) {
          list.insert(0, res);
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: list));
        }
      },
      error: (error) {
        showContent();
        Fluttertoast.showToast(
          msg: error.message,
        );
      },
    );
  }
}
