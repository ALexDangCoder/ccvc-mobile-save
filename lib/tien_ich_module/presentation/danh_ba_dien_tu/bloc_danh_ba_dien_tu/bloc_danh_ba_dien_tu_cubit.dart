import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/pick_image_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/sua_danh_sach_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/them_danh_ba_ca_nhan_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/danh_ba_dien_tu_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_state.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/widget/tree.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DanhBaDienTuCubit extends BaseCubit<BaseState> {
  DanhBaDienTuCubit() : super(DanhBaDienTuStateInitial());

  /// tree danh ba by tung
  TienIchRepository get tienIchRepTree => Get.find();
  BehaviorSubject<TreeDanhBaDienTu> listTreeDanhBaSubject =
      BehaviorSubject<TreeDanhBaDienTu>();
  TreeDanhBaDienTu dataTypeTree = TreeDanhBaDienTu();
  List<TreeDonViDanhBA> listTreeDanhBa = [];
  Debouncer debouncer = Debouncer();
  final List<String> _listId = [];
  final List<String> _listParent = [];
  int levelTree = 0;
  BehaviorSubject<String> tenDonVi =
      BehaviorSubject.seeded(S.current.chon_don_vi);
  BehaviorSubject<String> idDonVi = BehaviorSubject();
  BehaviorSubject<String> isCheckValidate = BehaviorSubject.seeded('  ');
  String searchValue = '';
  Timer? _debounce;

  ////////////////////////////////////////////////////////////////////////
  DanhBaDienTuRepository get tienIchRep => Get.find();
  String times = DateTime.now().toString();
  int page = 1;
  int totalPage = 1;
  int pageSize = 10;
  int pageIndex = 1;
  String createdAt = DateTime.now().formatApiDanhBa;
  String updatedAt = DateTime.now().formatApiDanhBa;
  String hoTen = '';
  String phoneDiDong = '';
  String phoneCoQuan = '';
  String phoneNhaRieng = '';
  String email = '';
  bool gioiTinh = true;
  String dateDanhSach = '';
  String cmtnd = '';
  String anhChuKyFilePath = '';
  String anhChuKyNhayFilePath = '';
  String diaChi = '';
  bool isDeleted = false;
  int? thuTu = 0;
  List<String>? groupIds = [];
  String id = '';

  String search = '';
  BehaviorSubject<File> saveFile = BehaviorSubject();
  final BehaviorSubject<ModelAnh?> anhDanhBaCaNhan = BehaviorSubject();
  final BehaviorSubject<ModelAnh?> suaAnhDanhBaCaNhan = BehaviorSubject();

  String subString(String? name) {
    if (name != null) {
      return name.substring(0, 1);
    }
    return '';
  }

  String subStringFix(String name) {
    if (name.trim().isNotEmpty) {
      return name.substring(0, 1);
    }
    return '';
  }

  void callApiDanhSach() {
    getListDanhBaCaNhan(pageIndex: pageIndex, pageSize: pageSize);
  }

  void callApiDanhBaToChuc({
    int? pageIndexApi,
    int? pageSizeApi,
    String? keyWork,
    String? id,
    bool? callApi,
  }) {
    if (callApi ?? true) {
      getListDanhBaToChuc(
        pageIndex: pageIndexApi ?? pageIndex,
        pageSize: pageSizeApi ?? pageSize,
        filterBy: keyWork?.trim() ?? '',
        idDonVi: id ?? this.id,
      );
    }
  }

  Future<void> searchListDanhSach(String keyword) async {
    await searchListDanhBaCaNhan(
      pageIndex: pageIndex,
      pageSize: pageSize,
      keyword: keyword,
    );
  }



  Future<void> searchListDanhBaCaNhan({
    required int pageIndex,
    required int pageSize,
    required String keyword,
  }) async {
    loadMorePage = pageIndex;
    final result = await tienIchRep.searchListDanhBaCaNhan(
      pageIndex,
      pageSize,
      keyword.trim(),
    );
    result.when(
      success: (res) {
        if (pageIndex == ApiConstants.PAGE_BEGIN) {
          if (res.items?.isEmpty ?? true) {
            showEmpty();
          } else {
            listItemSubject.sink.add(res.items ?? []);
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
        }
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          emit(const CompletedLoadMore(CompleteType.ERROR));
          showError();
        }
      },
    );
  }

  Future<void> getListDanhBaToChuc({
    required int pageIndex,
    required int pageSize,
    required String filterBy,
    required String idDonVi,
  }) async {
    loadMorePage = pageIndex;
    final result = await tienIchRep.getListDanhBaToChuc(
      pageIndex,
      pageSize,
      filterBy,
      idDonVi,
    );
    result.when(
      success: (res) {
        if (pageIndex == ApiConstants.PAGE_BEGIN) {
          if (res.items?.isEmpty ?? true) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
          }
        } else {
          if (res.items?.isEmpty ?? true) {
            showContent();
            emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
          }
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  List<Items> listItem = [];
  Items items = Items();
  BehaviorSubject<List<Items>> listItemSubject = BehaviorSubject();

  Future<void> getListDanhBaCaNhan({
    required int pageIndex,
    required int pageSize,
  }) async {
    loadMorePage = pageIndex;
    final result = await tienIchRep.getListDanhBaCaNhan(pageIndex, pageSize);
    result.when(
      success: (res) {
        listItem = res.items ?? [];
        if (pageIndex == ApiConstants.PAGE_BEGIN) {
          if (res.items?.isEmpty ?? true) {
            showEmpty();
          } else {
            listItemSubject.sink.add(res.items ?? []);
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.items));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  String pathAnh = '';

  Future<void> uploadFiles(String path) async {
    showLoading();
    final result = await tienIchRepTree.uploadFile(File(path));
    result.when(
      success: (res) {
        pathAnh = res.data?.filePathFull ?? '';
      },
      error: (error) {},
    );
    showContent();
  }

  Future<bool> postDanhSach({
    required String hoTen,
    required String phoneDiDong,
    required String phoneCoQuan,
    required String phoneNhaRieng,
    required String email,
    required bool gioiTinh,
    required String ngaySinh,
    required String cmtnd,
    required String anhDaiDienFilePath,
    required String anhChuKyFilePath,
    required String anhChuKyNhayFilePath,
    required String diaChi,
    required bool isDeleted,
    required int thuTu,
    required List<String> groupIds,
  }) async {
    bool isCheck = true;
    final ThemDanhBaCaNhanRequest themDanhBaCaNhanRequest =
        ThemDanhBaCaNhanRequest(
      hoTen: hoTen.trim(),
      phone_DiDong: phoneDiDong.trim(),
      phone_CoQuan: phoneCoQuan.trim(),
      phone_NhaRieng: phoneNhaRieng.trim(),
      email: email.trim(),
      gioiTinh: gioiTinh,
      ngaySinh: ngaySinh,
      cmtnd: cmtnd.trim(),
      anhDaiDien_FilePath: anhDaiDienFilePath,
      anhChuKy_FilePath: anhChuKyFilePath,
      anhChuKyNhay_FilePath: anhChuKyNhayFilePath,
      diaChi: diaChi.trim(),
      isDeleted: isDeleted,
      thuTu: thuTu,
      groupIds: groupIds,
    );
    showLoading();
    final result = await tienIchRep.postThemMoiDanhBa(themDanhBaCaNhanRequest);
    result.when(
      success: (res) {
        callApiDanhSach();
        MessageConfig.show(
          title: S.current.them_danh_ba_ca_nhan_thanh_cong,
        );
        isCheck = true;
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.them_danh_ba_ca_nhan_khong_thanh_cong,
            messState: MessState.error,
          );
          isCheck = false;
        }
      },
    );
    showContent();
    return isCheck;
  }

  Future<bool> suaDanhSach({
    required String groups,
    required String hoTen,
    required String phoneDiDong,
    required String phoneCoQuan,
    required String phoneNhaRieng,
    required String email,
    required bool gioiTinh,
    required String ngaySinh,
    required String cmtnd,
    required String anhDaiDienFilePath,
    required String anhChuKyFilePath,
    required String anhChuKyNhayFilePath,
    required String diaChi,
    required bool isDeleted,
    required int thuTu,
    required String createdAt,
    required String createdBy,
    required String updatedAt,
    required String updatedBy,
    required String id,
  }) async {
    bool isCheckSuccess = true;
    showLoading();
    final SuaDanhBaCaNhanRequest suaDanhBaCaNhanRequest =
        SuaDanhBaCaNhanRequest(
      groups: groups,
      hoTen: hoTen,
      phone_DiDong: phoneDiDong,
      phone_CoQuan: phoneCoQuan,
      phone_NhaRieng: phoneNhaRieng,
      email: email,
      gioiTinh: gioiTinh,
      ngaySinh: ngaySinh,
      cmtnd: cmtnd,
      anhDaiDien_FilePath: anhDaiDienFilePath,
      anhChuKy_FilePath: anhChuKyFilePath,
      anhChuKyNhay_FilePath: anhChuKyNhayFilePath,
      diaChi: diaChi,
      isDeleted: isDeleted,
      thuTu: thuTu,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      id: id,
    );
    final result = await tienIchRep.putSuaDanhBa(suaDanhBaCaNhanRequest);
    result.when(
      success: (res) {
        callApiDanhSach();
        MessageConfig.show(
          title: S.current.thay_doi_thanh_cong,
        );
        isCheckSuccess = true;
      },
      error: (error) {
        if (error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.thay_doi_that_bai,
            messState: MessState.error,
          );
          isCheckSuccess = false;
        }
      },
    );
    // if (isCheckSuccess) {
    //   anhDanhBaCaNhan.sink.add(null);
    // }
    //
    showContent();
    return isCheckSuccess;
  }

  Future<bool> xoaDanhBa({
    required String id,
  }) async {
    bool isCheckSuccess = true;
    showLoading();
    final result = await tienIchRep.xoaDanhBa(id);
    result.when(
      success: (res) {
        callApiDanhSach();
        MessageConfig.show(
          title: S.current.xoa_thanh_cong,
        );
        isCheckSuccess = true;
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.xoa_that_bai,
          messState: MessState.error,
        );
        isCheckSuccess = false;
      },
    );
    showContent();
    return isCheckSuccess;
  }

  void searchAllDanhSach(String values) {
    final searchTxt = values.trim().toLowerCase().vietNameseParse();
    bool isListDanhSach(Items name) {
      return (name.hoTen ?? '')
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value = listItem.where((event) => isListDanhSach(event)).toList();
    listItemSubject.add(value);
  }
}

extension TreeDanhBa on DanhBaDienTuCubit {
  Future<void> getTree({int? soCap, String? idDonViCha}) async {
    final result =
        await tienIchRepTree.treeDanhBa(soCap ?? 0, idDonViCha ?? '');
    result.when(
      success: (res) {
        showContent();
        final ans = TreeDanhBaDienTu();
        listTreeDanhBa = res.toSet().toList();

        for (final e in listTreeDanhBa) {
          _listId.add(e.id);
          _listParent.add(e.iDDonViCha);
        }
        ans.initTree(listNode: listTreeDanhBa);
        dataTypeTree = ans;
        listTreeDanhBaSubject.add(ans);
      },
      error: (error) {
        showError();
      },
    );
  }

  NodeHSCV? getRoot() {
    if (listTreeDanhBaSubject.hasValue) {
      return listTreeDanhBaSubject.value.getRoot();
    }
  }

  void getValueTree({required NodeHSCV nodeHSCV}) {
    tenDonVi.sink.add(nodeHSCV.value.tenDonVi);
    idDonVi.sink.add(nodeHSCV.value.id);
  }

  void searchTree(String keyword) {
    final ans = TreeDanhBaDienTu();
    if (keyword.isEmpty) {
      ans.initTree(listNode: listTreeDanhBa);
      listTreeDanhBaSubject.add(ans);
      return;
    }
    final List<TreeDonViDanhBA> result = [];

    final List<TreeDonViDanhBA> matches = listTreeDanhBa
        .where(
          (data) => data.tenDonVi
              .toLowerCase()
              .vietNameseParse()
              .trim()
              .contains(keyword.toLowerCase().vietNameseParse().trim()),
        )
        .toList();

    void getParent(List<TreeDonViDanhBA> treeAlls, TreeDonViDanhBA node) {
      final parent =
          treeAlls.where((element) => element.id == node.iDDonViCha).first;
      if (!result.contains(parent)) {
        result.add(parent);
      }
      if (parent.iDDonViCha.isNotEmpty) {
        getParent(treeAlls, parent);
      }
    }

    for (final element in matches) {
      result.add(element);
      getParent(listTreeDanhBa, element);
    }

    ans.initTree(listNode: result.toSet().toList());
    listTreeDanhBaSubject.add(ans);
  }

  TreeDonViDanhBA init() {
    showLoading();
    idDonVi.sink.add(listTreeDanhBa[0].id);
    tenDonVi.sink.add(listTreeDanhBa[0].tenDonVi);
    return listTreeDanhBa[0];
  }

  /// funtion delay
  Future<void> waitToDelay({
    required Function actionNeedDelay,
    int? timeSecond,
  }) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
        Duration(
          milliseconds: (timeSecond ?? 1) * 1000,
        ), () {
      actionNeedDelay();
    });
  }
}
