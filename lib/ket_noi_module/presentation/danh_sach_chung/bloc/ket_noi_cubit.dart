import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/ket_noi_item_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/repository/ket_noi_repository.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/bloc/ket_noi_state.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class KetNoiCubit extends BaseCubit<BaseState> {
  KetNoiCubit() : super(KetNoiStateInitial());

  KetNoiRepository get repo => Get.find();
  String textDay = '';
  int pageSize = 10;
  int pageIndex = 1;
  String type = 'KET-NOI';
  DanhSachChungModel danhSachChungModel = DanhSachChungModel();
  DataDanhSachChungModel dataDanhSachChungModel = DataDanhSachChungModel();
  BehaviorSubject<TypeKetNoiMenu> changeItemMenuSubject =
      BehaviorSubject.seeded(TypeKetNoiMenu.Chung);

  Stream<TypeKetNoiMenu> get streamTypeKetNoiMenu =>
      changeItemMenuSubject.stream;

  BehaviorSubject<DataDanhSachChungModel> dataDanhSachSubject =
      BehaviorSubject();

  Stream<DataDanhSachChungModel> get streamData => dataDanhSachSubject.stream;

  void changeScreenMenu(TypeKetNoiMenu typeMenu) {
    changeItemMenuSubject.add(typeMenu);
  }

  Future<void> getListChungKetNoi({
    required int pageIndex,
    required int pageSize,
    required String type,
  }) async {
    loadMorePage = pageIndex;
    final result = await repo.ketNoiListChung(pageIndex, pageSize, type);
    result.when(
      success: (res) {
        if (pageIndex == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }
}
