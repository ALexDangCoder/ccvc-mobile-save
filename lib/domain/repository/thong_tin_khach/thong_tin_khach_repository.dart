import 'dart:io';
import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/tao_thong_tin_khach_model.dart';

mixin ThongTinKhachRepository {
  Future<Result<TaoThongTinKhachModel>> taoThongTinKhach(
      TaoThongTinKhachRequest taoThongTinKhachRequest);

  Future<Result<CheckIdCardModel>> checkIdCard({
   required String? accept,
   required String? clientID,
   required String? clientSecret,
   required List<File> front_image,
   required List<File>back_image,}
  );
}
