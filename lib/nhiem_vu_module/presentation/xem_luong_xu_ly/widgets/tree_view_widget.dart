
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/widgets/tree_view/GraphView.dart';
import 'package:flutter/material.dart';

class TreeViewWidget<T> extends StatefulWidget {
  final NodePhanXuLy<T> tree;
  final Widget Function(dynamic) builder;
  final bool scaleEnable;

  const TreeViewWidget(
      {Key? key,
      required this.tree,
      required this.builder,
      this.scaleEnable = true})
      : super(key: key);

  @override
  _TreeViewWidgetState createState() => _TreeViewWidgetState<T>();
}

class _TreeViewWidgetState<T> extends State<TreeViewWidget> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  TransformationController controller = TransformationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makeBuildTree(widget.tree);
    builder
      ..siblingSeparation = (70)
      ..levelSeparation = (70)
      ..subtreeSeparation = (70)
      ..orientation = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InteractiveViewer(
              constrained: false,
              scaleEnabled: widget.scaleEnable,
              transformationController: controller,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.001,
              maxScale: 3,
              child: widget.tree.children.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: widget.builder(widget.tree),
                    )
                  : GraphView(
                      graph: graph,
                      algorithm: BuchheimWalkerAlgorithm(
                          builder, TreeEdgeRenderer(builder)),
                      paint: Paint()
                        ..color = const Color(0xffA2AEBD)
                        ..strokeWidth = 1
                        ..style = PaintingStyle.stroke
                        ..strokeCap = StrokeCap.round,
                      builder: (Node node) {
                        // I can decide what widget should be shown here based on the id
                        var value = node.key!.value as NodePhanXuLy<T>;
                        return widget.builder(value);
                      },
                    )),
        ),
      ],
    );
  }

  void _makeBuildTree<T>(NodePhanXuLy<T> node) {
    if (node.children.isNotEmpty) {
      for (var element in node.children) {
        final tree = element as NodePhanXuLy<T>;
        NodePhanXuLy<T>? parent;

        if (node.parent != null) {
          parent = tree;
        } else {
          parent = tree.parent as NodePhanXuLy<T>;
        }
        graph.addEdge(Node.Id(node), Node.Id(tree));
        _makeBuildTree(element);
      }
    }
  }
}
