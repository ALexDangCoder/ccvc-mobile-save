import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

class SelectOnlyExpand extends StatefulWidget {
  final bool initExpand;
  final List<String> listSelect;
  final String value;
  final String title;
  final String urlIcon;
  final bool isShowValue;
  final Widget? customValue;
  final List<LoaiBaiVietModel> dataLoaiBaiViet;
  final Function(List<String>) onChange;

  const SelectOnlyExpand({
    Key? key,
    this.initExpand = false,
    this.listSelect = const [],
    this.value = '',
    this.isShowValue = true,
    this.title = '',
    required this.urlIcon,
    this.customValue,
    required this.onChange,
    required this.dataLoaiBaiViet,
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<SelectOnlyExpand>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<List<int>> selectBloc = BehaviorSubject();
  late AnimationController? expandController;
  double sizeWitdhTag = 0;
  bool checkbox = false;
  List<String> valueSelect = [];
  List<int> addIndex = [];

  List<String> idLoaiBaiViet = [];
  String id = '';

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.listSelect.isNotEmpty) {
      final index =
          widget.listSelect.indexWhere((element) => element == widget.value);
      if (index != -1) {
        valueSelect.add(widget.listSelect[index]);
        for (final element in valueSelect) {
          for (int i = 0; i < widget.dataLoaiBaiViet.length; i++) {
            if (element == widget.dataLoaiBaiViet[i].title) {
              id = widget.dataLoaiBaiViet[i].id ?? '';
              break;
            }
          }
        }
        idLoaiBaiViet.add(id);
        widget.onChange(idLoaiBaiViet);
        addIndex.add(index);
        selectBloc.sink.add(addIndex);
      }
    }
  }

  @override
  void didUpdateWidget(covariant SelectOnlyExpand oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.listSelect.isNotEmpty) {
      final index =
          widget.listSelect.indexWhere((element) => element == widget.value);
      if (index != -1) {
        valueSelect.add(widget.listSelect[index]);
        for (final element in valueSelect) {
          for (int i = 0; i < widget.dataLoaiBaiViet.length; i++) {
            if (element == widget.dataLoaiBaiViet[i].title) {
              id = widget.dataLoaiBaiViet[i].id ?? '';
              break;
            }
          }
        }
        idLoaiBaiViet.add(id);
        widget.onChange(idLoaiBaiViet);
        addIndex.add(index);
        selectBloc.sink.add(addIndex);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      initExpand: widget.initExpand,
      isShowIcon: false,
      initController: expandController,
      header: headerWidget(),
      child: widget.listSelect.isEmpty
          ? const NodataWidget()
          : StreamBuilder<List<int>>(
              stream: selectBloc.stream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.listSelect.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: index == 0 ? 0 : 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                          if (valueSelect.contains(widget.listSelect[index])) {
                            valueSelect.remove(widget.listSelect[index]);
                          } else {
                            valueSelect.add(widget.listSelect[index]);
                          }
                          //
                          for (final element in valueSelect) {
                            for (int i = 0;
                                i < widget.dataLoaiBaiViet.length;
                                i++) {
                              if (element == widget.dataLoaiBaiViet[i].title) {
                                id = widget.dataLoaiBaiViet[i].id ?? '';
                                break;
                              }
                            }
                          }
                          //
                          if (idLoaiBaiViet.contains(id)) {
                            idLoaiBaiViet.remove(id);
                          } else {
                            idLoaiBaiViet.add(id);
                          }
                          //

                          if (addIndex.contains(index)) {
                            addIndex.remove(index);
                            selectBloc.sink.add(addIndex);
                          } else {
                            addIndex.add(index);
                            selectBloc.sink.add(addIndex);
                          }
                          widget.onChange(idLoaiBaiViet);
                          print("ZZZZZ${idLoaiBaiViet.toString()}");
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.listSelect[index],
                                  style: textNormal(titleColor, 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              StreamBuilder<List<int>>(
                                stream: selectBloc.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [0];
                                  return data.contains(index)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: SvgPicture.asset(
                                            ImageAssets.icCheck,
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: SvgPicture.asset(
                                            ImageAssets.icUnCheck,
                                          ),
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Widget headerWidget() {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: Colors.transparent,
          child: SvgPicture.asset(
            widget.urlIcon,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: expandController!,
            builder: (context, _) => Container(
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: expandController!.value == 0
                        ? lineColor
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (widget.value == null)
                    Expanded(
                      child: Text(
                        widget.title,
                        style: textNormal(titleColumn, 16),
                      ),
                    )
                  else
                    Expanded(
                      child: widget.customValue ??
                          StreamBuilder<List<int>>(
                            stream: selectBloc.stream,
                            builder: (context, snapshot) {
                              return _buildTagView();
                            },
                          ),
                    ),
                  if (expandController!.value == 0)
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AqiColor,
                    )
                  else
                    const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AqiColor,
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagView() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: _listTag(),
    );
  }

  List<Widget> _listTag() {
    final listWidget = <Widget>[];
    for (int index = 0; index < valueSelect.length; index++) {
      listWidget.add(_buildTagItem(valueSelect[index], index));
    }
    return listWidget;
  }

  Widget _buildTagItem(String content, int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
      decoration: BoxDecoration(
        color: bgTabletColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: textDetailHDSD(fontSize: 14, color: textTitle),
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
              // widget.onChange(valueSelect);
              valueSelect.removeAt(index);
              addIndex.removeAt(index);
              idLoaiBaiViet.removeAt(index);
              widget.onChange(idLoaiBaiViet);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: SvgPicture.asset(ImageAssets.icClose),
            ),
          ),
        ],
      ),
    );
  }
}
