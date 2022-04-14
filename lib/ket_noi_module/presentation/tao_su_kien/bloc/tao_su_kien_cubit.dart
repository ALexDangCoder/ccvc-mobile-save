import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/repository/ket_noi_repository.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/bloc/tao_su_kien_state.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/extensions/date_time_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TaoSuKienCubit extends BaseCubit<TaoSuKienState> {
  TaoSuKienCubit() : super(MainStateInitial());

  KetNoiRepository get repo => Get.find();

  BehaviorSubject<List<LoaiBaiVietModel>> loaiBaiVietSubject =
      BehaviorSubject.seeded([]);
  List<LoaiBaiVietModel> listData = [];
  LoaiBaiVietModel? loaiBaiVietModel;
  String type = 'KET-NOI';
  String tenSuKien = '';
  List<String> loaiBaiViet = [];
  String themNguoi = '';
  String? thoiGian;
  String diaDiem = '';
  String tel = '';
  String viber = '';
  String emeeting = '';
  String zoom = '';
  String noiDung = '';

  void callApi() {
    getLoaiBaiViet(type: type);
  }

  List<String> listName(List<LoaiBaiVietModel> data) {
    final List<String> listData = [];
    for (final i in data) {
      listData.add(i.id ?? '');
    }
    loaiBaiViet = listData;
    return loaiBaiViet;
  }

  Future callApis() async {
    await postTaoSuKien(
      loaiBaiViet: loaiBaiViet.join(','),
      tieuDe: tenSuKien,
      ngayBatDau: thoiGian ?? DateTime.now().formatApiSS,
      diaDiem: diaDiem,
      coXuatBan: false,
      noiDung: noiDung,
      thongTinLienHe: {
        'tel': tel,
        'viber': viber,
        'emeeting': emeeting,
        'zoom': zoom
      },
      type: type,
    );
  }

  Future<void> getLoaiBaiViet({
    required String type,
  }) async {
    showLoading();
    final result = await repo.loaiBaiViet(type);
    result.when(
      success: (res) {
        listData.clear();
        listData.addAll(res);
        loaiBaiVietSubject.sink.add(res.first.childrens ?? []);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> postTaoSuKien({
    required String loaiBaiViet,
    required String tieuDe,
    required String ngayBatDau,
    required String diaDiem,
    required bool coXuatBan,
    required String noiDung,
    required Map<String, String> thongTinLienHe,
    required String type,
  }) async {
    final result = await repo.postTaoSuKien(
      loaiBaiViet,
      tieuDe,
      ngayBatDau,
      diaDiem,
      coXuatBan,
      noiDung,
      thongTinLienHe,
      type,
    );
    result.when(
      success: (res) {},
      error: (error) {},
    );
  }
}
