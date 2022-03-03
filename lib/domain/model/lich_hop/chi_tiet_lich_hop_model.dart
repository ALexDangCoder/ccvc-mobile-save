import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:intl/intl.dart';

const _BINH_THUONG = 1;
const _DOT_XUAT = 2;

class ChiTietLichHopModel {
  String id = '';

  String loaiLich = '';

  String linhVuc = '';

  String noiDung = '';
  String title = '';
  String tenLinhVuc;
  String ngayBatDau;
  String ngayKetThuc;
  String timeStart;
  String timeTo;
  String loaiHop;
  int? mucDoHop;
  ChuTriModel chuTriModel;
  PhongHopMode phongHopMode;
  String typeScheduleId;
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
    this.mucDoHop,
    this.chuTriModel = const ChuTriModel(),
    this.phongHopMode = const PhongHopMode(),
    this.typeScheduleId = '',
  });
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
        text: '${chuTriModel.tenCanBo} - ${chuTriModel.tenChucVu}',
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
        text: '${chuTriModel.tenCanBo} - ${chuTriModel.tenChucVu}',
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
  final String id;
  final String tenChucVu;
  final String tenCanBo;
  final String dauMoiLienHe;
  final String soDienThoai;
  const ChuTriModel(
      {this.id = '',
      this.tenChucVu = '',
      this.tenCanBo = '',
      this.dauMoiLienHe = '',
      this.soDienThoai = ''});
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
