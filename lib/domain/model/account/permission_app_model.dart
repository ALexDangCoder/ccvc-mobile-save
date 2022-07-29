import 'package:hive/hive.dart';

part 'permission_app_model.g.dart';

@HiveType(typeId: 5)
class PermissionApp {
  @HiveField(0)
  List<PermissionModel> qLVB;
  @HiveField(1)
  List<PermissionModel> pAKN;
  @HiveField(2)
  List<PermissionModel> vPDT;
  @HiveField(3)
  List<PermissionModel> qLNV;
  @HiveField(4)
  List<PermissionModel> hTCS;
  @HiveField(5)
  List<PermissionModel> hTKT;

  PermissionApp({
    required this.qLVB,
    required this.pAKN,
    required this.vPDT,
    required this.qLNV,
    required this.hTCS,
    required this.hTKT,
  });
}

@HiveType(typeId: 6)
class PermissionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  PermissionModel({this.id = '', this.name = ''});
}
