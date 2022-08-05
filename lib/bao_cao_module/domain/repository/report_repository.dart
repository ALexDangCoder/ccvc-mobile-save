import 'package:ccvc_mobile/bao_cao_module/data/request/new_member_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_detail_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/source_detail_model.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

mixin ReportRepository {
  Future<Result<List<ReportItem>>> getListReport(
    String folderId,
    int sort,
    String keyWord,
    String appID,
      bool isShare,
  );

  Future<Result<List<NhomCungHeThong>>> getListGroup(
    String appId, {
    String? groupName,
  });

  Future<Result<List<ThanhVien>>> getListThanhVien(
    String groupId,
  );

  Future<Result<String>> addNewMember(
    NewUserRequest mapMember,
    String appId,
  );

  Future<Result<ReportItem>> getFolderID(
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
    String folderId,
    int sort,
  );

  Future<Result<String>> shareReport(
    List<ShareReport> mapMember,
    String idReport,
    String appId,
  );

  Future<Result<List<UserNgoaiHeThongDuocTruyCapModel>>>
      getUsersNgoaiHeThongTruyCap(
    String appId,
    int pageIndex,
    int pageSize,
    String keyword,
    int status,
    bool isLock,
  );

  Future<Result<ReportDetailModel>> getReportDetail(
    String appId,
    String idReport,
  );

  Future<Result<List<Node<DonViModel>>>> getUserPaging({
    required String donViId,
    required String appId,
    String hoTen = '',
    bool isGetAll = false,
    int pageIndex = 1,
    int pageSize = 9999,
  });
  Future<Result<SourceDetail>> getSourceShareDetail({
    required String idReport,
    required String appId,
  });
}
