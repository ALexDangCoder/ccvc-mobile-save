import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/folder_model.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';

mixin ReportRepository {
  Future<Result<List<ReportItem>>> getListReport(
    String folderId,
    int sort,
    String keyWord,
    String appID,
  );

  Future<Result<List<NhomCungHeThong>>> getListGroup();

  Future<Result<List<ThanhVien>>> getListThanhVien(
    String groupId,
  );

  Future<Result<FolderModel>> getFolderID(
    String appID,
  );

  Future<Result<bool>> postLikeReportFavorite(
    List<String> idReport,
  );

  Future<Result<bool>> putDislikeReportFavorite(
    List<String> idReport,
  );
}
