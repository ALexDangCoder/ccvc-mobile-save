import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/danh_sach_nhiem_vu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/cong_tac_chuan_bi_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/th%C3%A0nh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/fake_data.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'datai_meet_calender_state.dart';
import 'package:file_picker/file_picker.dart';

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  BehaviorSubject<ChiTietLichLamViecModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  Stream<ChiTietLichLamViecModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;

  final BehaviorSubject<bool> subjectStreamCheck = BehaviorSubject();

  List<String> selectedIds = [];

  void initData() {
    ChiTietLichLamViecModel fakeData = ChiTietLichLamViecModel(
        id: '123',
        time: '11:30 AM - 12:00 AM',
        date: '8 tháng 12,2021',
        loaiLich: '11:30 AM - 12:00 AM',
        listPerSon: fakeDataListPerson(),
        nhacLai: '10 phút sau',
        chuTri: 'Lê Sĩ Lâm - Văn thư',
        linhVuc: 'Xúc tiến thương mại',
        diaDiem: 'UBND huyện',
        noiDung: 'Kế hoạch năm 2022 phát triển công ty');

    chiTietLichLamViecSubject.add(fakeData);
  }

  ListPerSon fakeDataListPerson() {
    ListPerSon fakeDataListPersona = ListPerSon(
        tongSoNguoi: 8,
        soNguoiDongY: 3,
        soNguoiChoXacNhan: 5,
        listPerson: listFake);
    return fakeDataListPersona;
  }

  List<Person> listFake = [
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
  ];

  BehaviorSubject<KetLuanHopModel> ketLuanHopSubject =
      BehaviorSubject.seeded(ketLuanHop);

  BehaviorSubject<DetailDocumentModel> detailDocumentSubject =
      BehaviorSubject<DetailDocumentModel>();

  Stream<KetLuanHopModel> get ketLuanHopStream => ketLuanHopSubject.stream;

  Stream<DetailDocumentModel> get streamDetaiMission =>
      detailDocumentSubject.stream;

  BehaviorSubject<DetailDocumentProfileSend> detailDocumentGuiNhan =
      BehaviorSubject<DetailDocumentProfileSend>();

  Stream<DetailDocumentProfileSend> get streamDetaiGuiNhan =>
      detailDocumentGuiNhan.stream;

  BehaviorSubject<List<ThanhPhanThamGiaModel>> thanhPhanThamGia =
      BehaviorSubject<List<ThanhPhanThamGiaModel>>();

  Stream<List<ThanhPhanThamGiaModel>> get streamthanhPhanThamGia =>
      thanhPhanThamGia.stream;

  BehaviorSubject<List<PhatBieuModel>> phatbieu =
      BehaviorSubject<List<PhatBieuModel>>();

  Stream<List<PhatBieuModel>> get streamPhatBieu => phatbieu.stream;

  BehaviorSubject<DanhSachNhiemVuLichHopModel> danhSachNhiemVuLichHopSubject =
      BehaviorSubject.seeded(danhSachNhiemVuLichHopModel);

  Stream<DanhSachNhiemVuLichHopModel> get streamDanhSachNhiemVuLichHop =>
      danhSachNhiemVuLichHopSubject.stream;

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
  }

  final BehaviorSubject<String> _themBieuQuyet = BehaviorSubject<String>();

  Stream<String> get themBieuQuyet => _themBieuQuyet.stream;
  List<String> cacLuaChonBieuQuyet = [];

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  final BehaviorSubject<HistoryProcessPage> _subjectJobPriliesProcess =
      BehaviorSubject<HistoryProcessPage>();

  HistoryProcessPage? process;

  List<HistoryDetailDocument> get listHistory =>
      process == null ? [] : process!.listDetailDocumentHistory;

  Stream<HistoryProcessPage> get screenJobProfilesStream =>
      _subjectJobPriliesProcess.stream;

  List<String> properties = [];
  bool check = false;
  DetailDocumentModel detailDocumentModel = DetailDocumentModel(
    soVanBan: 'M123',
    soDen: 'M123',
    trichYeu: 'Chưa có',
    daNhanBanGiay: true,
    doKhan: 'Bình thường',
    hanXL: '21/07/2021',
    hoiBao: true,
    loaiVanBan: 'Giấy mời',
    ngayBH: '21/07/2021',
    ngayDen: '21/07/2021',
    ngayHanXL: '21/07/2021',
    nguoiKy: 'Hà Kiều Anh',
    noiGui: 'Ban An toàn giao thông - TPHCM',
    phuongThucNhan: 'Điện tử',
    soBan: 200,
    soPhu: 'M123',
    soKyHieu: 'M123',
    soTrang: 56,
    vanBanQlPL: true,
  );

  DetailDocumentProfileSend thongTinGuiNhan = DetailDocumentProfileSend(
    nguoiGui: 'Văn thu bọ',
    donViGui: 'UBND Đồng Nai',
    donViNhan: 'UBND Đồng Nai',
    trangThai: 'Chờ vào sổ',
    nguoiNhan: 'Hà Kiều Anh',
    thoiGian: '10/09/2021 | 17:06:53',
    vaiTro: 'Chủ trì',
  );

  CongTacChuanBiModel thongTinPhong = CongTacChuanBiModel(
    tenPhong: 'Phòng họp',
    sucChua: '3',
    diaDiem: 'UBND Đồng Nai',
    trangThai: 'Đã duyệt',
    loaiThietBi: 'Máy chiếu',
  );

  CongTacChuanBiModel thongTinYeuCauThietBi = CongTacChuanBiModel(
    tenPhong: '',
    sucChua: '20',
    diaDiem: '',
    trangThai: 'Chờ duyệt',
    loaiThietBi: 'Máy chiếu',
  );

  ThanhPhanThamGiaModel thanhPhanThamGiaModel = ThanhPhanThamGiaModel(
    tebCanBo: 'Lê Sĩ Lâm',
    trangThai: 'Chờ xác nhận',
    diemDanh: 'Có mặt',
    tenDonVi: 'Lãnh đạo UBND Tỉnh Đồng Nai',
    ndCongViec: 'Họp nội bộ',
    vaiTro: 'Cán bộ chủ trì',
    statusDiemDanh: false,
  );
  PhatBieuModel phatBieu = PhatBieuModel(
    tthoiGian: '5/11/2021  9:10:03 PM',
    nguoiPhatBieu: 'Lê Sĩ Lâm',
    ndPhatBieu: 'Cán bộ chủ trì',
    phienHop: 'Lãnh đạo UBND Tỉnh Đồng Nai',
  );

  // List<DetailDocumentModel> thongTinGuiNhan = [];

  List<String> listIdFile = [];
  List<String> listIdFileReComment = [];

  void removeFileIndex(int index, bool isReComment) {
    if (isReComment) {
      listIdFileReComment.removeAt(index);
    } else {
      listIdFile.removeAt(index);
    }
  }

  List<ThanhPhanThamGiaModel> listFakeThanhPhanThamGiaModel = [
    ThanhPhanThamGiaModel(
      id: '0',
      tebCanBo: 'Lê Sĩ Lâm',
      trangThai: 'Chờ xác nhận',
      diemDanh: 'Có mặt',
      tenDonVi: 'Lãnh đạo UBND Tỉnh Đồng Nai',
      ndCongViec: 'Họp nội bộ',
      vaiTro: 'Cán bộ chủ trì',
      statusDiemDanh: false,
    ),
    ThanhPhanThamGiaModel(
      id: '1',
      tebCanBo: 'Lê Sĩ Lâm2',
      trangThai: 'Chờ xác nhận',
      diemDanh: 'Có mặt',
      tenDonVi: 'Lãnh đạo UBND Tỉnh Đồng Nai',
      ndCongViec: 'Họp nội bộ',
      vaiTro: 'Cán bộ chủ trì',
      statusDiemDanh: false,
    ),
    ThanhPhanThamGiaModel(
      id: '2',
      tebCanBo: 'vu thi tuyet',
      trangThai: 'xác nhận',
      diemDanh: 'Có mặt',
      tenDonVi: 'Lãnh đạo UBND Tỉnh Đồng Nai',
      ndCongViec: 'Họp nội bộ',
      vaiTro: 'Cán bộ chủ trì',
      statusDiemDanh: false,
    ),
  ];

  List<PhatBieuModel> listPhatBieu = [
    PhatBieuModel(
      tthoiGian: '5/11/2021  9:10:03 PM',
      nguoiPhatBieu: 'Lê Sĩ Lâm',
      ndPhatBieu: 'Cán bộ chủ trì',
      phienHop: 'Lãnh đạo UBND Tỉnh Đồng Nai',
    ),
    PhatBieuModel(
      tthoiGian: '5/11/2021  9:10:03 PM',
      nguoiPhatBieu: 'Lê Sĩ Lâm',
      ndPhatBieu: 'Cán bộ chủ trì',
      phienHop: 'Lãnh đạo UBND Tỉnh Đồng Nai',
    ),
    PhatBieuModel(
      tthoiGian: '5/11/2021  9:10:03 PM',
      nguoiPhatBieu: 'Lê Sĩ Lâm',
      ndPhatBieu: 'Cán bộ chủ trì',
      phienHop: 'Lãnh đạo UBND Tỉnh Đồng Nai',
    ),
  ];

  DetailDocumentModel info = DetailDocumentModel.fromDetail();

  Future<void> uploadFileDocument(
      List<PlatformFile> files, bool isReComment) async {
    // service.uploadFileDocument(listFile: files).then((response) {
    //   final listFile = response.data ?? [];
    //   if (isReComment) {
    //     for (var i = 0; i < listFile.length; i++) {
    //       listIdFileReComment.add(listFile[i]);
    //     }
    //   } else {
    //     for (var i = 0; i < listFile.length; i++) {
    //       listIdFile.add(listFile[i]);
    //     }
    //   }
    // });
  }

  List<ThanhPhanThamGiaModel> timKiem = [];

  void search(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(ThanhPhanThamGiaModel canBo) {
      return canBo.tebCanBo!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value = listFakeThanhPhanThamGiaModel
        .where((element) => isListCanBo(element))
        .toList();
    thanhPhanThamGia.sink.add(value);
  }

  final httpClient = HttpClient();

  Future<File> _downloadFile(String url, String filename) async {
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> openFile(String url) async {
    // var filePath = r'/storage/emulated/0/update.apk';
    var filePath = url;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
    } else {
      // User canceled the picker
    }
    // final _result = await OpenFile.open(filePath);
  }

  final BehaviorSubject<bool> checkBoxCheck = BehaviorSubject();

  Stream<bool> get checkBoxCheckBool => checkBoxCheck.stream;

  void checkBoxButton() {
    checkBoxCheck.sink.add(check);
  }

  final BehaviorSubject<String> typeStatus =
      BehaviorSubject.seeded(S.current.danh_sach_phat_bieu);

  Stream<String> get getTypeStatus => typeStatus.stream;

  void getValueStatus(String value) {
    if (value == S.current.danh_sach_phat_bieu) {
      phatbieu.sink.add(listPhatBieu);
    } else if (value == S.current.cho_duyet) {
      phatbieu.sink.add(listPhatBieu);
    } else if (value == S.current.da_duyet){
      phatbieu.sink.add(listPhatBieu);
    } else {
      phatbieu.sink.add(listPhatBieu);
    }
    phatbieu.sink.add(listPhatBieu);
    typeStatus.sink.add(value);
    print(value);
  }
  void dispose() {}
}
