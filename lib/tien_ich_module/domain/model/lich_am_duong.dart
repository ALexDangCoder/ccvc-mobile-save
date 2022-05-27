import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';

const String IC_CHUOT = 'Tý';
const String IC_SUU = 'Sửu';
const String IC_DAN = 'Dần';
const String IC_MAO = 'Mão';
const String IC_THIN = 'Thìn';
const String IC_TY = 'Tỵ';
const String IC_NGO = 'Ngọ';
const String IC_MUI = 'Mùi';
const String IC_THAN = 'Thân';
const String IC_DAU = 'Dậu';
const String IC_TUAT = 'Tuất';
const String IC_HOI = 'Hợi';

class LichAmDuong {
  List<GioHoangDao>? gioHoangDao;
  List<GioHacDao>? gioHacDao;
  NgayAmLich? ngayAmLich;
  String? ngayAmLicgStr;
  String? tietKhi;
  NguHanh? nguHanh;
  String? truc;
  List<ChiTietTruc>? chiTietTruc;
  String? thu;
  List<TuoiXungTheoNgay>? tuoiXungTheoNgay;
  List<TuoiXungTheoThang>? tuoiXungTheoThang;
  List<NgayBachKy>? ngayBachKy;
  ThapNhiBatTu? thapNhiBatTu;
  ThapNhiKienTru? thapNhiKienTru;
  List<SaoTot>? saoTot;
  List<SaoXau>? saoXau;
  List<GioLyThuanPhong>? gioLyThuanPhong;

  LichAmDuong({
    this.gioHoangDao,
    this.gioHacDao,
    this.ngayAmLich,
    this.ngayAmLicgStr,
    this.tietKhi,
    this.nguHanh,
    this.truc,
    this.chiTietTruc,
    this.thu,
    this.tuoiXungTheoNgay,
    this.tuoiXungTheoThang,
    this.ngayBachKy,
    this.thapNhiBatTu,
    this.thapNhiKienTru,
    this.saoTot,
    this.saoXau,
    this.gioLyThuanPhong,
  });
}

class GioHoangDao {
  String? ten;
  String? gio;

  GioHoangDao({
    this.ten,
    this.gio,
  });

  String toIcon() {
    switch (ten?.trim()) {
      case IC_CHUOT:
        return ImageAssets.icChuot;
      case IC_SUU:
        return ImageAssets.icSuu;
      case IC_DAN:
        return ImageAssets.icDan;
      case IC_MAO:
        return ImageAssets.icMao;
      case IC_THIN:
        return ImageAssets.icThin;
      case IC_TY:
        return ImageAssets.icTy;
      case IC_NGO:
        return ImageAssets.icNgo;
      case IC_MUI:
        return ImageAssets.icMui;
      case IC_THAN:
        return ImageAssets.icThan;
      case IC_DAU:
        return ImageAssets.icDau;
      case IC_TUAT:
        return ImageAssets.icTuat;
      case IC_HOI:
        return ImageAssets.icHoi;
    }
    return ImageAssets.icChuot;
  }
}

class GioHacDao {
  String? ten;
  String? gio;

  GioHacDao({
    this.ten,
    this.gio,
  });

  String toIcon() {
    switch (ten?.trim()) {
      case IC_CHUOT:
        return ImageAssets.icChuot;
      case IC_SUU:
        return ImageAssets.icSuu;
      case IC_DAN:
        return ImageAssets.icDan;
      case IC_MAO:
        return ImageAssets.icMao;
      case IC_THIN:
        return ImageAssets.icThin;
      case IC_TY:
        return ImageAssets.icTy;
      case IC_NGO:
        return ImageAssets.icNgo;
      case IC_MUI:
        return ImageAssets.icMui;
      case IC_THAN:
        return ImageAssets.icThan;
      case IC_DAU:
        return ImageAssets.icDau;
      case IC_TUAT:
        return ImageAssets.icTuat;
      case IC_HOI:
        return ImageAssets.icHoi;
    }
    return ImageAssets.icChuot;
  }
}

class NgayAmLich {
  int? year;
  int? month;
  bool? isLeapMonth;
  int? day;
  String? solarDate;
  bool? isTermBeginThisDay;
  int? solarTermIndex;
  String? yearName;
  String? monthName;
  String? monthShortName;
  String? monthLongName;
  String? monthFullName;
  String? dayName;
  String? solarTerm;
  String? fullDayInfo;

  NgayAmLich({
    this.year,
    this.month,
    this.isLeapMonth,
    this.day,
    this.solarDate,
    this.isTermBeginThisDay,
    this.solarTermIndex,
    this.yearName,
    this.monthName,
    this.monthShortName,
    this.monthLongName,
    this.monthFullName,
    this.dayName,
    this.solarTerm,
    this.fullDayInfo,
  });
}

class NguHanh {
  String? hanh;
  String? sao;
  String? truc;
  String? mota;
  int? kieuNgay;

  NguHanh({
    this.hanh,
    this.sao,
    this.truc,
    this.mota,
    this.kieuNgay,
  });
}

class ChiTietTruc {
  String? nenLam;
  String? khongNenLam;
  String? thongTinThem;

  ChiTietTruc({
    this.nenLam,
    this.khongNenLam,
    this.thongTinThem,
  });
}

class TuoiXungTheoNgay {
  String? tenTuoi;
  String? nguHanh;
  String? chi;

  TuoiXungTheoNgay({
    this.tenTuoi,
    this.nguHanh,
    this.chi,
  });

  String toIcon() {
    switch (chi?.trim()) {
      case IC_CHUOT:
        return ImageAssets.icChuot;
      case IC_SUU:
        return ImageAssets.icSuu;
      case IC_DAN:
        return ImageAssets.icDan;
      case IC_MAO:
        return ImageAssets.icMao;
      case IC_THIN:
        return ImageAssets.icThin;
      case IC_TY:
        return ImageAssets.icTy;
      case IC_NGO:
        return ImageAssets.icNgo;
      case IC_MUI:
        return ImageAssets.icMui;
      case IC_THAN:
        return ImageAssets.icThan;
      case IC_DAU:
        return ImageAssets.icDau;
      case IC_TUAT:
        return ImageAssets.icTuat;
      case IC_HOI:
        return ImageAssets.icHoi;
    }
    return ImageAssets.icChuot;
  }
}

class TuoiXungTheoThang {
  String? tenTuoi;
  String? nguHanh;
  String? chi;

  TuoiXungTheoThang({
    this.tenTuoi,
    this.nguHanh,
    this.chi,
  });

  String toIcon() {
    switch (chi?.trim()) {
      case IC_CHUOT:
        return ImageAssets.icChuot;
      case IC_SUU:
        return ImageAssets.icSuu;
      case IC_DAN:
        return ImageAssets.icDan;
      case IC_MAO:
        return ImageAssets.icMao;
      case IC_THIN:
        return ImageAssets.icThin;
      case IC_TY:
        return ImageAssets.icTy;
      case IC_NGO:
        return ImageAssets.icNgo;
      case IC_MUI:
        return ImageAssets.icMui;
      case IC_THAN:
        return ImageAssets.icThan;
      case IC_DAU:
        return ImageAssets.icDau;
      case IC_TUAT:
        return ImageAssets.icTuat;
      case IC_HOI:
        return ImageAssets.icHoi;
    }
    return ImageAssets.icChuot;
  }
}

class NgayBachKy {
  String? ten;
  String? moTa;
  String? totXau;

  NgayBachKy({
    this.ten,
    this.moTa,
    this.totXau,
  });
}

class ThapNhiBatTu {
  String? tinhMoc;
  String? totXau;
  String? nenLam;
  String? kieng;
  String? ngoaiLe;

  ThapNhiBatTu({
    this.tinhMoc,
    this.totXau,
    this.nenLam,
    this.kieng,
    this.ngoaiLe,
  });
}

class ThapNhiKienTru {
  String? truc;
  String? nenLam;
  String? khongNenLam;

  ThapNhiKienTru({
    this.truc,
    this.nenLam,
    this.khongNenLam,
  });
}

class SaoTot {
  String? tenSao;
  String? thongTin;

  SaoTot({
    this.tenSao,
    this.thongTin,
  });
}

class SaoXau {
  String? tenSao;
  String? thongTin;

  SaoXau({
    this.tenSao,
    this.thongTin,
  });
}

class GioLyThuanPhong {
  String? ten;
  String? moTa;

  GioLyThuanPhong({
    this.ten,
    this.moTa,
  });
}
