import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_state.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

enum TypeScreen { TIN_RADIO, TIN_TRONG_NUOC, TIN_QUOC_TE }

class TinTucThoiSuBloc extends BaseCubit<BaseState> {
  TinTucThoiSuBloc() : super(TinTucThoiSuStateInitial());
  BehaviorSubject<int> dropDownSubject = BehaviorSubject.seeded(1);
  final BehaviorSubject<TinTucRadioResponseModel> _listTinTucRadio =
      BehaviorSubject<TinTucRadioResponseModel>();
  final BehaviorSubject<TinTucRadioResponseModel> _listTinTucRadioTrongNuoc =
      BehaviorSubject<TinTucRadioResponseModel>();
  final BehaviorSubject<TinTucRadioResponseModel> _listTinTucRadioQuocTe =
      BehaviorSubject<TinTucRadioResponseModel>();

  List<TinTucRadioModel> listTinTuc = [];
  List<TinTucRadioModel> listTinTucTrongNuoc = [];
  List<TinTucRadioModel> listTinTucQuocTe = [];

  Stream<TinTucRadioResponseModel> get listTinTucRadio =>
      _listTinTucRadio.stream;

  Stream<TinTucRadioResponseModel> get listTinTucRadioTrongNuoc =>
      _listTinTucRadioTrongNuoc.stream;

  Stream<TinTucRadioResponseModel> get listTinTucRadioQuocTe =>
      _listTinTucRadioQuocTe.stream;

  Stream<int> get dropDownStream => dropDownSubject.stream;

  void changeItem(dropDown? nameDrop) {
    switch (nameDrop) {
      case dropDown.tinRadio:
        {
          dropDownSubject.add(1);
          break;
        }

      case dropDown.tinTrongNuoc:
        {
          dropDownSubject.add(2);
          break;
        }
      case dropDown.tinQuocTe:
        {
          dropDownSubject.add(3);
          break;
        }

      default:
        {
          dropDownSubject.add(1);
        }
    }
  }

  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();

  Future<void> getListTinTucRadio(int page, int size) async {
    loadMorePage = page;
    final result = await _BCMXHRepo.getTinTucThoiSu(
      page,
      size,
      DateTime.now().add(const Duration(days: -30)).formatApiStartDay,
      DateTime.now().formatApiEndDay,
      -1,
    );
    result.when(
      success: (res) {
        listTinTuc.addAll(res.listTinTucThoiSu);
        _listTinTucRadio.sink.add(res);
        if (page == ApiConstants.PAGE_BEGIN) {
          if (res.listTinTucThoiSu.isEmpty) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS,
                posts: res.listTinTucThoiSu));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS,
              posts: res.listTinTucThoiSu));
        }
      },
      error: (err) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
    //showContent();
  }

  Future<void> getListTinTucRadioTrongNuoc(int page, int size) async {
    loadMorePage = page;
    final result = await _BCMXHRepo.getTinTucThoiSu(
      page,
      size,
      DateTime.now().add(const Duration(days: -30)).formatApiStartDay,
      DateTime.now().formatApiEndDay,
      918,
    );
    result.when(
      success: (res) {
        // listTinTuc.addAll(res.listTinTucThoiSu);
        // _listTinTucRadio.sink.add(res);
        listTinTucTrongNuoc.addAll(res.listTinTucThoiSu);
        _listTinTucRadioTrongNuoc.sink.add(res);
        if (page == ApiConstants.PAGE_BEGIN) {
          if (res.listTinTucThoiSu.isEmpty) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS,
                posts: res.listTinTucThoiSu));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS,
              posts: res.listTinTucThoiSu));
        }
      },
      error: (err) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
    //showContent();
  }

  Future<void> getListTinTucRadioQuocTe(int page, int size) async {
    loadMorePage = page;
    final result = await _BCMXHRepo.getTinTucThoiSu(
      page,
      size,
      DateTime.now().add(const Duration(days: -30)).formatApiStartDay,
      DateTime.now().formatApiEndDay,
      919,
    );
    result.when(
      success: (res) {
        // listTinTuc.addAll(res.listTinTucThoiSu);
        // _listTinTucRadio.sink.add(res);
        listTinTucQuocTe.addAll(res.listTinTucThoiSu);
        _listTinTucRadioQuocTe.sink.add(res);
        if (page == ApiConstants.PAGE_BEGIN) {
          if (res.listTinTucThoiSu.isEmpty) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS,
                posts: res.listTinTucThoiSu));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS,
              posts: res.listTinTucThoiSu));
        }
      },
      error: (err) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
    //showContent();
  }
}
