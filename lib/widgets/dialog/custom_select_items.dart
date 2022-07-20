import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_close.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';

import 'package:flutter/material.dart';

import 'package:rxdart/subjects.dart';

class CustomSelectMultiItems extends StatefulWidget {
  final BuildContext context;
  final List<ListItemType> items;
  final String? title;
  final Function(ListItemType) onChange;
  final String hintText;
  const CustomSelectMultiItems({
    Key? key,
    this.title,
    required this.context,
    required this.items,
    required this.onChange,
    this.hintText = '',
  }) : super(key: key);

  @override
  _CustomSelectMultiItemsState createState() => _CustomSelectMultiItemsState();
}

class _CustomSelectMultiItemsState extends State<CustomSelectMultiItems> {
  ListItemType? selectedItems;
  List<ListItemType> searchList = [];
  bool isSearching = false;
  double sizeWitdhTag = 0;
  BehaviorSubject<List<ListItemType>> searchItemSubject = BehaviorSubject();

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
                searchList = widget.items
                    .where(
                      (item) => item.title
                          .trim()
                          .toLowerCase()
                          .vietNameseParse()
                          .contains(
                            keySearch.trim().toLowerCase().vietNameseParse(),
                          ),
                    )
                    .toList();
                searchItemSubject.sink.add(searchList);
              }),
              Expanded(
                child: StreamBuilder<List<ListItemType>>(
                    stream: searchItemSubject,
                    builder: (context, snapshot) {
                      final listData = snapshot.data ?? <ListItemType>[];
                      return listData.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(S.current.danh_sach_rong),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final itemTitle = listData[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedItems = itemTitle;
                                    });
                                    widget.onChange(itemTitle);
                                    Navigator.of(context).pop();
                                    searchItemSubject.close();
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      itemTitle.title,
                                      style: textNormalCustom(
                                        color: titleItemEdit,
                                        fontWeight: selectedItems == itemTitle
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
                              itemCount: listData.length,
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
            horizontal: 16,
          ),
          child: Container(
            decoration: const BoxDecoration(
                color: backgroundColorApp,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBarDefaultClose(
                    widget.title ?? '',
                    color3D5586,
                    sizeTitle: 16,
                  ),
                  BaseSearchBar(onChange: (keySearch) async {
                    searchList = widget.items
                        .where(
                          (item) => item.title
                          .trim()
                          .toLowerCase()
                          .vietNameseParse()
                          .contains(
                        keySearch.trim().toLowerCase().vietNameseParse(),
                      ),
                    )
                        .toList();
                    searchItemSubject.sink.add(searchList);
                  }),
                  Expanded(
                    child: StreamBuilder<List<ListItemType>>(
                      stream: searchItemSubject,
                      builder: (context, snapshot) {
                        final listData = snapshot.data ?? [];
                        return listData.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(S.current.danh_sach_rong),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final itemTitle = listData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedItems = itemTitle;
                                      });
                                      widget.onChange(itemTitle);
                                      Navigator.of(context).pop();
                                      searchItemSubject.close();
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        itemTitle.title,
                                        style: textNormalCustom(
                                          color: color586B8B,
                                          fontWeight: selectedItems == itemTitle
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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: selectedItems != null
            ? Text(
                selectedItems?.title ?? '',
                style: tokenDetailAmount(
                  fontSize: 14.0.textScale(),
                  color: titleCalenderWork,
                ),
              )
            : Text(
                widget.hintText,
                style: textNormal(titleItemEdit.withOpacity(0.5), 14),
              ),
      ),
    );
  }
}

class ListItemType {
  final String title;
  final String id;

  ListItemType({required this.title, required this.id});
}
