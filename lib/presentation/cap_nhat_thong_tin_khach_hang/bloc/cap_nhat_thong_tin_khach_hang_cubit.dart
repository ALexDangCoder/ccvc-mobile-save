import 'dart:io';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/domain/model/cap_nhat_thong_tin_khach/LoaiTheModel.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_tin_khach/thong_tin_khach_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/bloc/cap_nhat_tong_tin_khach_hang_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class CapNhatThongTinKhachHangCubit
    extends BaseCubit<CapNhatThongTinKhachHangState> {
  CapNhatThongTinKhachHangCubit()
      : super(
          CapNhatThongTinKhachHangStateIntial(),
        );
  List<File> filePickImageFrontend = [];
  List<File> filePickImageBackEnd = [];
  BehaviorSubject<CheckIdCardModel> checkIdCardModelsubject = BehaviorSubject();

  ThongTinKhachRepository get _thongTinKhach => Get.find();
  BehaviorSubject<List<LoaiTheModel>> loaiTheSubject = BehaviorSubject.seeded([
    LoaiTheModel(ten: S.current.chung_minh_nhan_dan),
    LoaiTheModel(ten: S.current.can_cuoc_cong_dan),
  ]);
  List<String> dataGioiTinh = [
    'Nam',
    'Nữ',
  ];
  String loaiThe = 'CMT';
  String gioitinh = '1';
  int ngaySinh = DateTime.now().millisecondsSinceEpoch;
  void initState(){
    showContent();
  }

  Future<void> postThongTinKhach({
    required String? soCMT,
    required String? coQuanToChuc,
    required String? document,
    required String? homeTown,
    required String? hoVaTen,
    required String? idTheVao,
    required String? residence,
    required String? lyDoVaoCoQuan,
    required String? nguoiTiepDon,
    required BuildContext context,
  }) async {
    showLoading();
    TaoThongTinKhachRequest taoThongTinKhachRequest = TaoThongTinKhachRequest(
      birth: ngaySinh,
      cardId: soCMT ?? ''.trim(),
      department: coQuanToChuc ?? ''.trim(),
      document: document??''.trim(),
      homeTown: homeTown ?? ''.trim(),
      name: hoVaTen ?? ''.trim(),
      no: idTheVao ?? ''.trim(),
      place: residence ?? ''.trim(),
      reason: lyDoVaoCoQuan ?? ''.trim(),
      receptionPerson: nguoiTiepDon ?? ''.trim(),
      sex: gioitinh.trim(),
      typeDoc: loaiThe.trim(),
    );
    final result =
        await _thongTinKhach.taoThongTinKhach(taoThongTinKhachRequest);
    result.when(
        success: (res) {
          showContent();
          MessageConfig.show(
            title: res.desc??S.current.thanh_cong,
          );
          Navigator.pop(context);
        },
        error: (error) {
          if (error is NoNetworkException || error is TimeoutException) {
            MessageConfig.show(
              title: S.current.no_internet,
              messState: MessState.error,
            );
          }
        });
  }

  Future<bool?> postCheckIdCard(BuildContext context) async {
    showLoading();
    final result = await _thongTinKhach.checkIdCard(
      accept: 'application/json',
      clientID: '27ff5a35-1d34-4811-bd2f-1a28505ea7a4',
      clientSecret: 'Wpo13R61OL9zMSlocxoa0vusMt78hEh8XIAHe7VtQrQ',
      back_image: filePickImageFrontend,
      front_image: filePickImageBackEnd,
    );
    bool? isShowPopUp;
    result.when(
      success: (res) {
        showContent();
        if ((res.backContent?.statusCode == StatusMpiddth.OK) &&
            ((res.frontContent?.statusCode == StatusMpiddth.OK))) {
          checkIdCardModelsubject.sink.add(res);
          isShowPopUp = false;
        } else {
          isShowPopUp = true;
        }
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
      },
    );
    return isShowPopUp;
  }
}
