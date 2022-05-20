import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:rxdart/subjects.dart';

// ignore: must_be_immutable
class CustomSelectItemsTablet extends StatefulWidget {
  final String? value;
  final BuildContext context;
  final List<String> items;
  String? title;
  final Function(int) onChange;
  Function(int)? onSelectItem;
  Function? onRemove;
  bool isCheckEnable = false;
  Function onRemoveValue;

  CustomSelectItemsTablet({
    Key? key,
    this.value,
    this.onSelectItem,
    this.onRemove,
    this.title,
    required this.context,
    required this.items,
    required this.onChange,
    required this.isCheckEnable,
    required this.onRemoveValue,
  }) : super(key: key);

  @override
  _CustomSelectItemsTabletState createState() =>
      _CustomSelectItemsTabletState();
}

class _CustomSelectItemsTabletState extends State<CustomSelectItemsTablet> {
  List<String> selectedItems = [];
  List<String> searchList = [];
  bool isSearching = false;
  double sizeWitdhTag = 0;
  BehaviorSubject<List<String>> searchItemSubject = BehaviorSubject();

  void showListItem(BuildContext context) {
    searchItemSubject = BehaviorSubject.seeded(widget.items);
    showDialog(
      context: context,
      builder: (context) {
        return KeyboardDismisser(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).viewInsets.bottom <= 160
                      ? 300
                      : 100,
                  horizontal: 200,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: colorFFFFFF,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 56,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colorEDF0FD,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.title ?? S.current.danh_sach_rong,
                                    style: tokenDetailAmount(
                                      fontSize: 12.0.textScale(),
                                      color: color3D5586,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: SvgPicture.asset(ImageAssets.icClose),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BaseSearchBar(
                          onChange: (keySearch) async {
                            searchList = widget.items
                                .where(
                                  (item) => item.trim().toLowerCase().contains(
                                        keySearch.trim().toLowerCase(),
                                      ),
                                )
                                .toList();
                            searchItemSubject.sink.add(searchList);
                          },
                        ),
                        Expanded(
                          child: StreamBuilder<List<String>>(
                            stream: searchItemSubject,
                            builder: (context, snapshot) {
                              final listData = snapshot.data ?? [];
                              return listData.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        S.current.danh_sach_rong,
                                        style: tokenDetailAmount(
                                          fontSize: 12.0.textScale(),
                                          color: color3D5586,
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        final itemTitle =
                                            snapshot.data?[index] ?? '';
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (selectedItems
                                                  .contains(itemTitle)) {
                                              } else {
                                                selectedItems.clear();
                                                selectedItems.add(itemTitle);
                                              }
                                            });
                                            widget.onChange(index);
                                            if (widget.onSelectItem != null) {
                                              widget.onSelectItem!(index);
                                            }
                                            Navigator.of(context).pop();
                                            searchItemSubject.close();
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              itemTitle,
                                              style: TextStyle(
                                                color: color3D5586,
                                                fontWeight: selectedItems
                                                        .contains(itemTitle)
                                                    ? FontWeight.w400
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          color: colorDBDFEF,
                                        );
                                      },
                                      itemCount: snapshot.data?.length ?? 0,
                                    );
                            },
                          ),
                        ),
                        spaceH10
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagView() {
    return Wrap(
      children: _listTag(),
    );
  }

  List<Widget> _listTag() {
    final listWidget = <Widget>[];
    for (int index = 0; index < selectedItems.length; index++) {
      listWidget.add(_buildTagItem(selectedItems[index], index));
    }
    return listWidget;
  }

  Widget _buildTagItem(String content, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 9,
          child: Text(
            content,
            style: tokenDetailAmount(
              fontSize: 14.0.textScale(),
              color: color3D5586,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onRemoveValue();
              if (widget.onRemove != null) {
                widget.onRemove!();
              }
              setState(() {
                selectedItems.removeAt(index);
              });
            },
            child: SvgPicture.asset(ImageAssets.icClose),
          ),
        ),
        spaceW8
      ],
    );
  }

  List<int> selectedIndex() {
    final indexes = <int>[];
    for (final selectedItem in selectedItems) {
      indexes.add(widget.items.indexOf(selectedItem));
    }
    return indexes;
  }

  final GlobalKey keyDiaLog = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      sizeWitdhTag = keyDiaLog.currentContext?.size?.width ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isCheckEnable
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8, top: 14, bottom: 14),
                decoration: BoxDecoration(
                  color: colorDBDFEF.withOpacity(0.2),
                  border: Border.all(color: colorDBDFEF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.title ?? S.current.danh_sach_rong,
                  style: tokenDetailAmount(
                    fontSize: 14.0.textScale(),
                    color: color3D5586,
                  ),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: () {
              showListItem(widget.context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  key: keyDiaLog,
                  padding: const EdgeInsets.only(left: 8, top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorDBDFEF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: selectedItems.isNotEmpty
                      ? _buildTagView()
                      : Text(
                          widget.title ?? S.current.danh_sach_rong,
                          style: tokenDetailAmount(
                            fontSize: 14.0.textScale(),
                            color: color3D5586,
                          ),
                        ),
                ),
              ],
            ),
          );
  }
}
