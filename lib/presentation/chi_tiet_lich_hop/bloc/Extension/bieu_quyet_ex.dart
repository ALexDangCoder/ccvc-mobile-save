import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
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
        streamBieuQuyet.sink.add(res);
        showContent();
      },
      error: (err) {},
    );
  }

  void getTimeHour({required TimerData startT, required TimerData endT}) {
    final int hourStart = startT.hour;
    final int minuteStart = startT.minutes;
    final int hourEnd = endT.hour;
    final int minuteEnd = endT.minutes;
    startTime = '${hourStart.toString()}:${minuteStart.toString()}';
    endTime = '${hourEnd.toString()}:${minuteEnd.toString()}';
  }

  Future<void> themBieuQuyetHop(
      {required String id, required String tenBieuQuyet}) async {
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
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: 'primary'))
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

  void getDate(String value) {
    dateBieuQuyet = value;
  }

  void checkRadioButton(int _index) {
    checkRadioSubject.sink.add(_index);
    if (_index == 1) {
      loaiBieuQuyet = true;
    } else {
      loaiBieuQuyet = false;
    }
  }

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  Future<void> postThemBieuQuyetHop(
      String id, String noidung, String date, bool loaiBieuQuyet) async {
    await themBieuQuyetHopByLuc(
      dateStart: date,
      thoiGianBatDau: plusTaoBieuQuyet(
        date,
        start,
      ),
      thoiGianKetThuc: plusTaoBieuQuyet(
        date,
        end,
      ),
      loaiBieuQuyet: loaiBieuQuyet,
      danhSachLuaChon: listLuaChon
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: 'primary'))
          .toList(),
      noiDung: noidung,
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
    showLoading();
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
    showContent();
  }

  Future<void> callApi(String id) async {
    await getDanhSachBieuQuyetLichHop(
      idLichHop: id,
      canBoId: HiveLocal.getDataUser()?.userId ?? '',
      idPhienHop: '',
    );
  }

  String plusTaoBieuQuyet(String date, TimerData time) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
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
        nguoiThamGiaSubject.sink.add(listData);
      },
      error: (error) {},
    );
  }

  TimerData dateTimeNowStart() {
    final TimerData start = TimerData(
      hour: timeNow.hour,
      minutes: timeNow.minute,
    );
    return start;
  }

  TimerData dateTimeNowEnd() {
    final TimerData end = TimerData(
      hour: timeNow.add(const Duration(hours: 1)).hour,
      minutes: timeNow.minute,
    );
    return end;
  }

  String dateTimeCovert(int time) {
    if (time < 10) {
      return '0$time';
    }
    return '$time';
  }

  Future<void> callAPiBieuQuyet() async {
    await getDanhSachNTGChuongTrinhHop(id: idCuocHop);
    await callApi(idCuocHop);
  }
}
