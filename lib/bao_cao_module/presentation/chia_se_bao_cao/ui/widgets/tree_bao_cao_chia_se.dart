import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/custom_checkbox.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TreeViewChiaSeBaoCaoWidget extends StatefulWidget {
  final Node<DonViModel> node;
  final ChiaSeBaoCaoCubit themDonViCubit;
  final bool selectOnly;

  const TreeViewChiaSeBaoCaoWidget({
    Key? key,
    required this.themDonViCubit,
    required this.node,
    this.selectOnly = false,
  }) : super(key: key);

  @override
  _TreeWidgetState createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeViewChiaSeBaoCaoWidget> {
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
                    StreamBuilder<bool>(
                        stream: widget.themDonViCubit.selectDonViStream,
                        builder: (context, snapshot) {
                          return Stack(
                            children: [
                              Container(
                                width: 18.0.textScale(),
                                height: 18.0.textScale(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: widget.node.isTickChildren.isTick
                                      ? AppTheme.getInstance().colorField()
                                      : Colors.transparent,
                                ),
                              ),
                              CustomCheckBox(
                                onChange: (isCheck) {
                                  widget.node.isCheck.isCheck = !isCheck;
                                widget.themDonViCubit.selectTag(widget.node);
                                },
                                isCheck: widget.node.isCheck.isCheck,
                              )
                            ],
                          );
                        }),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          widget.node.expand = !widget.node.expand;
                          if (!widget.node.isCallApi) {
                            widget.node.isCallApi = true;
                            if (widget.node.value.chucVu.isEmpty) {
                              await widget.themDonViCubit.searchCanBoPaging(
                                widget.node.value.id,
                                widget.node,
                              );
                            }
                          }
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
              return TreeViewChiaSeBaoCaoWidget(
                selectOnly: widget.selectOnly,
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
    if (widget.node.value.chucVu.isEmpty) {
      return widget.node.value.name;
    }
    return '${widget.node.value.name} ${widget.node.value.chucVu}';
  }
}
