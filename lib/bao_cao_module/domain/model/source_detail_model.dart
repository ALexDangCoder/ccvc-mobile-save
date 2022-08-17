class SourceDetail {
  String? id;
  String? createdAt;
  String? createdBy;
  String? createdByName;
  String? updatedAt;
  String? updatedBy;
  String? updatedByName;
  String? parentId;
  String? parentName;
  String? name;
  String? description;
  int? type;
  List<GroupAccesses>? groupAccesses;
  List<UserCommons>? userCommons;
  List<UnitAccesses>? unitAccesses;
  List<UserInThisSystems>? userInThisSystems;

  SourceDetail({
    this.id,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
    this.parentId,
    this.parentName,
    this.name,
    this.description,
    this.type,
    this.groupAccesses,
    this.userCommons,
    this.userInThisSystems,
    this.unitAccesses,
  });
}

class GroupAccesses {
  String? groupId;
  String? name;
  String? code;

  GroupAccesses({
    this.groupId,
    this.name,
    this.code,
  });
}

class UserCommons {
  String? userId;
  String? username;
  String? fullname;

  UserCommons({
    this.userId,
    this.username,
    this.fullname,
  });
}

class UnitAccesses {
  int? countUser;
  String donViId;
  String? name;

  UnitAccesses({
    this.countUser,
    required this.donViId,
    this.name,
  });
}

class UserInThisSystems {
  String? email;
  int? status;
  String? userId;

  UserInThisSystems({
    this.email,
    this.status,
    this.userId,
  });
}
