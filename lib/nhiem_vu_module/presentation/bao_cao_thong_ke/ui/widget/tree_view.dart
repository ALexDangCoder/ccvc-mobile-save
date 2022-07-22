import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/custom_checkbox.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TreeViewWidgetNhiemVu extends StatefulWidget {
  final Node<DonViModel> node;
  final ThemDonViCubit themDonViCubit;
  final bool selectOnly;
  final Function(DonViModel)? onSelect;

  const TreeViewWidgetNhiemVu({
    Key? key,
    required this.themDonViCubit,
    required this.node,
    this.selectOnly = false,
    this.onSelect,
  }) : super(key: key);

  @override
  _TreeWidgetState createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeViewWidgetNhiemVu> {
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
                    if (widget.selectOnly)
                      StreamBuilder<Node<DonViModel>?>(
                        stream: widget.themDonViCubit.selectOnlyDonVi,
                        builder: (context, snapshot) {
                          return CustomCheckBox(
                            onChange: (isCheck) {
                              widget.themDonViCubit.selectNodeOnly(widget.node);
                              if (widget.onSelect != null) {
                                widget.onSelect!(widget.node.value);
                              }
                            },
                            isCheck:
                            snapshot.data?.value.id == widget.node.value.id,
                          );
                        },
                      )
                    else
                      CustomCheckBox(
                        onChange: (isCheck) {
                          widget.node.isCheck.isCheck = !isCheck;
                          if (isCheck) {
                            ///TODO call API getUser and add to list share
                            ///TODO all children checkbox is true
                          } else {}
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
                          if (widget.node.children.isEmpty) {
                            /// TODO call API
                            widget.node.isCheck.isCheck =
                            !widget.node.isCheck.isCheck;
                            setState(() {});
                            widget.themDonViCubit.addSelectNode(
                              widget.node,
                              isCheck: widget.node.isCheck.isCheck,
                            );
                          } else {
                            widget.node.expand = !widget.node.expand;
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title(),
                                  style:
                                  textNormal(textTitle, 14.0.textScale()),
                                ),
                              ),
                              if (widget.node.children.isNotEmpty)
                                Transform.rotate(
                                  angle: widget.node.expand ? 0 : 3.1,
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(widget.node.children.length, (index) {
              final node = widget.node.children[index];
              return TreeViewWidgetNhiemVu(
                selectOnly: widget.selectOnly,
                themDonViCubit: widget.themDonViCubit,
                node: node,
                onSelect: widget.onSelect,
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
