import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:intl/intl.dart';

const _BINH_THUONG = 1;
const _DOT_XUAT = 2;

class ChiTietLichHopModel {
  bool bit_YeuCauDuyet = false;
  String id = '';
  String thoiGianKetThuc = '';
  String loaiLich = '';
  String linhVuc = '';
  bool isDuyetPhong = false;
  String noiDung = '';
  String title = '';
  String tenLinhVuc;
  String ngayBatDau;
  String ngayKetThuc;
  String timeStart;
  String timeTo;
  String createdBy;
  int status;
  String loaiHop;
  String? nguoiTao_str;
  int? mucDoHop;
  ChuTriModel chuTriModel;
  PhongHopMode phongHopMode;
  String typeScheduleId;
  List<file>? fileData;
  bool isTaoTaoBocBang;
  String canBoThamGiaStr;
  bool bit_HopTrucTuyen;
  bool bit_TrongDonVi;
  bool isAllDay;
  int? typeReminder;
  int? typeRepeat;
  String? dateRepeat;
  String? days;
  bool? isDuyetThietBi = false;
  bool? bit_PhongTrungTamDieuHanh;
  int? trangThaiDuyetKyThuat = -1;
  String? lichHop_PhienHopStr = '';

  ChiTietLichHopModel({
    this.id = '',
    this.loaiLich = '',
    this.linhVuc = '',
    this.noiDung = '',
    this.title = '',
    this.ngayBatDau = '',
    this.ngayKetThuc = '',
    this.timeStart = '',
    this.timeTo = '',
    this.tenLinhVuc = '',
    this.loaiHop = '',
    this.canBoThamGiaStr = '',
    this.thoiGianKetThuc = '',
    this.mucDoHop,
    this.status = 0,
    this.chuTriModel = const ChuTriModel(),
    this.phongHopMode = const PhongHopMode(),
    this.typeScheduleId = '',
    this.bit_HopTrucTuyen = false,
    this.bit_TrongDonVi = false,
    this.isAllDay = false,
    this.typeReminder,
    this.typeRepeat,
    this.fileData,
    this.isDuyetPhong = false,
    this.dateRepeat,
    this.bit_YeuCauDuyet = false,
    this.days,
    this.isTaoTaoBocBang = false,
    this.createdBy = '',
    this.isDuyetThietBi = false,
    this.bit_PhongTrungTamDieuHanh = false,
    this.trangThaiDuyetKyThuat = -1,
    this.nguoiTao_str = '',
    this.lichHop_PhienHopStr,
  });

  String mucDoHopWithInt() {
    switch (mucDoHop) {
      case 1:
        return 'Bình thường';
      case 2:
        return 'Đột xuất';
    }
    return '';
  }

  String nhacLai() {
    switch (typeReminder) {
      case 1:
        return 'Không bao giờ';
      case 0:
        return 'Sau khi tạo lịch';
      case 5:
        return 'Trước 5 phút';
      case 10:
        return 'Trước 10 phút';
      case 15:
        return 'Trước 15 phút';
      case 30:
        return 'Trước 30 phút';
      case 60:
        return 'Trước 1 giờ';
      case 120:
        return 'Trước 2 giờ';
      case 720:
        return 'Trước 12 giờ';
      case 1140:
        return 'Trước 1 ngày';
      case 10080:
        return 'Trước 1 tuần';
    }
    return '';
  }

  String lichLap() {
    switch (typeRepeat) {
      case 1:
        return 'Không lặp lại';
      case 2:
        return 'Lặp lại hàng ngày';
      case 3:
        return 'Thứ 2 đến thứ 6 hàng tuần';
      case 4:
        return 'Lặp lại hàng tuần';
      case 5:
        return 'Lặp lại hàng tháng';
      case 6:
        return 'Lặp lại hàng năm';
      case 7:
        return 'Tùy chỉnh';
    }
    return '';
  }

  List<ChiTietDataRow> valueData() {
    if (isMobile()) {
      return _valueDateMobile();
    }
    return _valueDateTablet();
  }

  List<ChiTietDataRow> _valueDateTablet() {
    final DateFormat dateFormat = DateFormat(DateTimeFormat.DATE_MM_DD_YYYY);
    final List<ChiTietDataRow> data = [];
    if (loaiHop.isNotEmpty) {
      data.add(ChiTietDataRow(urlIcon: ImageAssets.icMucDoHop, text: loaiHop));
    }
    if (mucDoHop != null) {
      data.add(
          ChiTietDataRow(urlIcon: ImageAssets.icMucDoHop, text: _mucDoHop()));
    }
    if (dateFormat.parse(ngayBatDau).toStringWithListFormat ==
        dateFormat.parse(ngayKetThuc).toStringWithListFormat) {
      final timeStartFormat = DateFormat.jm().parse(timeStart).toStringWithAMPM;
      final timeEnd = DateFormat.jm().parse(timeTo).toStringWithAMPM;
      data.add(
        ChiTietDataRow(
          urlIcon: ImageAssets.icClock,
          text: '$timeStartFormat - $timeEnd',
        ),
      );
      final dateTime = dateFormat.parse(ngayKetThuc);
      final String calendar =
          '${dateTime.getDayofWeekTxt()}, ${dateTime.toStringWithListFormat}';
      data.add(ChiTietDataRow(
          urlIcon: ImageAssets.icCanlendarTablet, text: calendar));
    } else {
      final startDate = dateFormat.parse(ngayBatDau);
      final endDate = dateFormat.parse(ngayKetThuc);
      final startCalendar = '${startDate.toStringWithListFormat} $timeStart';
      final endCalendar = '${endDate.toStringWithListFormat} $timeTo';
      data.add(
        ChiTietDataRow(
          urlIcon: ImageAssets.icCalendar,
          text: '$startCalendar - $endCalendar',
        ),
      );
    }

    if (linhVuc.isNotEmpty) {
      data.add(ChiTietDataRow(urlIcon: ImageAssets.icWork, text: linhVuc));
    }
    if (phongHopMode.ten.isNotEmpty) {
      data.add(
        ChiTietDataRow(urlIcon: ImageAssets.icAddress, text: phongHopMode.ten),
      );
    }

    data.add(
      ChiTietDataRow(
        urlIcon: ImageAssets.icPeople,
        text: '${chuTriModel.tenCanBo} - ${chuTriModel.tenCoQuan}',
      ),
    );
    data.add(ChiTietDataRow(urlIcon: ImageAssets.icDocument, text: noiDung));
    return data;
  }

  List<ChiTietDataRow> _valueDateMobile() {
    final DateFormat dateFormat = DateFormat(DateTimeFormat.DATE_MM_DD_YYYY);
    final List<ChiTietDataRow> data = [];
    if (dateFormat.parse(ngayBatDau).toStringWithListFormat ==
        dateFormat.parse(ngayKetThuc).toStringWithListFormat) {
      final timeStartFormat = DateFormat.jm().parse(timeStart).toStringWithAMPM;
      final timeEnd = DateFormat.jm().parse(timeTo).toStringWithAMPM;
      data.add(
        ChiTietDataRow(
          urlIcon: ImageAssets.icClock,
          text: '$timeStartFormat - $timeEnd',
        ),
      );
      final dateTime = dateFormat.parse(ngayKetThuc);
      final String calendar =
          '${dateTime.day} ${S.current.thang} ${dateTime.month},${dateTime.year}';
      data.add(ChiTietDataRow(urlIcon: ImageAssets.icCalendar, text: calendar));
    } else {
      final startDate = dateFormat.parse(ngayBatDau);
      final endDate = dateFormat.parse(ngayKetThuc);
      final startCalendar = '${startDate.toStringWithListFormat} $timeStart';
      final endCalendar = '${endDate.toStringWithListFormat} $timeTo';
      data.add(
        ChiTietDataRow(
          urlIcon: ImageAssets.icCalendar,
          text: '$startCalendar - $endCalendar',
        ),
      );
    }
    if (loaiHop.isNotEmpty) {
      data.add(ChiTietDataRow(urlIcon: ImageAssets.icMucDoHop, text: loaiHop));
    }
    if (linhVuc.isNotEmpty) {
      data.add(ChiTietDataRow(urlIcon: ImageAssets.icWork, text: linhVuc));
    }
    if (mucDoHop != null) {
      data.add(
          ChiTietDataRow(urlIcon: ImageAssets.icMucDoHop, text: _mucDoHop()));
    }
    if (phongHopMode.ten.isNotEmpty) {
      data.add(
        ChiTietDataRow(urlIcon: ImageAssets.icAddress, text: phongHopMode.ten),
      );
    }

    data.add(
      ChiTietDataRow(
        urlIcon: ImageAssets.icPeople,
        text: '${chuTriModel.tenCanBo} - ${chuTriModel.tenCoQuan}',
      ),
    );
    data.add(ChiTietDataRow(urlIcon: ImageAssets.icDocument, text: noiDung));
    return data;
  }

  String _mucDoHop() {
    switch (mucDoHop) {
      case _BINH_THUONG:
        return S.current.binh_thuong;
      case _DOT_XUAT:
        return S.current.dot_xuat;
    }
    return S.current.binh_thuong;
  }
}

class ChuTriModel {
  final String canBoId;
  final String dauMoiLienHe;
  final String donViId;
  final String email;
  final String id;
  final String tenCoQuan;
  final String tenCanBo;
  final String soDienThoai;

  const ChuTriModel({
    this.id = '',
    this.tenCoQuan = '',
    this.tenCanBo = '',
    this.dauMoiLienHe = '',
    this.soDienThoai = '',
    this.canBoId = '',
    this.donViId = '',
    this.email = '',
  });

  String data() {
    return '$tenCanBo - $tenCoQuan';
  }
}

class PhongHopMode {
  final String id;
  final String ten;

  const PhongHopMode({this.id = '', this.ten = ''});
}

class ChiTietDataRow {
  final String urlIcon;
  final String text;

  ChiTietDataRow({required this.urlIcon, required this.text});
}

class file {
  final String? createdAt;

  final String? createdBy;
  final String? entityId;
  final String? entityId_DM;
  final String? entityName;
  final int? entityType;
  final String? extension;
  final String? id;
  final bool? isPrivate;
  final String? name;
  final String? path;
  final double? size;
  final String? updatedAt;
  final String? updatedBy;

  file(
      {this.createdAt,
      this.createdBy,
      this.entityId,
      this.entityId_DM,
      this.entityName,
      this.entityType,
      this.extension,
      this.id,
      this.isPrivate,
      this.name,
      this.path,
      this.size,
      this.updatedAt,
      this.updatedBy});
}
