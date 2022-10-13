import 'package:json_annotation/json_annotation.dart';

part 'tao_thong_tin_khach_request.g.dart';

@JsonSerializable()
class TaoThongTinKhachRequest {
  final int? birth;
  final String? cardId;
  final String? department;
  // final String? document;
  final String? homeTown;
  final String? name;
  final String? no;
  final String? place;
  final String? reason;
  final String? receptionPerson;
  final String? sex;
  final String? typeDoc;

  TaoThongTinKhachRequest({
    required this.birth,
    required this.cardId,
    required this.department,
    // required this.document,
    required this.homeTown,
    required this.name,
    required this.no,
    required this.place,
    required this.reason,
    required this.receptionPerson,
    required this.sex,
    required this.typeDoc,
  });

  factory TaoThongTinKhachRequest.fromJson(Map<String, dynamic> json) =>
      _$TaoThongTinKhachRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoThongTinKhachRequestToJson(this);
}
