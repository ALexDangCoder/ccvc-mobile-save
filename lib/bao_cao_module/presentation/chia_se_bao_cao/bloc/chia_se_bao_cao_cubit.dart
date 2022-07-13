import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:get/get.dart' as get_dart;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

part 'chia_se_bao_cao_state.dart';

enum Share {
  COMMON,
  HAS_USER,
  NEW_USER,
}

class ChiaSeBaoCaoCubit extends ThemDonViCubit {
  ChiaSeBaoCaoCubit() : super() {
    showContent();
  }

  String appId = '';

  static const int COMMON = 0;
  static const int HAS_USER = 1;
  static const int NEW_USER = 2;
  static const String success = 'Thành công';

  String idReport = '';
  int sourceType = 0;

  ReportRepository get _repo => get_dart.Get.find();
  BehaviorSubject<List<NhomCungHeThong>> themNhomStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<bool> showTree = BehaviorSubject.seeded(false);
  BehaviorSubject<String> callAPI = BehaviorSubject.seeded('');
  final BehaviorSubject<bool> _isDuocTruyCapSubject =
      BehaviorSubject.seeded(true);

  Stream<bool> get selectDonViStream => _selectDonVi.stream;
  final BehaviorSubject<bool> _selectDonVi = BehaviorSubject<bool>();

  Stream<bool> get isDuocTruyCapStream => _isDuocTruyCapSubject.stream;

  Sink<bool> get isDuocTruyCapSink => _isDuocTruyCapSubject.sink;

  bool get valueDuocTruyCap => _isDuocTruyCapSubject.value;

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  /// List chọn đơn vị vs người
  final List<DonViModel> listSelect = [];

  void loadTreeDonVi() {
    hopRp.getTreeDonVi().then((value) {
      value.when(
        success: (res) {
          getTreeInit(res);

          // _getTreeDonVi.sink.add(res);
        },
        error: (err) {
          showError();
        },
      );
    });
  }

  Future<void> searchCanBoPaging(
    String donViId,
    Node<DonViModel> node,
  ) async {
    showLoading();
    final data = await _repo.getUserPaging(donViId: donViId, appId: appId);
    showContent();
    data.when(
      success: (res) {
        for (final element in res) {
          element.isCheck.isCheck = node.isCheck.isCheck;
          node.addChild(element);
        }
      },
      error: (err) {},
    );
  }

  Future<void> getGroup() async {
    listResponse.clear();
    listDropDown.clear();
    listCheck.clear();
    showLoading();
    final rs = await _repo.getListGroup(appId);
    rs.when(
      success: (res) {
        for (int i = 0; i < res.length; i++) {
          getMemberInGroup(res[i].idNhom ?? '', res[i], res.length);
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  //https://api-htcs-test.chinhquyendientu.vn/api/Source/source-share-detail/154b42c9-651f-4d95-9361-1e6791d38f96

  Future<void> getMemberInGroup(
    String idGroup,
    NhomCungHeThong nhomCungHeThong,
    int length,
  ) async {
    final rs = await _repo.getListThanhVien(idGroup);
    rs.when(
      success: (res) {
        listResponse.add(
          NhomCungHeThong(
            tenNhom: nhomCungHeThong.tenNhom,
            idNhom: nhomCungHeThong.idNhom,
            listThanhVien: res,
          ),
        );
        listDropDown.add(nhomCungHeThong.tenNhom ?? '');
        if (listResponse.length == length) {
          callAPI.add(SUCCESS);
          showContent();
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  void checkUser(Node<DonViModel> node) {
    if (node.isCheck.isCheck) {
      bool checkAllTrue = false;
      for (final element in node.children) {
        if (element.isCheck.isCheck) {
          checkAllTrue = element.isCheck.isCheck;
        } else {
          checkAllTrue = false;
          break;
        }
      }
      if (!checkAllTrue && node.parent?.value.id != '') {
        node.isCheck.isCheck = false;
        addSelectNode(
          node,
          isCheck: false,
        );
        for (final element in node.children) {
          if (element.isCheck.isCheck == true &&
              !selectNode.contains(element)) {
            addSelectNode(
              element,
              isCheck: element.isCheck.isCheck,
            );
          }
        }
      }
    }
  }

  void addSelectDonVi({
    bool isCheck = false,
    List<DonViModel> listDonVi = const [],
    required DonViModel node,
  }) {
    if (isCheck) {
      if (!listSelect.contains(node)) {
        listSelect.add(node);
      }
      for (final element in listDonVi) {
        if (listSelect.contains(element)) {
          break;
        } else {
          listSelect.add(element);
        }
      }
    } else {
      for (final element in listDonVi) {
        listSelect.remove(element);
      }
    }
    _selectDonVi.sink.add(isCheck);
  }

  Future<String> themMoiDoiTuong({
    String? email,
    String? fullName,
    String? birthday,
    String? phone,
    String? position,
    String? unit,
    String? description,
    int? sourceType,
  }) async {
    final Map<String, String> mapData = {
      'email': email ?? '',
      'fullname': fullName ?? '',
      'birthday': birthday ?? '',
      'phone': phone ?? '',
      'position': position ?? '',
      'unit': unit ?? '',
      'description': description ?? '',
    };
    final rs = await chiaSeBaoCao(Share.NEW_USER, newUser: mapData);
    // rs.when(
    //   success: (res) {
    //     message = res;
    //     chiaSeBaoCao(Share.NEW_USER, newUser: mapData);
    //   },
    //   error: (error) {
    //     message = S.current.error;
    //   },
    // );
    return rs;
  }

  Future<String> chiaSeBaoCao(
    Share enumShare, {
    Map<String, String>? newUser,
  }) async {
    String mes = '';
    showLoading();
    final List<ShareReport> mapData = [];
    switch (enumShare) {
      case Share.COMMON:
        for (final element in listCheck) {
          final ShareReport map = ShareReport(
            groupId: element.idNhom,
            type: COMMON,
            sourceType: sourceType,
          );
          mapData.add(map);
        }
        for (final element in listSelect) {
          if (element.tenCanBo != '') {
            final ShareReport map = ShareReport(
              userId: element.id,
              type: COMMON,
              sourceType: sourceType,
            );
            mapData.add(map);
          } else {
            final ShareReport map = ShareReport(
              donViId: element.id,
              type: COMMON,
              sourceType: sourceType,
            );
            mapData.add(map);
          }
        }
        mes = await shareReport(mapData, idReport: idReport);
        break;
      case Share.HAS_USER:
        final list = idUsersNgoaiHeTHongDuocTruyCap.toList();
        for (final element in list) {
          final ShareReport map = ShareReport(
            userId: element,
            type: HAS_USER,
            sourceType: sourceType,
          );
          mapData.add(map);
        }
        mes = await shareReport(mapData, idReport: idReport);
        break;
      case Share.NEW_USER:
        final ShareReport map = ShareReport(
          newUser: newUser,
          type: NEW_USER,
          sourceType: sourceType,
        );
        mapData.add(map);
        mes = await shareReport(mapData, idReport: idReport);
        break;
    }
    return mes;
  }

  Future<String> shareReport(
    List<ShareReport> mapData, {
    required String idReport,
  }) async {
    String message = '';
    final rs = await _repo.shareReport(mapData, idReport, appId);
    rs.when(
      success: (res) {
        message = res;
        showContent();
      },
      error: (error) {
        message = S.current.error;
      },
    );
    return message;
  }

  void themNhom(String tenNhom) {
    if (listCheck.where((element) => element.tenNhom == tenNhom).isEmpty) {
      listCheck.add(
        listResponse.firstWhere((element) => element.tenNhom == tenNhom),
      );
    }
    themNhomStream.add(listCheck);
  }

  void xoaNhom(String tenNhom) {
    listCheck.remove(
      listResponse.firstWhere((element) => element.tenNhom == tenNhom),
    );
    themNhomStream.add(listCheck);
  }

  List<NhomCungHeThong> listResponse = [];
  List<String> listDropDown = [];

  List<NhomCungHeThong> listCheck = [];

  final BehaviorSubject<List<UserNgoaiHeThongDuocTruyCapModel>>
      usersNgoaiHeThongDuocTruyCapBHVSJ =
      BehaviorSubject<List<UserNgoaiHeThongDuocTruyCapModel>>();

  ///huy
  int pageSize = 10;
  int pageNumber = 0;
  bool loadMore = false;
  String keySearch = '';
  bool canLoadMoreList = true;
  bool refresh = false;

  final Set<String> idUsersNgoaiHeTHongDuocTruyCap = {};

  void clearUsersNgoaiHeThongDuocTruyCap() {
    if (usersNgoaiHeThongDuocTruyCapBHVSJ.hasValue) {
      pageSize = 10;
      refresh = false;
      canLoadMoreList = true;
      loadMore = false;
      usersNgoaiHeThongDuocTruyCapBHVSJ.value.clear();
    } else {}
  }

  Future<void> loadMoreUsersNgoaiHeThongTruyCap() async {
    if (loadMore == false) {
      pageNumber += 1;
      canLoadMoreList = false;
      loadMore = true;
      await getUsersNgoaiHeThongDuocTruyCap();
    } else {
      //nothing
    }
  }

  Future<void> getUsersNgoaiHeThongDuocTruyCap({
    bool isSearch = false,
  }) async {
    if (isSearch) {
      clearUsersNgoaiHeThongDuocTruyCap();
    } else {
      //nothing
    }
    showLoading();
    final result = await _repo.getUsersNgoaiHeThongTruyCap(
      appId,
      pageNumber,
      pageSize,
      keySearch,
    );
    result.when(
      success: (success) {
        if (usersNgoaiHeThongDuocTruyCapBHVSJ.hasValue) {
          usersNgoaiHeThongDuocTruyCapBHVSJ.sink
              .add(usersNgoaiHeThongDuocTruyCapBHVSJ.value + success);
          canLoadMoreList = success.length >= pageSize;
          loadMore = false;
          refresh = false;
        } else {
          usersNgoaiHeThongDuocTruyCapBHVSJ.sink.add(success);
          canLoadMoreList = success.length >= pageSize;
        }
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  @override
  void removeTag(Node<DonViModel> node) {
    node.isCheck.isCheck = false;
    final data = node.setSelected(false);
    node.isCheckTickChildren();
    // node.isTickChildren = false;
    super.removeTag(node);
  }
}
