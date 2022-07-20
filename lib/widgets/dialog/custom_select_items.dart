import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_close.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';

import 'package:flutter/material.dart';

import 'package:rxdart/subjects.dart';

// ignore: must_be_immutable
class CustomSelectMultiItems extends StatefulWidget {
  final BuildContext context;
  final List<String> items;
  String? title;
  final Function(List<int>) onChange;
  Function(int)? onSelectItem;
  Function(int)? onRemoveItem;
  final String hintText;
  CustomSelectMultiItems(
      {Key? key,
      this.onSelectItem,
      this.onRemoveItem,
      this.title,
      required this.context,
      required this.items,
      required this.onChange,
      this.hintText = ''})
      : super(key: key);

  @override
  _CustomSelectMultiItemsState createState() => _CustomSelectMultiItemsState();
}

class _CustomSelectMultiItemsState extends State<CustomSelectMultiItems> {
  List<String> selectedItems = [];
  List<String> searchList = [];
  bool isSearching = false;
  double sizeWitdhTag = 0;
  BehaviorSubject<List<String>> searchItemSubject = BehaviorSubject();

  void showListItem(BuildContext context) {
    searchItemSubject = BehaviorSubject.seeded(widget.items);
    if (isMobile()) {
      showDialog(
        context: context,
        builder: (context) {
          return dialogMobile();
        },
      );
    } else {
      showDiaLogTablet(context,
          title: widget.title ?? '',
          child: Column(
            children: [
              BaseSearchBar(onChange: (keySearch) async {
                // searchList = widget.items
                //     .where((item) => item
                //     .trim()
                //     .toLowerCase()
                //     .removeDiacritics()
                //     .contains(keySearch
                //     .trim()
                //     .toLowerCase()
                //     .removeDiacritics()))
                //     .toList();
                // searchItemSubject.sink.add(searchList);
              }),
              Expanded(
                child: StreamBuilder<List<String>>(
                    stream: searchItemSubject,
                    builder: (context, snapshot) {
                      final listData = snapshot.data ?? [];
                      return listData.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('Danh sách rỗng'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final itemTitle = snapshot.data?[index] ?? '';
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedItems.contains(itemTitle)) {
                                        selectedItems.remove(itemTitle);
                                      } else {
                                        selectedItems.add(itemTitle);
                                      }
                                    });
                                    widget.onChange(selectedIndex());
                                    if (widget.onSelectItem != null) {
                                      widget.onSelectItem!(index);
                                    }
                                    Navigator.of(context).pop();
                                    searchItemSubject.close();
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      itemTitle,
                                      style: TextStyle(
                                        color: const Color(0xff586B8B),
                                        fontWeight:
                                            selectedItems.contains(itemTitle)
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Color(0xffDBDFEF),
                                );
                              },
                              itemCount: snapshot.data?.length ?? 0,
                            );
                    }),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
          funcBtnOk: () {},
          isBottomShow: false);
    }
  }

  // Widget dialogTablet(){
  //   return  ClipRRect(
  //     borderRadius: BorderRadius.circular(8),
  //     child: Scaffold(
  //       resizeToAvoidBottomInset: true,
  //       backgroundColor: Colors.transparent,
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(
  //             vertical: MediaQuery.of(context).viewInsets.bottom <= 170
  //                 ? 200.h
  //                 : 40,
  //             ),
  //         child: Center(
  //           child: Container(
  //             width: 500,
  //             decoration: BoxDecoration(
  //                 color: Theme.of(context).backgroundColor,
  //                 borderRadius:
  //                 const BorderRadius.all(Radius.circular(8))),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     height: 56,
  //                     decoration: const BoxDecoration(
  //                         border: Border(
  //                             bottom:
  //                             BorderSide(color: Color(0xffEDF0FD)))),
  //                     padding: const EdgeInsets.only(left: 28, right: 19),
  //                     child: Stack(
  //                       children: [
  //                         Align(
  //                           child: Text(
  //                             widget.title??'Chọn đơn vị',
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headline4
  //                                 ?.copyWith(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           right: 0,
  //                           bottom: 0,
  //                           child: IconButton(
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                             icon: const Icon(
  //                               QLVB.close_btn,
  //                               color: const Color(0xffA2AEBD),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget dialogMobile() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical:
                  MediaQuery.of(context).viewInsets.bottom <= 160 ? 100 : 10,
              horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBarDefaultClose(widget.title ?? '', color3D5586),
                  BaseSearchBar(onChange: (keySearch) async {
                    // searchList = widget.items
                    //     .where((item) => item
                    //         .trim()
                    //         .toLowerCase()
                    //         .removeDiacritics()
                    //         .contains(keySearch
                    //             .trim()
                    //             .toLowerCase()
                    //             .removeDiacritics()))
                    //     .toList();
                    // searchItemSubject.sink.add(searchList);
                  }),
                  Expanded(
                    child: StreamBuilder<List<String>>(
                      stream: searchItemSubject,
                      builder: (context, snapshot) {
                        final listData = snapshot.data ?? [];
                        return listData.isEmpty
                            ? Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(S.current.danh_sach_rong),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final itemTitle = snapshot.data?[index] ?? '';
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedItems.contains(itemTitle)) {
                                          selectedItems.remove(itemTitle);
                                        } else {
                                          selectedItems.add(itemTitle);
                                        }
                                      });
                                      widget.onChange(selectedIndex());
                                      if (widget.onSelectItem != null) {
                                        widget.onSelectItem!(index);
                                      }
                                      Navigator.of(context).pop();
                                      searchItemSubject.close();
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        itemTitle,
                                        style: TextStyle(
                                          color: const Color(0xff586B8B),
                                          fontWeight:
                                              selectedItems.contains(itemTitle)
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: borderColor,
                                  );
                                },
                                itemCount: snapshot.data?.length ?? 0,
                              );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
    for (int index = 0; index < selectedItems.length; index++) {
      listWidget.add(_buildTagItem(selectedItems[index], index));
    }
    return listWidget;
  }

  Widget _buildTagItem(String content, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffDB353A),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            constraints: BoxConstraints(
              maxWidth: sizeWitdhTag - 60,
            ),
            child: Text(content,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              if (widget.onRemoveItem != null) {
                widget.onRemoveItem!(widget.items.indexOf(content));
              }
              setState(() {
                selectedItems.removeAt(index);
              });
            },
            child: const Icon(
              Icons.close,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
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
    return GestureDetector(
      onTap: () {
        // showBottomSheet(Widgets.context);
        showListItem(widget.context);
      },
      child: Container(
        key: keyDiaLog,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: const Color(0xffDBDFEF)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: selectedItems.isNotEmpty
            ? _buildTagView()
            : Text(
                widget.hintText,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: const Color(0xffA2AEBD)),
              ),
      ),
    );
  }
}
