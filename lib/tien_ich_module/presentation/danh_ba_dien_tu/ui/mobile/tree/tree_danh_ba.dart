// ignore_for_file: strict_raw_type, must_be_immutable

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/widgetTablet/dropdow_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/bloc_tree/danh_sach_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/widget/tree.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/search/base_seach_bar_no_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhBaWidget extends StatefulWidget {
  final Function(TreeDonViDanhBA) onChange;
  final DanhBaDienTuCubit cubit;

  const DanhBaWidget({
    Key? key,
    required this.onChange,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DanhBaWidget> createState() => _DanhBaScreenState();
}

class _DanhBaScreenState extends State<DanhBaWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getTree().then((value) => widget
        .onChange(widget.cubit.listTreeDanhBaSubject.value.tree[1].value));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownWidgetTablet(
            title: StreamBuilder<String>(
              stream: widget.cubit.tenDonVi.stream,
              builder: (context, snapshot) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    snapshot.data.toString(),
                    style: textNormal(titleColor, 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 11),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: Column(
                  children: [
                    BaseSearchBarNoBorder(
                      hintText: S.current.nhap_don_vi,
                      onChange: (vl) {
                        widget.cubit.searchTree(vl);
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: borderColor)),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: StreamBuilder(
                        stream: widget.cubit.listTreeDanhBaSubject.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (widget.cubit.listTreeDanhBa.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: NodataWidget(),
                            );
                          } else {
                            return Scrollbar(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                color: Colors.white,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: NodeWidget(
                                        onChange: (vl) {
                                          widget.onChange(vl);
                                        },
                                        key: UniqueKey(),
                                        node: widget.cubit.getRoot(),
                                        cubit: widget.cubit,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NodeWidget extends StatefulWidget {
  final Function(TreeDonViDanhBA) onChange;
  NodeHSCV? node;
  final DanhBaDienTuCubit cubit;

  NodeWidget({Key? key, this.node, required this.cubit, required this.onChange})
      : super(key: key);

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  late NodeCubit nodeCubit;
  bool isExpand = true;

  @override
  void initState() {
    super.initState();
    nodeCubit = NodeCubit(
        tree: widget.cubit.listTreeDanhBaSubject.value
            .getChild(widget.node?.value.id ?? ''));
    nodeCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double widthSize = size.width;
    return StreamBuilder<Tree>(
      stream: widget.cubit.listTreeDanhBaSubject.stream,
      builder: (BuildContext context, AsyncSnapshot<Tree> snapshot) {
        if (widget.node != null) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: widthSize,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.node?.isHasChild ?? false) {
                        setState(() {
                          isExpand = !isExpand;
                        });
                      } else {
                        widget.cubit.getValueTree(
                          id: widget.node?.value.id ?? '',
                          donVi: widget.node?.value.tenDonVi ?? '',
                        );
                        widget.onChange(
                          widget.node?.value ?? TreeDonViDanhBA.Emty(),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom:
                                  widget.node?.value.iD_DonVi_Cha != '' ? 6 : 0,
                              top:
                                  widget.node?.value.iD_DonVi_Cha != '' ? 6 : 0,
                            ),
                            decoration: BoxDecoration(
                              border: widget.node!.value.iD_DonVi_Cha != ''
                                  ? isExpand
                                      ? const Border()
                                      : const Border(
                                          bottom:
                                              BorderSide(color: borderColor))
                                  : const Border(),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: widget.node?.value.iD_DonVi_Cha != ''
                                      ? Text(
                                          widget.node?.value.tenDonVi ?? '',
                                          style: textNormal(titleColor, 14),
                                        )
                                      : const SizedBox(),
                                ),
                                Stack(
                                  children: [
                                    StreamBuilder<String>(
                                      stream: widget.cubit.idDonVi.stream,
                                      builder: (context, snapshot) {
                                        return snapshot.data.toString() ==
                                                widget.node?.value.id
                                            ? (widget.node?.isHasChild ?? false)
                                                ? const SizedBox()
                                                : SvgPicture.asset(
                                                    ImageAssets.ic_tick,
                                                  )
                                            : const SizedBox();
                                      },
                                    ),
                                    if (widget.node?.value.iD_DonVi_Cha != '')
                                      widget.node?.isHasChild ?? false
                                          ? isExpand
                                              ? iconUp()
                                              : iconDown()
                                          : const SizedBox(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (isExpand)
                  StreamBuilder<List<NodeHSCV>>(
                    stream: nodeCubit.listTreeXLPhanXuLySubject.stream,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<NodeHSCV>> snapshot,
                    ) {
                      widget.cubit.levelTree++;
                      final List<NodeHSCV> data = snapshot.data ?? [];
                      return Column(
                        children: [
                          ...data.map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                border: e == data.last
                                    ? const Border(
                                        bottom: BorderSide(color: borderColor))
                                    : const Border(),
                              ),
                              child: NodeWidget(
                                onChange: (vl) {
                                  widget.onChange(vl);
                                },
                                key: UniqueKey(),
                                node: e,
                                cubit: widget.cubit,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                else
                  Container(),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 0,
          );
        }
      },
    );
  }

  Widget iconUp() => const Icon(
        Icons.keyboard_arrow_up,
        color: AqiColor,
      );

  Widget iconDown() => const Icon(
        Icons.keyboard_arrow_down,
        color: AqiColor,
      );
}
