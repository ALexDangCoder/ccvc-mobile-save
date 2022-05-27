import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/topic_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/bloc/huong_dan_su_dung_state.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class HuongDanSuDungCubit extends BaseCubit<HuongDanSuDungState> {
  HuongDanSuDungCubit() : super(MainStateInitial());

  TienIchRepository get tienIchRep => Get.find();

  BehaviorSubject<List<TopicHDSD>> topicHDSDSubject = BehaviorSubject();

  Stream<List<TopicHDSD>> get getTopicHDSDStream => topicHDSDSubject.stream;

  //danh sach all
  List<DanhSachTitleHDSD> dataDanhSachTitleHDSD = [];

  BehaviorSubject<List<DanhSachTitleHDSD>> danhSachTitleHDSDSubject =
      BehaviorSubject();

  Stream<List<DanhSachTitleHDSD>> get getDanhSachTitleHDSDStream =>
      danhSachTitleHDSDSubject.stream;

  //danh sach detail
  List<DanhSachTitleHDSD> danhSachTitleHDSDDetail = [];
  BehaviorSubject<List<DanhSachTitleHDSD>> danhSachTitleHDSDDetailSubject =
      BehaviorSubject();

  Stream<List<DanhSachTitleHDSD>> get getDanhSachTitleDetailHDSDStream =>
      danhSachTitleHDSDDetailSubject.stream;

  final BehaviorSubject<bool> selectSearch = BehaviorSubject.seeded(false);

  Stream<bool> get selectSearchStream => selectSearch.stream;

  BehaviorSubject<DetailHuongDanSuDung> detailHuongDanSuDungSubject =
      BehaviorSubject();
  DetailHuongDanSuDung detailHuongDanSuDung = DetailHuongDanSuDung();

  Stream<DetailHuongDanSuDung> get getDetailHuongDanSuDungStream =>
      detailHuongDanSuDungSubject.stream;

  void setSelectSearch(bool data) {
    selectSearch.sink.add(data);
  }

  Future<void> loadData() async {
    final queue = Queue(parallel: 2);
    unawaited(queue.add(() => getTopicHDSD()));
    unawaited(queue.add(() => getDanhSachHDSD()));

    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> getTopicHDSD() async {
    final result = await tienIchRep.getTopicHDSD();
    result.when(
      success: (res) {
        topicHDSDSubject.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getDanhSachHDSD() async {
    final result = await tienIchRep.getDanhSachHDSD(1, 1000, '', '', '');
    result.when(
      success: (res) {
        dataDanhSachTitleHDSD = res.pageData ?? [];
        danhSachTitleHDSDSubject.add(dataDanhSachTitleHDSD);
      },
      error: (error) {},
    );
  }

  Future<void> getDanhSachHDSDDetail(String idTopic) async {
    showLoading();
    final result = await tienIchRep.getDanhSachHDSD(1, 1000, idTopic, '', '');
    result.when(
      success: (res) {
        danhSachTitleHDSDDetail = res.pageData ?? [];
        danhSachTitleHDSDDetailSubject.add(danhSachTitleHDSDDetail);
        showContent();
      },
      error: (error) {},
    );
  }

  Future<void> getDetailDanhSachHuongDanSuDung(String id) async {
    showLoading();
    final result = await tienIchRep.getDetailHuongDanSuDung(id);
    result.when(
      success: (res) {
        detailHuongDanSuDung = res;
        detailHuongDanSuDungSubject.add(detailHuongDanSuDung);
        showContent();
      },
      error: (error) {},
    );
  }

  void searchAllDanhSach(String values) {
    final searchTxt = values.trim().toLowerCase().vietNameseParse();
    bool isListDanhSach(DanhSachTitleHDSD titleHDSD) {
      return titleHDSD.title!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value =
        dataDanhSachTitleHDSD.where((event) => isListDanhSach(event)).toList();
    danhSachTitleHDSDSubject.add(value);
  }

  void searchDanhSachDetail(String values) {
    final searchTxt = values.trim().toLowerCase().vietNameseParse();
    bool isListDanhSach(DanhSachTitleHDSD titleHDSD) {
      return titleHDSD.title!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value = danhSachTitleHDSDDetail
        .where((event) => isListDanhSach(event))
        .toList();
    danhSachTitleHDSDDetailSubject.add(value);
  }
}
