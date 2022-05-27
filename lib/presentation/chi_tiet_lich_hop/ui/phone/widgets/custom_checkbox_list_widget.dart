import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

class CustomCheckBoxList extends StatefulWidget {
  final bool initExpand;
  final String value;
  final String title;
  final String urlIcon;
  final bool isShowValue;
  final Widget? customValue;
  final List<DanhSachNguoiThamGiaModel> dataNguoiThamGia;
  final Function(List<DanhSachNguoiThamGiaModel>) onChange;

  const CustomCheckBoxList({
    Key? key,
    this.initExpand = true,
    this.value = '',
    this.isShowValue = true,
    this.title = '',
    required this.urlIcon,
    this.customValue,
    required this.onChange,
    required this.dataNguoiThamGia,
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<CustomCheckBoxList>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<List<int>> selectBloc = BehaviorSubject();
  late AnimationController? expandController;
  double sizeWitdhTag = 0;
  bool checkbox = false;
  List<DanhSachNguoiThamGiaModel> valueSelect = [];
  List<int> addIndex = [];

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // if (widget.dataLoaiBaiViet.isNotEmpty) {
    //   final index = widget.dataLoaiBaiViet
    //       .indexWhere((element) => element.title == widget.value);
    //   if (index != -1) {
    //     valueSelect.add(widget.dataLoaiBaiViet[index]);
    //     widget.onChange(valueSelect);
    //     addIndex.add(index);
    //     selectBloc.sink.add(addIndex);
    //   }
    // }
  }

  @override
  // void didUpdateWidget(covariant CustomSelectMutil oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.dataLoaiBaiViet.isNotEmpty) {
  //     final index = widget.dataLoaiBaiViet
  //         .indexWhere((element) => element.title == widget.value);
  //     if (index != -1) {
  //       valueSelect.add(widget.dataLoaiBaiViet[index]);
  //       widget.onChange(valueSelect);
  //       addIndex.add(index);
  //       selectBloc.sink.add(addIndex);
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      initExpand: true,
      isShowIcon: false,
      initController: expandController,
      header: Container(),
      child: widget.dataNguoiThamGia.isEmpty
          ? const NodataWidget()
          : StreamBuilder<List<int>>(
              stream: selectBloc.stream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.dataNguoiThamGia.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: borderColor.withOpacity(0.5)),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: index == 0 ? 0 : 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                          if (valueSelect
                              .contains(widget.dataNguoiThamGia[index])) {
                            valueSelect.remove(widget.dataNguoiThamGia[index]);
                          } else {
                            valueSelect.add(widget.dataNguoiThamGia[index]);
                          }
                          if (addIndex.contains(index)) {
                            addIndex.remove(index);
                            selectBloc.sink.add(addIndex);
                          } else {
                            addIndex.add(index);
                            selectBloc.sink.add(addIndex);
                          }
                          widget.onChange(valueSelect);
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              StreamBuilder<List<int>>(
                                stream: selectBloc.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  return data.contains(index)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageAssets.icCheck,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageAssets.icUnCheck,
                                          ),
                                        );
                                },
                              ),
                              spaceW10,
                              Flexible(
                                child: Text(
                                  plusString(
                                    widget.dataNguoiThamGia[index].tenCanBo,
                                    widget.dataNguoiThamGia[index].tenChucVu,
                                    widget.dataNguoiThamGia[index].tenCoQuan,
                                  ),
                                  style:
                                      textNormal(color3D5586, 14.0.textScale()),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
                        ? colorECEEF7
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Row(
                children: [
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
      listWidget.add(_buildTagItem(valueSelect[index].tenCanBo ?? '', index));
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
              valueSelect.removeAt(index);
              addIndex.removeAt(index);
              widget.onChange(valueSelect);
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
