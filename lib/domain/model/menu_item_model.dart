class MenuItemSchedule {
  final String key;
  final String menuTitle;
  final int badgeNumber;
  List<ChildrenMenuItem> children;

  MenuItemSchedule({
    required this.key,
    required this.menuTitle,
    required this.badgeNumber,
    required this.children,
  });
}

class ChildrenMenuItem {
  final bool isSelected;
  final String title;
  final int number;

  // List<ChildrenMenuItem> children;

  ChildrenMenuItem({
    required this.isSelected,
    required this.title,
    required this.number,
    // required this.children,
  });
}
