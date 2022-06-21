import 'package:json_annotation/json_annotation.dart';

part 'users_ngoai_he_thong_truy_cap_request.g.dart';

@JsonSerializable()
class UsersNgoaiHeThongRequest {
  String pageIndex;
  String pageSize;
  String keyword;

  UsersNgoaiHeThongRequest({
    required this.pageIndex,
    required this.pageSize,
    required this.keyword,
  });
}
