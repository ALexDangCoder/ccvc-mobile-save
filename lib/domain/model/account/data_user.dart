import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:hive/hive.dart';

part 'data_user.g.dart';

class DataLogin {
  DataUser? dataUser;
  bool? succeeded;
  int? statusCode;

  DataLogin({
    required this.dataUser,
    required this.succeeded,
    required this.statusCode,
  });
}

@HiveType(typeId: 0)
class DataUser {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  UserInformation? userInformation;
  String? accessToken;
  String? refreshToken;

  DataUser({
    this.username,
    this.userId,
    this.userInformation,
    this.accessToken,
    this.refreshToken,
  });
}
