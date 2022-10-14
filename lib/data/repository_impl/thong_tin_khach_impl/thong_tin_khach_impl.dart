import 'dart:io';

import 'package:ccvc_mobile/data/response/thong_tin_khach/check_id_card_response.dart';
import 'package:ccvc_mobile/data/response/thong_tin_khach/tao_thong_tin_khach_response.dart';
import 'package:ccvc_mobile/data/services/thong_tin_khach/thong_tin_khach_service.dart';
import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/tao_thong_tin_khach_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_tin_khach/thong_tin_khach_repository.dart';

class ThongTinKhachImpl implements ThongTinKhachRepository {
  final ThongTinKhachService _thongTinKhachService;
  final ThongTinKhachServiceLocal _thongTinKhachServiceLocal;

  ThongTinKhachImpl(
      this._thongTinKhachService, this._thongTinKhachServiceLocal);

  @override
  Future<Result<TaoThongTinKhachModel>> taoThongTinKhach(
      TaoThongTinKhachRequest taoThongTinKhachRequest) {
    return runCatchingAsync<DataTaoThongTinKhachResponse,
        TaoThongTinKhachModel>(
      () => _thongTinKhachService.postThongTinKhach(taoThongTinKhachRequest),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<CheckIdCardModel>> checkIdCard({
   required String? accept,
   required String? clientID,
   required String? clientSecret,
   required List<File> front_image,
   required List<File> back_image,
  }) {
    return runCatchingAsync<CheckIdCardResponse, CheckIdCardModel>(
      () => _thongTinKhachServiceLocal.postCheckIdCard(
          accept, clientID, clientSecret, front_image, back_image),
      (res) => res.toModel(),
    );
  }
}
