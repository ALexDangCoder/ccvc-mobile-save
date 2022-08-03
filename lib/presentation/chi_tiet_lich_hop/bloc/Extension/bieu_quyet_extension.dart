import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/sua_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_moi_vote_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lua_chon_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:intl/intl.dart';

///Biẻu quyết
extension BieuQuyet on DetailMeetCalenderCubit {
  // danh sach bieu quyet
  Future<void> getDanhSachBieuQuyetLichHop({
    String? idLichHop,
    String? canBoId,
    String? idPhienHop,
  }) async {
    showLoading();
    final result = await hopRp.getDanhSachBieuQuyetLichHop(
      idLichHop ?? '',
      canBoId ?? '',
      idPhienHop ?? '',
    );
    result.when(
      success: (res) {
        listBieuQuyet = res;
        streamBieuQuyet.sink.add(res);
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> themMoiVote({
    required String? lichHopId,
    required String? bieuQuyetId,
    required String? donViId,
    required String? canBoId,
    required String? luaChonBietQuyetId,
    required String? idPhienhopCanbo,
  }) async {
    showLoading();
    final ThemMoiVoteRequest themMoiVote = ThemMoiVoteRequest(
      lichHopId: lichHopId,
      bieuQuyetId: bieuQuyetId,
      donViId: donViId,
      canBoId: canBoId,
      luaChonBietQuyetId: luaChonBietQuyetId,
      idPhienhopCanbo: idPhienhopCanbo,
    );
    final result = await hopRp.themMoiVote(themMoiVote);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.bieu_quyet_thanh_cong,
        );
        callApi(
          idCuocHop,
          checkIdPhienHop(
            idPhienHop,
          ),
        );
      },
      error: (err) {
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.bieu_quyet_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }

  Future<void> xoaBieuQuyet({
    required String bieuQuyetId,
    required String canboId,
  }) async {
    showLoading();
    final result = await hopRp.xoaBieuQuyet(bieuQuyetId, canboId);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.xoa_thanh_cong,
        );
        callApi(
          idCuocHop,
          checkIdPhienHop(
            idPhienHop,
          ),
        );
      },
      error: (err) {
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.xoa_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }

  bool compareTime(String timeBieuQuyet) {
    final timeNow = DateTime.now();
    final timePaser =
        DateFormat(DateTimeFormat.DATE_TIME_RECEIVE).parse(timeBieuQuyet);
    final dateBieuQuyetMillisec = timePaser.millisecondsSinceEpoch;
    final dateNowMillisec = timeNow.millisecondsSinceEpoch;
    if (dateBieuQuyetMillisec > dateNowMillisec) {
      return true;
    }
    return false;
  }

  bool compareEquaTime(String timeBatDau, String timeKetThuc) {
    final timeNow = DateTime.now();
    final timeBatDauPaser =
        DateFormat(DateTimeFormat.DATE_TIME_RECEIVE).parse(timeBatDau);
    final timeKetThucPaser =
        DateFormat(DateTimeFormat.DATE_TIME_RECEIVE).parse(timeKetThuc);
    final dateBieuQuyetMillisec = timeBatDauPaser.millisecondsSinceEpoch;
    final dateNowMillisec = timeNow.millisecondsSinceEpoch;
    final dateKetThucMillisec = timeKetThucPaser.millisecondsSinceEpoch;
    if (dateBieuQuyetMillisec <= dateNowMillisec &&
        dateKetThucMillisec >= dateNowMillisec) {
      return true;
    }
    return false;
  }

  Future<void> chiTietBieuQuyet({
    required String idBieuQuyet,
  }) async {
    showLoading();
    final result = await hopRp.chiTietBieuQuyet(idBieuQuyet);
    result.when(
      success: (res) {
        chiTietBieuQuyetModel = res;
        chiTietBieuQuyetSubject.sink.add(chiTietBieuQuyetModel);
        final dsChon = getListLuaChon(
          res.data?.dsLuaChon ?? [],
        );
        suaDanhSachLuaChon.sink.add(dsChon);
        listBieuQuyetSubject.sink.add(res.data?.dsThanhPhanThamGia ?? []);
        showContent();
      },
      error: (err) {},
    );
    danhSachLuaChon.clear();
  }

  Future<void> danhSachCanBoBieuQuyet({
    required String luaChonId,
    required String bieuQuyetId,
  }) async {
    showLoading();
    final result =
        await hopRp.danhSachCanBoBieuQuyet(luaChonId, idCuocHop, bieuQuyetId);
    result.when(
      success: (res) {
        danhSachCanBoBieuQuyetSubject.sink.add(
          res,
        );
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> suaBieuQuyet({
    required String idBieuQuyet,
    required String lichHopId,
    required bool loaiBieuQuyets,
    required String noiDung,
    required bool quyenBieuQuyet,
    required String thoiGianBatDau,
    required String thoiGianKetThuc,
    required List<DanhSachLuaChonNew> danhSachLuaChonNew,
    required List<dynamic> danhSachThanhPhanThamGia,
    required String ngayHop,
    required bool isPublish,
    required List<DsLuaChonOld> dsLuaChonOld,
    required List<ThanhPhanThamGiaOld> thanhPhanThamGiaOld,
    required String dateStart,
    required List<DanhSachThanhPhanThamGiaNew> danhSachThanhPhanThamGiaNew,
  }) async {
    showLoading();
    final SuaBieuQuyetRequest suaBieuQuyetRequest = SuaBieuQuyetRequest(
      id: idBieuQuyet,
      lichHopId: lichHopId,
      loaiBieuQuyet: loaiBieuQuyets,
      noiDung: noiDung,
      quyenBieuQuyet: quyenBieuQuyet,
      thoiGianBatDau: thoiGianBatDau,
      thoiGianKetThuc: thoiGianKetThuc,
      danhSachLuaChon: danhSachLuaChonNew,
      danhSachThanhPhanThamGia: danhSachThanhPhanThamGia,
      ngayHop: ngayHop,
      isPublish: isPublish,
      dsLuaChonOld: dsLuaChonOld,
      thanhPhanThamGiaOld: thanhPhanThamGiaOld,
      dateStart: dateStart,
      danhSachThanhPhanThamGiaNew: danhSachThanhPhanThamGiaNew,
    );
    final result = await hopRp.suaBieuQuyet(suaBieuQuyetRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.sua_thanh_cong,
        );
        callSuaAPiBieuQuyet();
      },
      error: (err) {
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.sua_that_bai,
            messState: MessState.error,
          );
        }
      },
    );

    showContent();
  }

  List<SuaDanhSachLuaChonModel> getListLuaChon(
    List<DanhSachLuaChonModel> mlist,
  ) {
    final data = mlist
        .map(
          (e) => SuaDanhSachLuaChonModel(
            id: e.luaChonId,
            tenLuaChon: e.tenLuaChon,
            mauBieuQuyet: PRIMARY,
          ),
        )
        .toList();
    return data;
  }

  void isCheckDiemDanh(List<CanBoModel> mList) {
    final idCanBo = HiveLocal.getDataUser()?.userId;
    final diemDanh = mList.firstWhere((element) => element.canBoId == idCanBo);
    isCheckDiemDanhSubject.sink.add(diemDanh);
  }

  void getTimeHour({required TimerData startT, required TimerData endT}) {
    final int hourStart = startT.hour;
    final int minuteStart = startT.minutes;
    final int hourEnd = endT.hour;
    final int minuteEnd = endT.minutes;
    startTime = '${hourStart.toString()}:${minuteStart.toString()}';
    endTime = '${hourEnd.toString()}:${minuteEnd.toString()}';
  }

  String checkLoaiBieuQuyet({bool loaiBieuQuyet = true}) {
    if (loaiBieuQuyet == true) {
      return S.current.bo_phieu_cong_khai;
    } else {
      return S.current.bo_khieu_kin;
    }
  }

  String dateTimeFormat(String date, String time) {
    return '$date' 'T' '$time:00';
  }

  Future<void> themBieuQuyetHop({
    required String id,
    required String tenBieuQuyet,
  }) async {
    showLoading();

    final BieuQuyetRequest bieuQuyetRequest = BieuQuyetRequest(
      dateStart: dateBieuQuyet,
      lichHopId: id,
      loaiBieuQuyet: loaiBieuQuyet,
      noiDung: tenBieuQuyet,
      quyenBieuQuyet: true,
      thoiGianBatDau: startTime,
      thoiGianKetThuc: endTime,
      trangThai: 0,
      danhSachLuaChon: cacLuaChonBieuQuyet
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: PRIMARY))
          .toList(),
      danhSachThanhPhanThamGia: [],
    );
    final result = await hopRp.themBieuQuyet(bieuQuyetRequest);

    result.when(
      success: (res) {
        showContent();
      },
      error: (err) {
        showError();
      },
    );
  }

  void clearData() {
    danhSachLuaChon = [];
    listThanhPhanThamGiaOld.clear();
    cacLuaChonBieuQuyet = [];
    listDanhSach.clear();
    isValidateSubject.sink.add(false);
    isValidateTimer.sink.add(false);
    danhSachLuaChonNew.clear();
  }

  void checkRadioButton(int _index) {
    checkRadioSubject.sink.add(_index);
    if (_index == 1) {
      loaiBieuQuyet = true;
    } else {
      loaiBieuQuyet = false;
    }
  }

  void clearDataTaoBieuQuyet() {
    cacLuaChonBieuQuyet = [];
    listDanhSach = [];
    isValidateSubject.sink.add(false);
    isValidateTimer.sink.add(false);
    listThemLuaChon.clear();
  }

  List<DsLuaChonOld> paserListLuaChon(List<DanhSachLuaChonModel> mlist) {
    final value = mlist
        .map(
          (e) => DsLuaChonOld(
            tenLuaChon: e.tenLuaChon,
            color: PRIMARY,
            dsCanBo: e.dsCanBo,
            count: e.count,
            luaChonId: e.luaChonId,
          ),
        )
        .toList();
    return value;
  }

  List<DanhSachLuaChonNew> paserListLuaChonNew(
    List<SuaDanhSachLuaChonModel> mlist,
  ) {
    final value = mlist
        .map(
          (e) => DanhSachLuaChonNew(
            tenLuaChon: e.tenLuaChon,
            mauBieuQuyet: e.mauBieuQuyet,
            id: e.id,
          ),
        )
        .toList();
    return value;
  }

  List<ThanhPhanThamGiaOld> paserThanhPhanThamGia(
    List<DanhSachThanhPhanThamGiaModel> mlist,
  ) {
    final value = mlist
        .map(
          (e) => ThanhPhanThamGiaOld(
            bieuQuyetId: e.bieuQuyetId,
            lichHopId: e.lichHopId,
            canBoId: e.canBoId,
            hoTen: e.hoTen,
            tenDonVi: e.tenDonVi,
            donViId: e.donViId,
            id: e.id,
          ),
        )
        .toList();
    return value;
  }

  List<DanhSachThanhPhanThamGiaNew> paserThanhPhanThamGiaNew(
    List<DanhSachNguoiThamGiaModel> mlist,
  ) {
    final value = mlist
        .map(
          (e) => DanhSachThanhPhanThamGiaNew(
            donViId: e.donViId,
            canBoId: e.canBoId,
            idPhienhopCanbo: e.id,
          ),
        )
        .toList();
    return value;
  }

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  List<SuaDanhSachLuaChonModel> paserListString(List<String> mlist) {
    final data = mlist
        .map(
          (e) => SuaDanhSachLuaChonModel(tenLuaChon: e, mauBieuQuyet: PRIMARY),
        )
        .toList();
    return data;
  }

  void addValueToListLuaChon(SuaDanhSachLuaChonModel value) {
    suaLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  Future<void> postThemBieuQuyetHop(
    String id,
    String noidung,
    String date,
    bool loaiBieuQuyet,
    String ngayBatDaus,
    String ngayKetThucs,
  ) async {
    await themBieuQuyetHopByLuc(
      dateStart: date,
      thoiGianBatDau: ngayBatDaus,
      thoiGianKetThuc: ngayKetThucs,
      loaiBieuQuyet: loaiBieuQuyet,
      danhSachLuaChon: listLuaChon
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: PRIMARY))
          .toList(),
      noiDung: noidung.trim(),
      lichHopId: id,
      trangThai: 0,
      quyenBieuQuyet: true,
      danhSachThanhPhanThamGia: listDanhSach
          .map(
            (e) => DanhSachThanhPhanThamGia(
              canBoId: e.canBoId,
              donViId: e.donViId,
              idPhienhopCanbo: e.id,
            ),
          )
          .toList(),
    );
  }

  Future<void> themBieuQuyetHopByLuc({
    required String? dateStart,
    required String? thoiGianBatDau,
    required String? thoiGianKetThuc,
    required bool? loaiBieuQuyet,
    required List<DanhSachLuaChon>? danhSachLuaChon,
    required String? noiDung,
    required String? lichHopId,
    required int? trangThai,
    required bool? quyenBieuQuyet,
    required List<DanhSachThanhPhanThamGia>? danhSachThanhPhanThamGia,
  }) async {
    final BieuQuyetRequest bieuQuyetRequest = BieuQuyetRequest(
      dateStart: dateStart,
      thoiGianBatDau: thoiGianBatDau,
      thoiGianKetThuc: thoiGianKetThuc,
      loaiBieuQuyet: loaiBieuQuyet,
      danhSachLuaChon: danhSachLuaChon,
      noiDung: noiDung,
      lichHopId: lichHopId,
      trangThai: trangThai,
      quyenBieuQuyet: quyenBieuQuyet,
      danhSachThanhPhanThamGia: danhSachThanhPhanThamGia,
    );
    showLoading();
    final result = await hopRp.themBieuQuyet(bieuQuyetRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.tao_bieu_quyet_thanh_cong,
        );
      },
      error: (err) {
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.tao_bieu_quyet_khong_thanh_cong,
            messState: MessState.error,
          );
        }
      },
    );
  }

  Future<void> callApi(String id, String? idPhienHop) async {
    await getDanhSachBieuQuyetLichHop(
      idLichHop: id,
      canBoId: HiveLocal.getDataUser()?.userId ?? '',
      idPhienHop: idPhienHop,
    );
  }

  String plusTaoBieuQuyet(String date, TimerData time) {
    final DateFormat dateFormat = DateFormat(DateTimeFormat.DEFAULT_FORMAT);
    final dateTime = dateFormat.parse(date);

    final times = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minutes,
    );
    return times.formatApiTaoBieuQuyet;
  }

  bool checkValidateBieuQuyet(String value) {
    if (value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///handle timer
  bool isNotStartYet({required DateTime startTime}) {
    if (DateTime.now().isBefore(startTime)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getDanhSachNTGChuongTrinhHop({
    required String id,
  }) async {
    final result = await hopRp.getDanhSachNTGChuongTrinhHop(id);

    result.when(
      success: (res) {
        listData = res;
        findIdPhienHop(listData);
        nguoiThamGiaSubject.sink.add(listData);
      },
      error: (error) {},
    );
  }

  void findIdPhienHop(List<DanhSachNguoiThamGiaModel> mList) {
    final userId = HiveLocal.getDataUser()?.userId ?? '';
    final id = listData.firstWhere(
      (element) => element.canBoId == userId,
      orElse: () {
        return DanhSachNguoiThamGiaModel();
      },
    ).id;
    idPhienHop = id ?? '';
  }

  String checkIdPhienHop(String? id) {
    if (id == ID_PHIEN_HOP) {
      return idPhienHop;
    } else {
      return id ?? idPhienHop;
    }
  }

  int coverTime(int time) {
    if (time < 10) {
      final String value = '0$time';
      final timeCover = int.parse(value);
      return timeCover;
    } else {
      return time;
    }
  }

  DateTime coverDate(String dates) {
    final date =
        DateFormat('dd/MM/yyyy').parse(dates).formatBieuQuyetChooseTime;
    final dateCover = DateTime.parse(date);
    return dateCover;
  }

  TimerData dateTimeNowStart() {
    final timeStart = getChiTietLichHopModel.timeStart;
    final timeBieuQuyet = DateFormat('HH:mm').parse(timeStart);
    final TimerData start = TimerData(
      hour: coverTime(timeBieuQuyet.hour),
      minutes: coverTime(timeBieuQuyet.minute),
    );
    return start;
  }

  TimerData dateTimeNowEnd() {
    final timeStart = getChiTietLichHopModel.timeTo;
    final timeBieuQuyet = DateFormat('HH:mm').parse(timeStart);
    final TimerData end = TimerData(
      hour: coverTime(timeBieuQuyet.hour),
      minutes: coverTime(timeBieuQuyet.minute),
    );
    return end;
  }

  String paserDateTime(String dateTime) {
    final date = DateFormat('MM/dd/yyy HH:mm:ss')
        .parse(dateTime)
        .formatBieuQuyetChooseTime;
    return date;
  }

  String dateTimeCovert(int time) {
    if (time < 10) {
      return '0$time';
    }
    return '$time';
  }

  Future<void> callAPiBieuQuyet() async {
    await getDanhSachNTGChuongTrinhHop(id: idCuocHop);
    await callApi(idCuocHop, idPhienHop);
  }

  Future<void> callSuaAPiBieuQuyet() async {
    await callApi(idCuocHop, idPhienHop);
  }

  String getTime({bool isGetDateStart = true}) {
    return isGetDateStart
        ? '${getChiTietLichHopModel.ngayBatDau.split(' ').first} '
            '${getChiTietLichHopModel.timeStart}'
        : '${getChiTietLichHopModel.ngayKetThuc.split(' ').first} '
            '${getChiTietLichHopModel.timeTo}';
  }
}
