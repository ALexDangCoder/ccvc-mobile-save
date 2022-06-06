import 'dart:io';
import 'dart:math';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TaoLichHopCubit extends BaseCubit<TaoLichHopState> {
  TaoLichHopCubit() : super(MainStateInitial());

  HopRepository get hopRp => Get.find();
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich = BehaviorSubject();
  final BehaviorSubject<ChuongTrinhHopModel> chuongTrinhHopSubject =
      BehaviorSubject();

  Stream<ChuongTrinhHopModel> get chuongTrinhHopStream =>
      chuongTrinhHopSubject.stream;

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich.stream;
  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;
  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  BehaviorSubject<List<DsDiemCau>> dsDiemCauSubject =
      BehaviorSubject.seeded([]);

  LoaiSelectModel? selectLoaiHop;
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;
  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  Future<void> createMeeting() async {
    if (taoLichHopRequest.title?.isEmpty ?? true) {
      // thong bao validate
      return;
    }

    if (taoLichHopRequest.isAllDay ?? false) {
      taoLichHopRequest.timeTo = '';
      taoLichHopRequest.timeStart = '';
    }
    //check hình thức họp
    if (taoLichHopRequest.bitHopTrucTuyen != null) {
      if (taoLichHopRequest.bitHopTrucTuyen!) {
        taoLichHopRequest.diaDiemHop = '';
      } else {
        //
      }
    }
  }

  void loadData() {
    _getLoaiLich();
    _getPhamVi();
    getCanBo();
    // _getNguoiChuTri();
  }

  Future<void> _getLoaiLich() async {
    showLoading();
    final result = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLoaiHop = res.first;
        }
        _loaiLich.sink.add(res);
      },
      error: (err) {},
    );
    showContent();
  }

  Future<void> getChuongTrinhHop(String id) async {
    final result = await hopRp.getChuongTrinhHop(id);
    result.when(
      success: (value) {
        chuongTrinhHopSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> _getPhamVi() async {
    final result = await hopRp
        .getLinhVuc(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectLinhVuc = res.first;
          }
          _linhVuc.sink.add(res);
        },
        error: (err) {});
  }

  ThanhPhanThamGiaReponsitory get thanhPhanThamGiaRp => Get.find();

  final BehaviorSubject<List<DonViModel>> danhSachCB = BehaviorSubject();

  Future<void> getCanBo() async {
    final dataUser = HiveLocal.getDataUser();
    final result = await thanhPhanThamGiaRp.getSeachCanBo(
      SearchCanBoRequest(
        iDDonVi: dataUser?.userInformation?.donViTrucThuoc?.id,
        pageIndex: 1,
        pageSize: 100,
      ),
    );
    result.when(
      success: (res) {
        danhSachCB.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> postFileTaoLichHop({
    required int entityType,
    required String entityName,
    required String entityId,
    required bool isMutil,
    required List<File> files,
  }) async {
    showLoading();
    await hopRp
        .postFileTaoLichHop(entityType, entityName, entityId, isMutil, files)
        .then((value) {
      value.when(
        success: (res) {},
        error: (err) {},
      );
    });
  }

  String genLinkHop() {
    final tenDonVi = HiveLocal.getDataUser()
        ?.userInformation
        ?.donVi
        ?.vietNameseParse()
        .replaceAll(' ', '-')
        .toUpperCase();
    final random = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final String randomRes =
        List.generate(6, (index) => _chars[random.nextInt(_chars.length)])
            .join();
    return '$BASE_URL_MEETING$tenDonVi-$randomRes';
  }

  // Future<void> _getNguoiChuTri() async {
  //   final dataUser = HiveLocal.getDataUser();
  //
  //   final result = await hopRp.getNguoiChuTri(
  //     NguoiChuTriRequest(
  //       isTaoHo: true,
  //       pageIndex: 1,
  //       pageSize: 100,
  //       userId: dataUser?.userId ?? '',
  //     ),
  //   );
  //   result.when(
  //     success: (res) {
  //       if (res.isNotEmpty) {
  //         selectNguoiChuTri = res.first;
  //       }
  //       _nguoiChuTri.sink.add(res);
  //     },
  //     error: (err) {},
  //   );
  // }

  void dispose() {
    _loaiLich.close();
    _linhVuc.close();
    _nguoiChuTri.close();
    danhSachCB.close();
  }
}
