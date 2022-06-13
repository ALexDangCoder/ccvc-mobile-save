import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';

///Biẻu quyết
extension BieuQuyet on DetailMeetCalenderCubit {
  // danh sach bieu quyet
  Future<void> getDanhSachBieuQuyetLichHop({
    String? idLichHop,
    String? canBoId,
    String? idPhienHop,
  }) async {
    final result = await hopRp.getDanhSachBieuQuyetLichHop(
      idLichHop ?? '',
      canBoId ?? '',
      idPhienHop ?? '',
    );
    result.when(
      success: (res) {
        streamBieuQuyet.sink.add(res);
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
      String id, String noidung, String date) async {
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
      loaiBieuQuyet: loaiBieuQ,
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
    final result = await hopRp.themBieuQuyet(bieuQuyetRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.tao_thanh_cong,
        );
      },
      error: (err) {
        if (err is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.tao_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }
}
