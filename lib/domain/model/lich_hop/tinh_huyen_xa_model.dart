class DaTaTinhSelectModel {
  List<TinhSelectModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DaTaTinhSelectModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class TinhSelectModel {
  String? id;
  String? ma;
  String? tenTinhThanh;
  int? totalItems;

  TinhSelectModel({
    this.id,
    this.ma,
    this.tenTinhThanh,
    this.totalItems,
  });

  TinhSelectModel.seeded({
    this.id = '',
    this.ma = '',
    this.tenTinhThanh = '',
  });
}

class DaTaHuyenSelectModel {
  List<HuyenSelectModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DaTaHuyenSelectModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class HuyenSelectModel {
  String? id;
  String? tinhId;
  String? ma;
  String? tenQuanHuyen;
  int? totalItems;

  HuyenSelectModel({
    this.id,
    this.tinhId,
    this.ma,
    this.tenQuanHuyen,
    this.totalItems,
  });

  HuyenSelectModel.seeded({
    this.id = '',
    this.ma = '',
    this.tenQuanHuyen = '',
  });
}

class DaTaXaSelectModel {
  List<WardModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DaTaXaSelectModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class WardModel {
  String? id;
  String? huyenId;
  String? ma;
  String? tenXaPhuong;
  int? totalItems;

  WardModel({
    this.id,
    this.huyenId,
    this.ma,
    this.tenXaPhuong,
    this.totalItems,
  });

  WardModel.seeded({
    this.id = '',
    this.ma = '',
    this.tenXaPhuong = '',
  });
}

class DataDatNuocSelectModel {
  List<DatNuocSelectModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DataDatNuocSelectModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class DatNuocSelectModel {
  String? id;
  String? name;
  int? totalItems;

  DatNuocSelectModel({
    this.id,
    this.name,
    this.totalItems,
  });
}
