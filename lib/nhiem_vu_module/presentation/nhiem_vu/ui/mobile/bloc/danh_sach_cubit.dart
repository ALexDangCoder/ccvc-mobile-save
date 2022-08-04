import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/danh_sach_cong_viec_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/danh_sach_nhiem_vu_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/ngay_tao_nhiem_vu_request.dart'
    as request;
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/bieu_do_theo_don_vi_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/dash_broash/dash_broash_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/trang_thai_bieu_do_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/item_select_bieu_do.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/debouncer.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DanhSachCubit extends BaseCubit<BaseState> {
  DanhSachCubit() : super(DanhSachStateInitial());

  NhiemVuRepository get repo => Get.find();
  int pageSize = 5;
  int pageIndex = 1;
  bool isCaNhan = true;
  bool isNhiemVuDonViCon = false;
  String keySearch = '';
  BehaviorSubject<List<PageDatas>> dataSubjects = BehaviorSubject();
  BehaviorSubject<String> searchSubjects = BehaviorSubject();

  final BehaviorSubject<List<ItemSellectBieuDo>> selectBieuDoModelSubject =
      BehaviorSubject.seeded([
    ItemSellectBieuDo(stateBieuDo.TheoLoai, true),
    ItemSellectBieuDo(stateBieuDo.TheoTrangThai, false),
    ItemSellectBieuDo(stateBieuDo.TheoDonVi, false),
  ]);

  BehaviorSubject<stateBieuDo> getStateLDM =
      BehaviorSubject.seeded(stateBieuDo.TheoTrangThai);
  final BehaviorSubject<bool> checkClickSearch =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get checkClickSearchStream => checkClickSearch.stream;

  void setSelectSearch() {
    checkClickSearch.sink.add(!checkClickSearch.value);
  }

  static const String CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
  static const String CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
  static const String DANG_THUC_HIEN = 'DANG_THUC_HIEN';
  static const String DA_HOAN_THANH = 'DA_HOAN_THANH';

  bool isHideClearData = false;
  String ngayDauTien = '';
  String ngayKetThuc = '';
  String mangTrangThai = '';
  String loaiNhiemVuId = '';
  int? trangThaiHanXuLy;
  bool checkDataNhiemVu = false;
  List<String> titleNhiemVu = [];
  List<List<ChartData>> listData = [];
  BehaviorSubject<bool> isCheckDataNVDV = BehaviorSubject.seeded(false);
  List<ChartData> listStatusData = [];

  void callApi(bool isCheckCaNhan, {bool canCallApi = true}) {
    initTimeRange();
    getDashBroashNhiemVuCaNhan(
      ngayDauTien: ngayDauTien,
      ngayCuoiCung: ngayKetThuc,
    );
    getDashBroashCongViecCaNhan(
      ngayDauTien: ngayDauTien,
      ngayCuoiCung: ngayKetThuc,
    );
    if (canCallApi) {
      callDataDanhSach(ngayDauTien, ngayKetThuc, isCheckCaNhan);
    }
  }

  void callApiDonVi(
    bool isCheckCaNhan, {
    bool canCallApi = true,
  }) {
    initTimeRange();
    postBieuDoTheoDonVi(ngayDauTien: ngayDauTien, ngayCuoiCung: ngayKetThuc);
    getDashBroashNhiemVu(ngayDauTien: ngayDauTien, ngayCuoiCung: ngayKetThuc);
    // getDashBroashCongViec(
    //   ngayDauTien: ngayDauTien,
    //   ngayCuoiCung: ngayKetThuc,
    // );
    if (canCallApi) {
      callDataDanhSach(ngayDauTien, ngayKetThuc, isCheckCaNhan);
    }
  }

  void callApiDashBroashDonVi(bool isCheckCaNhan) {
    postBieuDoTheoDonVi(ngayDauTien: ngayDauTien, ngayCuoiCung: ngayKetThuc);
    getDashBroashNhiemVu(ngayDauTien: ngayDauTien, ngayCuoiCung: ngayKetThuc);
    // getDashBroashCongViec(
    //   ngayDauTien: ngayDauTien,
    //   ngayCuoiCung: ngayKetThuc,
    // );
    callDataDanhSach(ngayDauTien, ngayKetThuc, isCheckCaNhan);
  }

  void callApiDashBroash(bool isCheckCaNhan) {
    getDashBroashNhiemVuCaNhan(
      ngayDauTien: ngayDauTien,
      ngayCuoiCung: ngayKetThuc,
    );
    callDataDanhSach(ngayDauTien, ngayKetThuc, isCheckCaNhan);
  }

  void callDataDanhSach(String start, String end, bool isCheckCaNhan) {
    postDanhSachNhiemVu(
      index: pageIndex,
      isNhiemVuCaNhan: isCheckCaNhan,
      isSortByHanXuLy: true,
      mangTrangThai: [],
      ngayTaoNhiemVu: {'FromDate': start, 'ToDate': end},
      size: pageSize,
      keySearch: keySearch,
    );
  }

  void apiDanhSachCongViecCaNhan(String start, String end, bool isCheckCaNhan) {
    postDanhSachCongViec(
      hanXuLy: {'FromDate': start, 'ToDate': end},
      index: pageIndex,
      isCaNhan: isCheckCaNhan,
      isSortByHanXuLy: true,
      keySearch: keySearch,
      mangTrangThai: [],
      size: pageSize,
    );
  }

  Debouncer debouncer = Debouncer();

  Future<void> postDanhSachNhiemVu({
    int index = 1,
    required bool isNhiemVuCaNhan,
    required bool isSortByHanXuLy,
    required String keySearch,
    required List<String> mangTrangThai,
    required Map<String, String> ngayTaoNhiemVu,
    required int size,
    int? trangThaiHanXuLy,
  }) async {
    mangTrangThai.remove('');
    final DanhSachNhiemVuRequest danhSachNhiemVuRequest =
        DanhSachNhiemVuRequest(
      isNhiemVuDonViCon: isNhiemVuDonViCon,
      index: index,
      isNhiemVuCaNhan: isNhiemVuCaNhan,
      isSortByHanXuLy: isSortByHanXuLy,
      noiDungTheoDoi: keySearch.trim(),
      mangTrangThai: [
        CHO_PHAN_XU_LY,
        CHUA_THUC_HIEN,
        DANG_THUC_HIEN,
        DA_HOAN_THANH,
      ],
      ngayTaoNhiemVu: ngayTaoNhiemVu,
      size: size,
      trangThaiHanXuLy: trangThaiHanXuLy,
      loaiNhiemVuId: loaiNhiemVuId,
    );
    showLoading();
    loadMorePage = index;
    final result = await repo.danhSachNhiemVu(danhSachNhiemVuRequest);
    result.when(
      success: (res) {
        if (index == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            showContent();
            emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
          }
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
        }
      },
      error: (error) {},
    );
  }

  Future<void> postDanhSachCongViec({
    required Map<String, String>? hanXuLy,
    required int? index,
    required bool? isCaNhan,
    required bool? isSortByHanXuLy,
    required String? keySearch,
    required List<String>? mangTrangThai,
    required int? size,
    int? trangThaiHanXuLy,
  }) async {
    final DanhSachCongViecRequest danhSachCongViecRequest =
        DanhSachCongViecRequest(
      hanXuLy: hanXuLy,
      index: index,
      isCaNhan: isCaNhan,
      isSortByHanXuLy: isSortByHanXuLy,
      keySearch: keySearch,
      mangTrangThai: [
        CHO_PHAN_XU_LY,
        CHUA_THUC_HIEN,
        DANG_THUC_HIEN,
        DA_HOAN_THANH,
      ],
      size: size,
      trangThaiHanXuLy: trangThaiHanXuLy,
    );
    loadMorePage = index ?? 1;
    final result = await repo.danhSachCongViec(danhSachCongViecRequest);
    result.when(
      success: (res) {
        dataSubjects.sink.add(res.pageData ?? []);
        if (index == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            //   showEmpty();
            // emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
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

  BehaviorSubject<List<LoaiNhiemVuComomModel>> loaiNhiemVuSuject =
      BehaviorSubject();
  BehaviorSubject<List<ChartData>> statusSuject = BehaviorSubject();
  List<ChartData> chartData = [];

  Future<void> getDashBroashNhiemVu({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await repo.getDashBroashNhiemVu(ngayDauTien, ngayCuoiCung);
    result.when(
      success: (res) {
        loaiNhiemVuSuject.sink.add(res.data?.trangThaiXuLy ?? []);
        chartDataTheoLoai.clear();
        chartData.clear();
        for (final LoaiNhiemVuComomModel value in res.data?.loaiNhiemVu ?? []) {
          chartDataTheoLoai.add(
            ChartData(
              value.text.toString(),
              (value.value ?? 0).toDouble(),
              value.giaTri.toString().statusCharLoaiDSNV(),
              id: value.id,
            ),
          );
        }

        chartData = (res.data?.trangThai ?? [])
            .map(
              (e) => ChartData(
                e.text ?? '',
                (e.value ?? 0).toDouble(),
                (e.giaTri ?? '').trangThaiToColor(),
              ),
            )
            .toList();
        chartData.removeLast();
        chartData.removeAt(0);
        statusSuject.sink.add(chartDataTheoLoai);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> postBieuDoTheoDonVi({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await repo.postBieuDoTheoDonVi(request.NgayTaoNhiemVuRequest(
      ngayTaoNhiemVu: request.NgayTaoNhiemVu(
        fromDate: ngayDauTien,
        toDate: ngayCuoiCung,
      ),
    ));
    result.when(
      success: (res) {
        listData.clear();
        listStatusData.clear();
        titleNhiemVu.clear();
        isCheckDataNVDV.sink.add(false);
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
        if (res.nhiemVuDonVi?.isNotEmpty ?? false) {
          isCheckDataNVDV.sink.add(true);
        }
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  BehaviorSubject<List<LoaiNhiemVuComomModel>> loaiCongViecSuject =
      BehaviorSubject();
  BehaviorSubject<List<ChartData>> statusCongViecSuject = BehaviorSubject();
  List<ChartData> chartDataCongViec = [];

  Future<void> getDashBroashCongViec({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await repo.getDashBroashCongViec(ngayDauTien, ngayCuoiCung);
    result.when(
      success: (res) {
        loaiCongViecSuject.sink.add(res.data?.trangThaiXuLy ?? []);
        chartDataCongViec = (res.data?.trangThai ?? [])
            .map(
              (e) => ChartData(
                e.text ?? '',
                (e.value ?? 0).toDouble(),
                (e.giaTri ?? '').trangThaiToColor(),
              ),
            )
            .toList();
        statusCongViecSuject.sink.add(chartDataCongViec);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  BehaviorSubject<List<LoaiNhiemVuComomModel>> loaiNhiemVuCaNhanSuject =
      BehaviorSubject();
  BehaviorSubject<List<ChartData>> statusNhiemVuCaNhanSuject =
      BehaviorSubject();
  List<ChartData> chartDataNhiemVuCaNhan = [];

  Future<void> getDashBroashNhiemVuCaNhan({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    showLoading();
    final result = await repo.getDashBroashNhiemVuCaNhan(
      ngayDauTien,
      ngayCuoiCung,
    );
    result.when(
      success: (res) {
        loaiNhiemVuCaNhanSuject.sink.add(res.data?.trangThaiXuLy ?? []);
        chartDataNhiemVuCaNhan = (res.data?.trangThai ?? [])
            .map(
              (e) => ChartData(
                e.text ?? '',
                (e.value ?? 0).toDouble(),
                (e.giaTri ?? '').trangThaiToColor(),
              ),
            )
            .toList();
        chartDataNhiemVuCaNhan.removeLast();
        chartDataNhiemVuCaNhan.removeAt(0);
        chartDataNhiemVuCaNhan.removeAt(0);
        statusNhiemVuCaNhanSuject.sink.add(chartDataNhiemVuCaNhan);
        // showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  BehaviorSubject<List<LoaiNhiemVuComomModel>> loaiCongViecCaNhanSuject =
      BehaviorSubject();
  BehaviorSubject<List<ChartData>> statusCongViecCaNhanSuject =
      BehaviorSubject();
  List<ChartData> chartDataCongViecCaNhan = [];

  Future<void> getDashBroashCongViecCaNhan({
    required String ngayDauTien,
    required String ngayCuoiCung,
  }) async {
    final result =
        await repo.getDashBroashCongViecCaNhan(ngayDauTien, ngayCuoiCung);
    result.when(
      success: (res) {
        loaiCongViecCaNhanSuject.sink.add(res.data?.trangThaiXuLy ?? []);
        chartDataCongViecCaNhan = (res.data?.trangThai ?? [])
            .map(
              (e) => ChartData(
                e.text ?? '',
                (e.value ?? 0).toDouble(),
                (e.giaTri ?? '').trangThaiToColor(),
              ),
            )
            .toList();
        statusCongViecCaNhanSuject.sink.add(chartDataCongViecCaNhan);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  final List<ChartData> chartDataNhiemVuCANHAN = [
    ChartData(
      S.current.chua_thuc_hien,
      0,
      choVaoSoColor,
    ),
    ChartData(
      S.current.dang_thuc_hien,
      0,
      choTrinhKyColor,
    ),
    ChartData(
      S.current.da_thuc_hien,
      0,
      daXuLyColor,
    ),
  ];
  final List<ChartData> chartDataTheoLoai = [];

  final List<ChartData> chartDataNhiemVu = [
    ChartData(
      S.current.cho_phan_xu_ly,
      0,
      choXuLyColor,
    ),
    ChartData(
      S.current.chua_thuc_hien,
      0,
      choVaoSoColor,
    ),
    ChartData(
      S.current.dang_thuc_hien,
      0,
      choTrinhKyColor,
    ),
    ChartData(
      S.current.da_thuc_hien,
      0,
      daXuLyColor,
    ),
  ];

  void initTimeRange() {
    final dataDateTime = DateTime.now();
    ngayDauTien =
        DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day - 30)
            .formatApi;
    ngayKetThuc = dataDateTime.formatApi;
  }
}
