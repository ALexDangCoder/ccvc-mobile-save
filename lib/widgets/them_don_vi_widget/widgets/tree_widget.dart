import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TreeViewWidget extends StatefulWidget {
  final Node<DonViModel> node;
  final ThemDonViCubit themDonViCubit;
  const TreeViewWidget({
    Key? key,
    required this.themDonViCubit,
    required this.node,
  }) : super(key: key);

  @override
  _TreeWidgetState createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 32.0 * widget.node.level.toDouble(),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomCheckBox(
                      title: '',
                      onChange: (isCheck) {
                        widget.node.isCheck.isCheck = !isCheck;
                        setState(() {});
                        widget.themDonViCubit.addSelectNode(
                          widget.node,
                          isCheck: widget.node.isCheck.isCheck,
                        );
                      },
                      isCheck: widget.node.isCheck.isCheck,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          widget.node.expand = !widget.node.expand;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title(),
                                  style: textNormal(textTitle, 14),
                                ),
                              ),
                              if (widget.node.children.isNotEmpty)
                                Transform.rotate(
                                  angle: widget.node.expand ? 0 : 1.6,
                                  child: SvgPicture.asset(
                                    ImageAssets.icDropDownButton,
                                  ),
                                )
                              else
                                const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.node.children.isNotEmpty && widget.node.expand)
          Column(
            children: List.generate(widget.node.children.length, (index) {
              final node = widget.node.children[index];
              return TreeViewWidget(
                themDonViCubit: widget.themDonViCubit,
                node: node,
              );
            }),
          )
        else
          const SizedBox()
      ],
    );
  }

  String title() {
    if (widget.node.children.isNotEmpty) {
      return '${widget.node.value.name} (${widget.node.children.length})';
    }
    return widget.node.value.name;
  }
}
