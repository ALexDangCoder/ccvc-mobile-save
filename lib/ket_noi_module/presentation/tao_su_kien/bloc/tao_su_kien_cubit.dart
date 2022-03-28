import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/data/request/tao_su_kien_resquest.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/repository/ket_noi_repository.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/bloc/tao_su_kien_state.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/dialog/dialog.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TaoSuKienCubit extends BaseCubit<TaoSuKienState> {
  TaoSuKienCubit() : super(MainStateInitial());

  KetNoiRepository get repo => Get.find();

  BehaviorSubject<List<String>> loaiBaiVietSubject = BehaviorSubject.seeded([]);
  List<LoaiBaiVietModel> listData = [];
  List<Childrens> checkType = [];
  LoaiBaiVietModel loaiBaiVietModel = LoaiBaiVietModel();
  String type = 'KET-NOI';
  String tenSuKien = '';
  List<String> loaiBaiViet = [];
  String themNguoi = '';
  String thoiGian = '';
  String diaDiem = '';
  String tel = '';
  String viber = '';
  String emeeting = '';
  String zoom = '';
  String noiDung = '';

  void callApi() {
    getLoaiBaiViet(type: type);
  }

  void callApis() {
    postTaoSuKien(
      loaiBaiViet: loaiBaiViet.join(','),
      tieuDe: tenSuKien,
      ngayBatDau: thoiGian,
      diaDiem: diaDiem,
      coXuatBan: false,
      noiDung: noiDung,
      thongTinLienHe: {
        'tel': tel,
        'viber': viber,
        'emeeting': viber,
        'zoom': zoom
      },
      type: type,
    );
  }

  List<String> listName = [];
  String name = '';
  List<Childrens> listTitleItemMenu = [];
  List<Childrens> listTitleItemMenu2 = [];

  Future<void> getLoaiBaiViet({
    required String type,
  }) async {
    showLoading();
    final result = await repo.loaiBaiViet(type);
    result.when(
      success: (res) {
        listData = res;
        for (final i in listData) {
          if (i.alias == 'su-kien') {
            for (final j in i.childrens ?? []) {
              listName.add(j.title);
              name = listName.first;
            }
          } else {
            listTitleItemMenu2.addAll(res.first.childrens ?? []);
          }
        }
        loaiBaiVietSubject.sink.add(listName);
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
    final TaoSuKienRequest taoSuKienRequest = TaoSuKienRequest(
      loaiBaiViet: loaiBaiViet,
      tieuDe: tieuDe,
      ngayBatDau: ngayBatDau,
      diaDiem: diaDiem,
      coXuatBan: coXuatBan,
      noiDung: noiDung,
      thongTinLienHe: thongTinLienHe,
      type: type,
    );
    final result = await repo.postTaoSuKien(taoSuKienRequest);
    result.when(
      success: (res) {
        MessageConfig.show(title: S.current.tao_thanh_cong);
      },
      error: (error) {
        MessageConfig.show(title: S.current.tao_that_bai);
      },
    );
  }
}
