import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/check_trung_lich_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tinh_huyen_xa_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class TaoLichLamViecCubit extends BaseCubit<TaoLichLamViecState> {
  TaoLichLamViecCubit() : super(TaoLichLVStateInitial());

  LichLamViecRepository get _lichLamViec => Get.find();

  TaoMoiBanGhiRequest requestBanGhi = TaoMoiBanGhiRequest(
    content: '<p>ưq</p>',
    phienHopId: null,
    scheduleId: '7765603d-4493-4f7c-8a06-2d2b7511eedb',
    scheduleOpinionId: null,
  );
  String selectedCountry = '';
  String selectedCountryID = '';
  BehaviorSubject<bool> lichLapTuyChinhSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> lichLapKhongLapLaiSubject =
      BehaviorSubject.seeded(false);

  BehaviorSubject<DateTime> startDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );
  BehaviorSubject<String> changeOption = BehaviorSubject();
  BehaviorSubject<bool> checkTrongNuoc = BehaviorSubject();
  BehaviorSubject<MessageModel> taoMoiBanGhiSubject = BehaviorSubject();

  BehaviorSubject<DateTime> endDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );
  BehaviorSubject<bool> isCheckAllDaySubject = BehaviorSubject.seeded(false);

  Stream<bool> get isCheckAllDayStream => isCheckAllDaySubject.stream;

  BehaviorSubject<List<String>> listItemPersonSubject =
      BehaviorSubject.seeded(listPerson);

  BehaviorSubject<List<ItemSelectModel>> listColorDefaultSubject =
      BehaviorSubject();

  Stream<List<ItemSelectModel>> get listColorDefaultStream =>
      listColorDefaultSubject.stream;

  Stream<MessageModel> get taoMoiBanGhiStream => taoMoiBanGhiSubject.stream;

  Stream<DateTime> get startDateStream => startDateSubject.stream;

  Stream<DateTime> get endDateStream => endDateSubject.stream;

  Stream<List<String>> get listItemPersonStream => listItemPersonSubject.stream;
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich1 = BehaviorSubject();

  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();
  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  final BehaviorSubject<List<NhacLaiModel>> _nhacLai =
      BehaviorSubject.seeded(listNhacLai);
  final BehaviorSubject<List<LichLapModel>> lichLapModelSubject =
      BehaviorSubject.seeded(listLichLap);

  final BehaviorSubject<List<TinhSelectModel>> tinhSelectSubject =
      BehaviorSubject();
  final BehaviorSubject<List<HuyenSelectModel>> huyenSelectSubject =
      BehaviorSubject();
  final BehaviorSubject<List<XaSelectModel>> xaSelectSubject =
      BehaviorSubject();
  final BehaviorSubject<List<DatNuocSelectModel>> datNuocSelectSubject =
      BehaviorSubject();

  Stream<List<TinhSelectModel>> get tinhSelect => tinhSelectSubject.stream;

  Stream<List<HuyenSelectModel>> get huyenSelect => huyenSelectSubject.stream;

  Stream<List<XaSelectModel>> get xaSelect => xaSelectSubject.stream;

  Stream<List<DatNuocSelectModel>> get datNuocSelect =>
      datNuocSelectSubject.stream;

  Set<int> lichLapItem = {};
  List<int> lichLapItem1 = <int>[];

  List<int> listNgayChonTuan(String vl) {
    final List<String> lSt = vl.replaceAll(',', '').split('');
    final List<int> numbers = lSt.map(int.parse).toList();
    return numbers;
  }

  DateTime dateTimeLapDenNgay = DateTime.now();
  BehaviorSubject<DateTime> changeDateTimeSubject = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;

  Stream<List<NhacLaiModel>> get nhacLai => _nhacLai.stream;

  Stream<List<LichLapModel>> get lichLap => lichLapModelSubject.stream;

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich1.stream;
  LoaiSelectModel? selectLoaiLich;
  String? selectLoaiLichId = 'a0602d4e-d4cb-4259-a7ea-0260360852f3';
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;
  NhacLaiModel selectNhacLai = NhacLaiModel.seeded();
  LichLapModel selectLichLap = LichLapModel.seeded();
  List<DonViModel>? donviModel;

  TinhSelectModel? tinhSelectModel = TinhSelectModel();
  HuyenSelectModel? huyenSelectModel = HuyenSelectModel();
  XaSelectModel? xaSelectModel = XaSelectModel();
  DatNuocSelectModel? datNuocSelectModel = DatNuocSelectModel();
  String? dateFrom;
  String? timeFrom;
  String? dateEnd;
  String? timeEnd;
  String? title = '';
  String? content = '';
  String? location = '';
  String? typeScheduleName = '';
  String? typeScheduleId = '';
  String? dateTimeFrom;
  String? dateTimeTo;
  String? linhVucString;
  String? lichLapString;
  String? nguoiChuTriString;
  String? days;
  int? typeRepeat;
  String? dateRepeat;
  ScheduleReminder? scheduleReminder;
  bool? publishSchedule;
  ChiTietLichLamViecModel chiTietLichLamViecModel = ChiTietLichLamViecModel();
  final toast = FToast();

  bool allDay = true;

  void listeningStartDataTime(DateTime dateAndTime) {
    dateFrom = dateAndTime.formatApi;
    timeFrom =
        '${dateAndTime.hour.toString()}:${dateAndTime.minute.toString()}';
    startDateSubject.add(dateAndTime);
  }

  void listeningEndDataTime(DateTime dateAndTime) {
    dateEnd = dateAndTime.formatApi;
    timeEnd = '${dateAndTime.hour.toString()}:${dateAndTime.minute.toString()}';
    endDateSubject.add(dateAndTime);
  }

  Future<void> taoMoiBanGhi(TaoMoiBanGhiRequest request) async {
    final result = await _lichLamViec.postTaoMoiBanGhi(request);

    result.when(
      success: (value) {
        taoMoiBanGhiSubject.add(value);
      },
      error: (error) {},
    );
  }

  bool checkValidateTime() {
    if (endDateSubject.value.isBefore(startDateSubject.value)) {
      return false;
    }
    return true;
  }

  String? validateInputText(String inputText) {
    if (inputText.isEmpty) {
      return S.current.khong_the_bo_trong;
    }
    return null;
  }

  Future<void> deleteFile(File deleteFile, List<File> list) async {
    list.remove(deleteFile);
  }

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;

  Future<void> loadData() async {
    final queue = Queue(parallel: 4);
    unawaited(queue.add(() => _getLinhVuc()));
    unawaited(queue.add(() => _dataLoaiLich()));
    unawaited(queue.add(() => _getNguoiChuTri()));
    unawaited(queue.add(() => getDatatinh()));
    unawaited(queue.add(() => getDataDatNuoc()));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  void selectColor(ItemSelectModel item) {
    listColorDefault.forEach((element) {
      if (element == item) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });

    listColorDefaultSubject.add(listColorDefault);
  }

  Future<void> _dataLoaiLich() async {
    final result = await _lichLamViec
        .getLoaiLich(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 0));
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLoaiLich = res.first;
        }
        _loaiLich1.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }

  Future<void> _getLinhVuc() async {
    final result = await _lichLamViec
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

  String name = '';

  Future<void> _getNguoiChuTri() async {
    final dataUser = HiveLocal.getDataUser();

    final result = await _lichLamViec.getNguoiChuTri(
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
            name = HiveLocal.getDataUser()?.userId ?? '';
            for (var i in res) {
              if (i.userId.toString() == name.toString()) {
                selectNguoiChuTri = i;
                break;
              }
            }
          }
          _nguoiChuTri.sink.add(res);
        },
        error: (err) {});
  }

  Future<void> checkTrungLich({
    required BuildContext context,
    required String title,
    required String content,
    required String location,
  }) async {
    final result =
        await _lichLamViec.checkTrungLichLamviec(CheckTrungLichRequest(
      dateFrom: dateFrom ?? DateTime.now().formatApi,
      dateTo: dateEnd ?? DateTime.now().formatApi,
      timeFrom: timeFrom ??
          '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
      timeTo: timeEnd ??
          '${DateTime.now().hour.toString()}:${(DateTime.now().minute + 1).toString()}',
      donViId: selectNguoiChuTri?.donViId,
      userId: selectNguoiChuTri?.userId,
    ));
    result.when(
        success: (res) {
          if (res.data == true) {
            showDiaLog(
              context,
              textContent: S.current.ban_co_muon_tiep_tuc_khong,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () async {
                await taoLichLamViec(
                  title: title,
                  content: content,
                  location: location,
                );
                Navigator.pop(context, true);
              },
              title: res.code ?? '',
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.icUserMeeting),
            );
          } else {
            taoLichLamViec(
              title: title,
              content: content,
              location: location,
            );
          }
        },
        error: (error) {});
  }

  Future<void> taoLichLamViec({
    required String title,
    required String content,
    required String location,
  }) async {
    if (selectLoaiLichId == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
      tinhSelectModel?.tenTinhThanh = '';
      tinhSelectModel?.id = '';
      huyenSelectModel?.tenQuanHuyen = '';
      huyenSelectModel?.id = '';
      xaSelectModel?.tenXaPhuong = '';
      xaSelectModel?.id = '';
    } else {
      datNuocSelectModel?.name = '';
      datNuocSelectModel?.id = '';
    }
    final result = await _lichLamViec.taoLichLamViec(
        title,
        selectLoaiLichId ?? '',
        selectLinhVuc?.id ?? '',
        tinhSelectModel?.id ?? '',
        tinhSelectModel?.tenTinhThanh ?? '',
        huyenSelectModel?.id ?? '',
        huyenSelectModel?.tenQuanHuyen ?? '',
        xaSelectModel?.id ?? '',
        xaSelectModel?.tenXaPhuong ?? '',
        datNuocSelectModel?.name ?? '',
        datNuocSelectModel?.id ?? '',
        dateFrom ?? DateTime.now().formatApi,
        timeFrom ??
            '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
        dateEnd ?? DateTime.now().formatApi,
        timeEnd ??
            '${DateTime.now().hour.toString()}:${(DateTime.now().minute).toString()}',
        content,
        location,
        '',
        '',
        '',
        2,
        '',
        publishSchedule ?? false,
        //cong khai lich
        '',
        false,
        true,
        selectNguoiChuTri?.userId ?? '',
        selectNguoiChuTri?.donViId ?? '',
        '',
        isCheckAllDaySubject.value,
        true,
        donviModel ?? [],
        selectNhacLai.value ?? 1,
        selectLichLap.id ?? 0,
        dateFrom ?? DateTime.now().formatApi,
        dateTimeLapDenNgay.formatApi,
        true,
        lichLapItem1);
    result.when(success: (res) {
      emit(CreateSuccess());
      showContent();
    }, error: (error) {
      toast.showToast(
        child: ShowToast(
          text: error.message,
        ),
        gravity: ToastGravity.BOTTOM,
      );
      showContent();
    });
  }

  Future<void> suaLichLamViec() async {
    final result = await _lichLamViec.suaLichLamViec(
        title ?? '',
        selectLoaiLich?.id ?? '',
        selectLinhVuc?.id ?? '',
        tinhSelectModel?.tenTinhThanh ?? '',
        huyenSelectModel?.tenQuanHuyen ?? '',
        xaSelectModel?.tenXaPhuong ?? '',
        dateFrom ?? DateTime.now().formatApi,
        timeFrom ??
            '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
        dateEnd ?? DateTime.now().formatApi,
        timeEnd ??
            '${DateTime.now().hour.toString()}:${(DateTime.now().minute + 1).toString()}',
        content ?? '',
        location ?? '',
        '',
        '',
        '',
        2,
        '',
        false,
        '',
        false,
        selectNguoiChuTri?.userId ?? '',
        selectNguoiChuTri?.donViId ?? '',
        '',
        isCheckAllDaySubject.value,
        true,
        donviModel ?? [],
        selectNhacLai.value ?? 1,
        selectLichLap.id ?? 0,
        dateFrom ?? DateTime.now().formatApi,
        dateTimeLapDenNgay.formatApi,
        true,
        lichLapItem1);
    result.when(success: (res) {
      emit(CreateSuccess());
      showContent();
    }, error: (error) {
      showContent();
    });
  }

  Future<void> suaLichLamViecNuocNgoai() async {
    final result = await _lichLamViec.suaLichLamViecNuocNgoai(
        title ?? '',
        selectLoaiLich?.id ?? '',
        selectLinhVuc?.id ?? '',
        tinhSelectModel?.tenTinhThanh ?? '',
        huyenSelectModel?.tenQuanHuyen ?? '',
        xaSelectModel?.tenXaPhuong ?? '',
        selectedCountryID,
        dateFrom ?? DateTime.now().formatApi,
        timeFrom ??
            '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
        dateEnd ?? DateTime.now().formatApi,
        timeEnd ??
            '${DateTime.now().hour.toString()}:${(DateTime.now().minute + 1).toString()}',
        content ?? '',
        location ?? '',
        '',
        '',
        '',
        2,
        '',
        false,
        '',
        false,
        selectNguoiChuTri?.userId ?? '',
        selectNguoiChuTri?.donViId ?? '',
        '',
        isCheckAllDaySubject.value,
        true,
        donviModel ?? [],
        selectNhacLai.value ?? 1,
        selectLichLap.id ?? 0,
        dateFrom ?? DateTime.now().formatApi,
        dateTimeLapDenNgay.formatApi,
        true,
        lichLapItem1);
    result.when(success: (res) {
      emit(CreateSuccess());
      showContent();
    }, error: (error) {
      showContent();
    });
  }

  Future<void> taoBaoCaoKetQua({
    required String reportStatusId,
    required String scheduleId,
    required List<File> files,
  }) async {
    await _lichLamViec
        .taoBaoCaoKetQua(
      reportStatusId,
      scheduleId,
      files,
    )
        .then((value) {
      value.when(
        success: (res) {},
        error: (err) {},
      );
    });
  }

  Future<void> getDatatinh() async {
    final result = await _lichLamViec.tinhSelect(
      TinhSelectRequest(pageIndex: 1, pageSize: 100),
    );
    result.when(
        success: (res) {
          tinhSelectSubject.sink.add(res.items ?? []);
        },
        error: (error) {});
  }

  Future<void> getDataHuyen(String provinceId) async {
    final result = await _lichLamViec.huyenSelect(
      HuyenSelectRequest(pageIndex: 1, pageSize: 100, provinceId: provinceId),
    );
    result.when(
        success: (res) {
          huyenSelectSubject.sink.add(res.items ?? []);
          xaSelectSubject.sink.add([]);
          xaSelectModel = XaSelectModel();
        },
        error: (error) {});
  }

  Future<void> getDataXa(String disytrictId) async {
    final result = await _lichLamViec.xaSelect(
      XaSelectRequest(pageIndex: 1, pageSize: 100, disytrictId: disytrictId),
    );
    result.when(
        success: (res) {
          xaSelectSubject.sink.add(res.items ?? []);
        },
        error: (error) {});
  }

  Future<void> getDataDatNuoc() async {
    final result = await _lichLamViec.datNuocSelect(
      DatNuocSelectRequest(pageIndex: 1, pageSize: 100),
    );
    result.when(
        success: (res) {
          datNuocSelectSubject.sink.add(res.items ?? []);
        },
        error: (error) {});
  }

  void dispose() {
    _nguoiChuTri.close();
  }

  void showDialog(WidgetType type) {
    if (_showDialogSetting.hasValue) {
      if (_showDialogSetting.value == type) {
        closeDialog();
      } else {
        _showDialogSetting.add(type);
      }
    } else {
      _showDialogSetting.add(type);
    }
  }

  void closeDialog() {
    _showDialogSetting.add(null);
  }
}
