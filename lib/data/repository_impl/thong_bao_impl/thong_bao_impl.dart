import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_quan_trong_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/thong_bao_service/thong_bao_service.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';

class ThongBaoImpl implements ThongBaoRepository {
  ThongBaoService service;

  ThongBaoImpl(this.service);

  @override
  Future<Result<List<ThongBaoModel>>> getNotifyAppcodes() {
    return runCatchingAsync<ThongBaoResponse, List<ThongBaoModel>>(
      () => service.getNotifyAppcodes(),
      (res) => res.data.map((e) => e.toModel()).toList(),
    );
  }

  @override
  Future<Result<ThongBaoQuanTrongModel>> getThongBaoQuanTrong({
    required String appCode,
    required bool active,
    required int seen,
    required int currentPage,
    required int pageSize,
  }) {
    return runCatchingAsync<ThongBaoQuanTrongResponse, ThongBaoQuanTrongModel>(
      () => service.getThongBaoQuanTrong(
        appCode,
        active,
        seen,
        currentPage,
        pageSize,
      ),
      (res) => res.data.toModel(),
    );
  }

  @override
  Future<Result<MessageModel>> deleteNotify(String id) {
    return runCatchingAsync<TaoLichLamViecResponse, MessageModel>(
      () => service.deleteNotify(
        id,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> readAllNoti(String appCode) {
    return runCatchingAsync<ChinhSuaBaoCaoKetQuaResponse, MessageModel>(
      () => service.readAllNoti(appCode),
      (res) => res.toDomain(),
    );
  }
}
