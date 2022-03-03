import 'package:json_annotation/json_annotation.dart';

part 'dash_board_tat_ca_chu_de_resquest.g.dart';

@JsonSerializable()
class DashBoardTatCaChuDeRequest {
  int pageIndex;
  int pageSize;
  int total;
  bool hasNextPage;
  String fromDate;
  String toDate;

  DashBoardTatCaChuDeRequest(
      {required this.pageIndex,
      required this.pageSize,
      required this.total,
      required this.hasNextPage,
      required this.fromDate,
      required this.toDate,});
}
