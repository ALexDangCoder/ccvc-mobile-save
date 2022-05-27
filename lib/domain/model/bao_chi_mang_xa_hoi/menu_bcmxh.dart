class ListMenuItemModel {
  String id;
  int nodeid;
  String title;
  List<MenuItemModel> subMenu;

  ListMenuItemModel({
    required this.id,
    required this.title,
    required this.nodeid,
    required this.subMenu,
  });
}

class MenuItemModel {
  String id;
  int nodeId;
  String title;

  MenuItemModel({required this.id, required this.nodeId, required this.title});
}

class MenuData {
  int nodeId;
  String title;

  MenuData({
    required this.nodeId,
    required this.title,
  });
}
