class NodePhanXuLy<T> {
  // 2.
  late T value;
  NodePhanXuLy? parent;
  bool isSelected = false;
  int level = 1;
  bool isExpand = false;
  bool isExpandSearch = false;

  // 3.
  List<NodePhanXuLy> children = [];

  NodePhanXuLy.init(NodePhanXuLy node) {
    value = node.value;
    parent = node.parent;
    children = node.children;
    isSelected = node.isSelected;
    level = 1;
    if (parent == null) {
      isExpand = true;
    }
  }

  // 4.
  NodePhanXuLy(T _value) {
    value = _value;
  }

  // 5.
  void addChild(NodePhanXuLy child) {
    child.level = level + 1;
    children.add(child);
    child.parent = this;
  }
}
