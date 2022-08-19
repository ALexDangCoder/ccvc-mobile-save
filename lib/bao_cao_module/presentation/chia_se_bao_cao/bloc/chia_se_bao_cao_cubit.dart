import 'package:ccvc_mobile/bao_cao_module/data/request/new_member_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/source_detail_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/htcs_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/string_extension.dart';
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

  HTCSRepository get _repoHTCS => get_dart.Get.find();

  BehaviorSubject<List<NhomCungHeThong>> themNhomStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<bool> showTree = BehaviorSubject.seeded(false);
  BehaviorSubject<String> callAPI = BehaviorSubject.seeded('');
  BehaviorSubject<List<String>> searchGroupStream = BehaviorSubject();
  final BehaviorSubject<bool> _isDuocTruyCapSubject =
      BehaviorSubject.seeded(true);

  Stream<bool> get selectDonViStream => _selectDonVi.stream;
  final BehaviorSubject<bool> _selectDonVi = BehaviorSubject<bool>();

  Stream<bool> get isDuocTruyCapStream => _isDuocTruyCapSubject.stream;

  Sink<bool> get isDuocTruyCapSink => _isDuocTruyCapSubject.sink;

  bool get valueDuocTruyCap => _isDuocTruyCapSubject.value;

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  /// List chọn đơn vị vs người

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

  bool checkSelectGroup(String name) {
    bool isSelectGroup = false;
    for (final element in listCheck) {
      if (name == element.tenNhom) {
        isSelectGroup = true;
        break;
      }
    }
    return isSelectGroup;
  }

  List<UserCommons> listUserCommon = [];
  bool checkIsShared = false;

  Future<void> getSourceShareDetail(String idReport) async {
    listUserCommon.clear();
    final data = await _repo.getSourceShareDetail(
      idReport: idReport,
      appId: appId,
    );
    data.when(
      success: (res) {
        if (res.groupAccesses?.isNotEmpty ?? false) {
          for (final element in res.groupAccesses!) {
            themNhom(element.name ?? '');
          }
          checkIsShared = true;
        }
        if (res.userCommons?.isNotEmpty ?? false) {
          listUserCommon.addAll(res.userCommons ?? []);
          checkIsShared = true;
        }

        if (res.unitAccesses?.isNotEmpty ?? false) {
          for (final element in res.unitAccesses!) {
            selectNodeInit(element.donViId);
          }
        }

        if (res.userInThisSystems?.isNotEmpty ?? false) {
          for (final element in res.userInThisSystems!) {
            idUsersNgoaiHeTHongDuocTruyCap.add(element.userId ?? '');
          }
          checkIsShared = true;
        }
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> searchCanBoPaging(
    String donViId,
    Node<DonViModel> node,
  ) async {
    showLoading();
    final data = await _repo.getUserPaging(donViId: donViId, appId: appId);
    data.when(
      success: (res) {
        for (final element in res) {
          element.parent = node;
          element.level = node.level + 1;
          element.isCheck.isCheck = node.isCheck.isCheck;

          for (final initCheck in listUserCommon) {
            if (element.value.id == initCheck.userId) {
              element.isCheck.isCheck = true;
              listUserCommon.remove(initCheck);
              selectTag(element);
              break;
            }
          }
          for(final elementNode in selectNode){
            if(element.value.id == elementNode.value.id){
              element.isCheck.isCheck = true;
            }
          }
          node.addChildMember(element);

        }
        getParentStart(node);
        showContent();
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
          getUsersNgoaiHeThongDuocTruyCap();
          getSourceShareDetail(idReport);
          searchGroupStream.add(listDropDown);
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  bool checkUser(
    Node<DonViModel> nodeParent,
    Node<DonViModel> nodeChild,
    bool isCheck,
  ) {
    bool checkAllTrue = false;
    final listNodeChildren =
        nodeParent.children.where((element) => element.value.tenCanBo != '');
    if (isCheck) {
      if (listNodeChildren.isNotEmpty) {
        for (final element in listNodeChildren) {
          if (element.isCheck.isCheck) {
            checkAllTrue = element.isCheck.isCheck;
          } else {
            checkAllTrue = false;
            break;
          }
        }
      } else {
        final listNodeChildren =
            nodeChild.children.where((element) => element.value.tenCanBo != '');
        checkAllTrue = true;
        if (!selectNode.contains(nodeChild)) {
          addSelectNode(
            nodeChild,
            isCheck: nodeChild.isCheck.isCheck,
          );
          for (final element in listNodeChildren) {
            addSelectNode(
              element,
              isCheck: false,
            );
          }
        }
        return checkAllTrue;
      }
    }
    if (!checkAllTrue && nodeParent.parent?.value.id != null) {
      nodeParent.isCheck.isCheck = false;
      addSelectNode(
        nodeParent,
        isCheck: false,
      );
      for (final element in listNodeChildren) {
        if (!selectNode.contains(element)) {
          addSelectNode(
            element,
            isCheck: element.isCheck.isCheck,
          );
        }
      }
      if (nodeChild.value.name != '') {
        if (!selectNode.contains(nodeChild)) {
          addSelectNode(
            nodeChild,
            isCheck: nodeChild.isCheck.isCheck,
          );
        }
      }
    }
    if (!checkAllTrue && nodeParent.parent?.value.id == null) {
      if (nodeChild.value.name != '') {
        if (!selectNode.contains(nodeChild)) {
          addSelectNode(
            nodeChild,
            isCheck: nodeChild.isCheck.isCheck,
          );
        }
      }
    }
    if (checkAllTrue && nodeParent.parent?.value.id != null) {
      nodeParent.isCheck.isCheck = true;
      if (!selectNode.contains(nodeParent)) {
        addSelectNode(
          nodeParent,
          isCheck: true,
        );
      }
      for (final element in listNodeChildren) {
        addSelectNode(
          element,
          isCheck: false,
        );
      }
    }
    if (checkAllTrue && nodeParent.parent?.value.id == null) {
      nodeParent.isCheck.isCheck = true;
      if (!selectNode.contains(nodeParent)) {
        addSelectNode(
          nodeParent,
          isCheck: true,
        );
      }
      for (final element in listNodeChildren) {
        addSelectNode(
          element,
          isCheck: false,
        );
      }
    }

    return checkAllTrue;
  }

  Future<String> themMoiDoiTuong() async {
    final NewUserRequest mapData = NewUserRequest(
      email: emailCached,
      fullName: nameCached?.trim(),
      birthday: birthdayCached?.toIso8601String(),
      phone: phoneNumberCached,
      position: positionCached?.trim(),
      unit: unitCached?.trim(),
      description: noteCached?.trim(),
    );
    final rs = await chiaSeBaoCao(Share.COMMON, newUser: mapData);
    return rs;
  }

  Future<String> chiaSeBaoCao(
    Share enumShare, {
    NewUserRequest? newUser,
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
        for (final element in selectNode) {
          if (element.value.tenCanBo != '') {
            final ShareReport map = ShareReport(
              userId: element.value.id,
              type: COMMON,
              sourceType: sourceType,
            );
            mapData.add(map);
            listUserCommon.removeWhere(
              (elementUser) => elementUser.userId == element.value.id,
            );
          } else {
            final ShareReport map = ShareReport(
              donViId: element.value.id,
              type: COMMON,
              sourceType: sourceType,
            );
            mapData.add(map);
          }
        }
        for (final element in listUserCommon) {
          final ShareReport map = ShareReport(
            userId: element.userId,
            type: COMMON,
            sourceType: sourceType,
          );
          mapData.add(map);
        }
        final list = idUsersNgoaiHeTHongDuocTruyCap.toList();
        for (final element in list) {
          final ShareReport map = ShareReport(
            userId: element,
            type: HAS_USER,
            sourceType: sourceType,
          );
          mapData.add(map);
        }
        if (newUser != null) {
          final ShareReport map = ShareReport(
            newUser: newUser,
            type: NEW_USER,
            sourceType: sourceType,
          );
          mapData.add(map);
        }
        mes = await shareReport(mapData, idReport: idReport);
        break;
      case Share.HAS_USER:
        break;
      case Share.NEW_USER:
        break;
    }
    return mes;
  }

  Future<String> shareReport(
    List<ShareReport> mapData, {
    required String idReport,
  }) async {
    if (mapData.isNotEmpty && !checkIsShared) {
      checkIsShared = true;
    }
    String message = '';
    if (!checkIsShared) {
      showContent();
      return S.current.danh_sach_chia_se_rong;
    }
    final rs = await _repoHTCS.shareReport(mapData, idReport, appId);
    rs.when(
      success: (res) {
        message = res;
        showContent();
      },
      error: (error) {
        message = S.current.thanh_cong;
        showContent();
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

  void searchGroup(String value) {
    final String keyword =
        value.trim().toLowerCase().withoutDiacriticalMarks.removeAllWhitespace;
    List<String> cachedSearch = [];
    if (keyword != '') {
      cachedSearch = listDropDown
          .where(
            (element) => element
                .toLowerCase()
                .withoutDiacriticalMarks
                .removeAllWhitespace
                .contains(keyword),
          )
          .toList();
      searchGroupStream.add(cachedSearch);
    } else {
      searchGroupStream.add(listDropDown);
    }
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
  int status = 1;
  bool isLock = false;
  bool loadMore = false;
  String keySearch = '';
  bool canLoadMoreList = true;
  bool refresh = false;

  String? nameCached;
  DateTime? birthdayCached;
  String? emailCached;
  String? phoneNumberCached;
  String? positionCached;
  String? unitCached;
  String? noteCached;

  final Set<String> idUsersNgoaiHeTHongDuocTruyCap = {};

  bool checkTick(String idUser) {
    bool isTick = false;
    final listCheck = idUsersNgoaiHeTHongDuocTruyCap.toList();
    for (final element in listCheck) {
      if (element == idUser) {
        isTick = true;
        break;
      }
    }
    return isTick;
  }

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

  void refreshData() {
    keySearch = '';
    pageNumber = 0;
    pageSize = 10;
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
      status,
      isLock,
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

  void checkChildren(Node<DonViModel> node) {
    for (final element in node.children) {
      if (element.value.tenCanBo != '') {
        element.isCheck.isCheck = node.isCheck.isCheck;
      }
    }
  }

  final List<DonViModel> listSelect = [];

  void selectTag(Node<DonViModel> node) {
    final nodeSearch = searchNode(node);
    if (nodeSearch.isCheck.isCheck == false) {
      nodeSearch.isTickChildren.isTick = false;
      addSelectNode(
        nodeSearch,
        isCheck: false,
      );
    }
    checkChildren(nodeSearch);
    bool checkTickAllChildren = false;
    if (nodeSearch.parent != null) {
      nodeSearch.isCheckTickChildren();
      checkTickAllChildren =
          checkUser(nodeSearch.parent!, nodeSearch, node.isCheck.isCheck);
    } else {
      if (!selectNode.contains(nodeSearch)) {
        addSelectParent(
          nodeSearch,
          isCheck: nodeSearch.isCheck.isCheck,
        );
      }
    }
    if (checkTickAllChildren && nodeSearch.children.isNotEmpty) {
      if (!selectNode.contains(nodeSearch)) {
        addSelectParent(
          nodeSearch,
          isCheck: nodeSearch.isCheck.isCheck,
        );
      }
    }
    _selectDonVi.sink.add(nodeSearch.isCheck.isCheck);
  }

  void selectNodeInit(String donViId) {
    final Node<DonViModel> node = Node<DonViModel>(DonViModel(
      id: donViId,
      donViId: donViId,
    ));
    for (final tree in listTree) {
      final nodeSearch = tree.search(node);
      if (nodeSearch != null) {
        nodeSearch.isCheck.isCheck = true;
        selectTag(nodeSearch);
      }
    }
  }

  Node<DonViModel> searchNode(Node<DonViModel> node) {
    for (final tree in listTree) {
      final nodeSearch = tree.search(node, level: node.level);
      if (nodeSearch != null) {
        return nodeSearch;
      }
    }
    return node;
  }

  @override
  void removeTag(Node<DonViModel> node) {
    node.isCheck.isCheck = false;
    node.isTickChildren.isTick = false;
    //node.isCheckTickChildren();

    super.removeTag(node);
  }
}
