import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/htcs_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_common_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/ngay_tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/bieu_do_theo_don_vi_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get.dart' as get_dart;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'bao_cao_thong_ke_state.dart';

class BaoCaoThongKeCubit extends BaseCubit<BaoCaoThongKeState> {
  BaoCaoThongKeCubit() : super(BaoCaoThongKeInitial());

  NhiemVuRepository get nhiemVuRepo => get_dart.Get.find();

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  ReportRepository get _repo => get_dart.Get.find();

  ReportCommonRepository get _reportCommonService => get_dart.Get.find();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;
  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();
  BehaviorSubject<List<NhiemVuDonVi>> listBangThongKe = BehaviorSubject();
  BehaviorSubject<bool> isShowDonVi = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isShowCaNhan = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textDonViXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');
  BehaviorSubject<String> textCaNhanXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');
  BehaviorSubject<List<DonViModel>?> listCaNhanXuLy =
      BehaviorSubject.seeded(null);
  List<ChartData> listStatusData = [];

  String appId = '';
  String donViId = '';
  String caNhanXuLyId = '';
  static const String CODE = 'QLNV';
  List<List<ChartData>> listData = [];
  List<String> titleNhiemVu = [];

  void getTree() {
    hopRp.getTreeDonVi().then((value) {
      value.when(
        success: (res) {
          _getTreeDonVi.sink.add(res);
        },
        error: (err) {
          showError();
        },
      );
    });
  }

  Future<void> postBieuDoTheoDonVi({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await nhiemVuRepo.postBieuDoTheoDonVi(NgayTaoNhiemVuRequest(
      ngayTaoNhiemVu: NgayTaoNhiemVu(
        fromDate: ngayDauTien,
        toDate: ngayCuoiCung,
      ),
    ));
    result.when(
      success: (res) {
        listData.clear();
        listStatusData.clear();
        titleNhiemVu.clear();
        for (final NhiemVuDonViModel value in res.nhiemVuDonVi ?? []) {
          titleNhiemVu.add(value.tenDonVi ?? '');
          listData.add(
            [
              ChartData(
                S.current.cho_phan_xu_ly,
                (value.tinhTrangXuLy?.choPhanXuLy ?? 0).toDouble(),
                choXuLyColor,
              ),
              ChartData(
                S.current.chua_thuc_hien,
                (value.tinhTrangXuLy?.chuaThucHien ?? 0).toDouble(),
                choVaoSoColor,
              ),
              ChartData(
                S.current.dang_thuc_hien,
                (value.tinhTrangXuLy?.dangThucHien ?? 0).toDouble(),
                choTrinhKyColor,
              ),
              ChartData(
                S.current.da_thuc_hien,
                (value.tinhTrangXuLy?.daThucHien ?? 0).toDouble(),
                daXuLyColor,
              ),
            ],
          );
        }
        listStatusData.addAll([
          ChartData(
            S.current.cho_phan_xu_ly,
            (res.tinhTrangXuLy?.choPhanXuLy ?? 0).toDouble(),
            choXuLyColor,
          ),
          ChartData(
            S.current.chua_thuc_hien,
            (res.tinhTrangXuLy?.chuaThucHien ?? 0).toDouble(),
            choVaoSoColor,
          ),
          ChartData(
            S.current.dang_thuc_hien,
            (res.tinhTrangXuLy?.dangThucHien ?? 0).toDouble(),
            choTrinhKyColor,
          ),
          ChartData(
            S.current.da_thuc_hien,
            (res.tinhTrangXuLy?.daThucHien ?? 0).toDouble(),
            daXuLyColor,
          ),
        ]);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> getAppID() async {
    showLoading();
    final Result<List<HTCSModel>> result = await _reportCommonService.getHTCS(
      CODE,
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          appId = res.first.id ?? '';
        } else {
          //    emit(const CompletedLoadMore(CompleteType.ERROR));
          showError();
        }
      },
      error: (error) {
        //emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getCaNhanXuLy() async {
    showLoading();
    final data = await _repo.getUserPaging(
      donViId: donViId,
      appId: appId,
    );
    data.when(
      success: (res) {
        //todo
        showContent();
      },
      error: (err) {},
    );
  }

  void onChangeCaNhanXuLy(DonViModel value) {
    isShowCaNhan.add(false);
    donViId = value.id;
    textDonViXuLyFilter.add(
      value.name,
    );
    textCaNhanXuLyFilter.add('---${S.current.chon}---');
  }

  void onChangeDonVi(DonViModel value) {
    isShowDonVi.add(false);
    caNhanXuLyId = value.id;
    textCaNhanXuLyFilter.add(
      value.name,
    );
  }

  Future<void> getDashBroashNhiemVu({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await nhiemVuRepo.getDashBroashNhiemVu(ngayDauTien, ngayCuoiCung);
    result.when(
      success: (res) {
        // loaiNhiemVuSuject.sink.add(res.data?.trangThaiXuLy ?? []);
        // chartDataTheoLoai.clear();
        // chartData.clear();
        // for (final LoaiNhiemVuComomModel value in res.data?.loaiNhiemVu ?? []) {
        //   chartDataTheoLoai.add(
        //     ChartData(
        //       value.text.toString(),
        //       (value.value ?? 0).toDouble(),
        //       value.giaTri.toString().statusCharLoaiDSNV(),
        //       id: value.id,
        //     ),
        //   );
        // }
        //
        // chartData = (res.data?.trangThai ?? [])
        //     .map(
        //       (e) => ChartData(
        //     e.text ?? '',
        //     (e.value ?? 0).toDouble(),
        //     (e.giaTri ?? '').trangThaiToColor(),
        //   ),
        // )
        //     .toList();
        // chartData.removeLast();
        // chartData.removeAt(0);
        // statusSuject.sink.add(chartDataTheoLoai);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> getDataTheoDonVi({
    String? donviId,
    String? startDate,
    String? endDate,
    String? userId,
  }) async {
    final Result<List<NhiemVuDonVi>> result =
        await nhiemVuRepo.getDataNhiemVuTheoDonVi(
      donviId: donviId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
    result.when(
      success: (success) {
        listBangThongKe.add(success);
      },
      error: (error) {},
    );
  }
}
