import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/linh_vuc_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tao_lich_hop/linh_vuc.dart';
import 'package:ccvc_mobile/domain/repository/hop_repository.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TaoLichHopCubit extends BaseCubit<TaoLichHopState> {
  TaoLichHopCubit() : super(MainStateInitial());

  HopRepository get hopRp => Get.find();
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich.stream;

  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;

  final BehaviorSubject<LinhVucModel> linhVucSubject = BehaviorSubject();

  Stream<LinhVucModel> get linhVucStream => linhVucSubject.stream;

  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;
  LoaiSelectModel? selectLoaiHop;
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;

  LinhVucRequest fakeBody = LinhVucRequest(pageIndex: 1, pageSize: 100,);
  
  void loadData() {
    _getLoaiLich();
    _getPhamVi();
    _getNguoiChuTri();
  }

  Future<void> getLinhVucTaoLich({required LinhVucRequest body}) async {
    showLoading();
    final result = await hopRp.postLinhVucTaoLichHop(body);
    result.when(
      success: (value) {
        linhVucSubject.add(value);
      },
      error: (error) {
      },
    );
    showContent();
  }

  Future<void> _getLoaiLich() async {
    final result = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectLoaiHop = res.first;
          }
          _loaiLich.sink.add(res);
        },
        error: (err) {});
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

  Future<void> _getNguoiChuTri() async {
    final dataUser = HiveLocal.getDataUser();

    final result = await hopRp.getNguoiChuTri(
      NguoiChuTriRequest(
        isTaoHo: true,
        pageIndex: 1,
        pageSize: 100,
        userId: dataUser?.userId ?? '',
      ),
    );
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectNguoiChuTri = res.first;
          }
          _nguoiChuTri.sink.add(res);
        },
        error: (err) {});
  }

  void dispose() {
    _loaiLich.close();
    _linhVuc.close();
    _nguoiChuTri.close();
  }
}
