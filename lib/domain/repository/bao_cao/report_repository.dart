import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/folder_model.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';

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

  Future<Result<List<UserNgoaiHeThongDuocTruyCapModel>>>
      getUsersNgoaiHeThongTruyCap(
    String pageIndex,
    String pageSize,
    String keyword,
  );
    String groupId,
  );

  Future<Result<FolderModel>> getFolderID(
    String appID,
  );

  Future<Result<bool>> postLikeReportFavorite(
    List<String> idReport,
    String appID,
  );

  Future<Result<bool>> putDislikeReportFavorite(
    List<String> idReport,
    String appID,
  );

  Future<Result<List<ReportItem>>> getListReportFavorite(
    String appId,
  );

  Future<Result<List<FolderModel>>> getListReportTree(
    String appId,
    String folderId,
  );
}
