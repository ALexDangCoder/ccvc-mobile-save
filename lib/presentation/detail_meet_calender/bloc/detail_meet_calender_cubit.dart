import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/fake_data.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'datai_meet_calender_state.dart';
import 'package:file_picker/file_picker.dart';

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

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

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();
  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
  }

  // BehaviorSubject<HistoryDetailDocument> detailDocumentHistorySubject =
  // BehaviorSubject<HistoryDetailDocument>();
  //
  // Stream<HistoryDetailDocument> get streamDetailHistorySubject =>
  //     detailDocumentHistorySubject.stream;

  final BehaviorSubject<HistoryProcessPage> _subjectJobPriliesProcess =
      BehaviorSubject<HistoryProcessPage>();

  HistoryProcessPage? process;

  List<HistoryDetailDocument> get listHistory =>
      process == null ? [] : process!.listDetailDocumentHistory;

  Stream<HistoryProcessPage> get screenJobProfilesStream =>
      _subjectJobPriliesProcess.stream;


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
      vanBanQlPL: true);

  DetailDocumentProfileSend thongTinGuiNhan = DetailDocumentProfileSend(
      nguoiGui: 'Văn thu bọ',
      donViGui: 'UBND Đồng Nai',
      donViNhan: 'UBND Đồng Nai',
      trangThai: 'Chờ vào sổ',
      nguoiNhan: 'Hà Kiều Anh',
      thoiGian: '10/09/2021 | 17:06:53',
      vaiTro: 'Chủ trì');

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

  void dispose() {}
}
