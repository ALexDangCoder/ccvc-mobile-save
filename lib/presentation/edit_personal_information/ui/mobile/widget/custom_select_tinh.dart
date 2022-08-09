import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/radio_button.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/follow_key_broash.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

// ignore: must_be_immutable
class CustomSelectTinh extends StatefulWidget {
  final String? title;
  final List<TinhHuyenXaModel> items;
  String? initialValue;
  final Function(int, String) onChange;
  Function(int)? onSelectItem;
  Function? onRemove;
  ManagerPersonalInformationCubit cubit;
  bool isEnable;
  final bool tapLet;

  CustomSelectTinh({
    Key? key,
    this.title,
    this.onSelectItem,
    this.onRemove,
    this.initialValue,
    required this.items,
    required this.onChange,
    required this.cubit,
    required this.isEnable,
    this.tapLet = false,
  }) : super(key: key);

  @override
  _CustomSelectTinhState createState() => _CustomSelectTinhState();
}

class _CustomSelectTinhState extends State<CustomSelectTinh> {
  List<TinhHuyenXaModel> selectedItems = [];
  List<TinhHuyenXaModel> searchList = [];
  bool isSearching = false;
  double sizeWitdhTag = 0;
  BehaviorSubject<List<TinhHuyenXaModel>> searchItemSubject = BehaviorSubject();
  final GlobalKey keyDiaLog = GlobalKey();
  bool isCheck = false;
  int isCheckSelectedItem = 0;
  String contents = '';
  String itemSelected = '';
  late BehaviorSubject<String> selectedItemSubject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      sizeWitdhTag = keyDiaLog.currentContext?.size?.width ?? 0;
    });
    selectedItemSubject = BehaviorSubject.seeded(
      widget.initialValue ?? widget.title ?? '',
    );
    final tinhHuyenXa = widget.items.firstWhere(
      (element) => element.name == widget.initialValue,
      orElse: () {
        return TinhHuyenXaModel();
      },
    );
    itemSelected = tinhHuyenXa.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.items.isEmpty && widget.initialValue == null) {
          return;
        }
        searchItemSubject = BehaviorSubject.seeded(widget.items);

        widget.tapLet
            ? showDiaLogTablet(
                context,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
                title: widget.title ?? S.current.chon_tinh_thanh_pho,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceH20,
                          BaseSearchBar(
                            onChange: (keySearch) async {
                              searchList = widget.items
                                  .where(
                                    (item) => (item.name ?? '')
                                        .trim()
                                        .toLowerCase()
                                        .vietNameseParse()
                                        .contains(
                                          keySearch
                                              .trim()
                                              .toLowerCase()
                                              .vietNameseParse(),
                                        ),
                                  )
                                  .toList();
                              searchItemSubject.sink.add(searchList);
                            },
                          ),
                          spaceH4,
                          Expanded(
                            child: StreamBuilder<List<TinhHuyenXaModel>>(
                              stream: searchItemSubject,
                              builder: (context, snapshot) {
                                final listData = snapshot.data ?? [];
                                return listData.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: NodataWidget(),
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          TinhHuyenXaModel();
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: Colors.transparent,
                                                padding: const EdgeInsets.only(
                                                  top: 18,
                                                  bottom: 18,
                                                ),
                                                child: CustomRadioButtonCheck(
                                                  isCheckButton: itemSelected ==
                                                      (listData[index].id ??
                                                          ''),
                                                  onSelectItem: () {
                                                    itemSelected =
                                                        listData[index].id ??
                                                            '';
                                                    selectedItemSubject.sink
                                                        .add(
                                                      listData[index].name ??
                                                          '',
                                                    );
                                                    widget.onChange(
                                                      index,
                                                      listData[index].id ?? '',
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  name: listData[index].name ??
                                                      '',
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                color: cellColorborder,
                                              )
                                            ],
                                          );
                                        },
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
                isBottomShow: false,
                funcBtnOk: () {

                },
              )
            : showBottomSheetCustom(
                context,
                title: widget.title ?? S.current.chon_tinh_thanh_pho,
                child: FollowKeyBoardWidget(
                  child: SingleChildScrollView(
                    child: Container(
                      height: Platform.isIOS
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.4,
                      padding: MediaQuery.of(context).viewInsets,
                      decoration: const BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceH20,
                          BaseSearchBar(
                            onChange: (keySearch) async {
                              searchList = widget.items
                                  .where(
                                    (item) => (item.name ?? '')
                                        .trim()
                                        .toLowerCase()
                                        .vietNameseParse()
                                        .contains(
                                          keySearch
                                              .trim()
                                              .toLowerCase()
                                              .vietNameseParse(),
                                        ),
                                  )
                                  .toList();
                              searchItemSubject.sink.add(searchList);
                            },
                          ),
                          spaceH4,
                          Expanded(
                            child: StreamBuilder<List<TinhHuyenXaModel>>(
                              stream: searchItemSubject,
                              builder: (context, snapshot) {
                                final listData = snapshot.data ?? [];
                                return listData.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: NodataWidget(),
                                      )
                                    : ListView.builder(
                                        itemCount: listData.length,
                                        itemBuilder: (context, index) {
                                          // final data = listData[index];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: Colors.transparent,
                                                padding: const EdgeInsets.only(
                                                  top: 18,
                                                  bottom: 18,
                                                ),
                                                child: CustomRadioButtonCheck(
                                                  isCheckButton: itemSelected ==
                                                      (listData[index].id ??
                                                          ''),
                                                  onSelectItem: () {
                                                    itemSelected =
                                                        listData[index].id ??
                                                            '';
                                                    selectedItemSubject.sink
                                                        .add(
                                                      listData[index].name ??
                                                          '',
                                                    );
                                                    widget.onChange(
                                                      index,
                                                      listData[index].id ?? '',
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  name: listData[index].name ??
                                                      '',
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                color: cellColorborder,
                                              )
                                            ],
                                          );
                                        },
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
      child: Container(
        width: double.infinity,
        key: keyDiaLog,
        padding: const EdgeInsets.only(left: 8, top: 14, bottom: 14),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
          color: widget.items.isEmpty && widget.initialValue == null
              ? borderColor.withOpacity(0.2)
              : Colors.white,
        ),
        child: StreamBuilder<String>(
          stream: selectedItemSubject.stream,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? '',
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: color3D5586,
              ),
            );
          },
        ),
      ),
    );
  }
}
