import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/radio_button.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.items.isEmpty && widget.initialValue == null) {
          return;
        }
        searchItemSubject = BehaviorSubject.seeded(widget.items);
        showBottomSheetCustom(
          context,
          title: widget.title ?? S.current.chon_tinh_thanh_pho,
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
                            (item) =>
                                (item.name ?? '').trim().toLowerCase().contains(
                                      keySearch.trim().toLowerCase(),
                                    ),
                          )
                          .toList();
                      searchItemSubject.sink.add(searchList);
                    },
                  ),
                  spaceH4,
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final data = widget.items[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.only(
                                top: 18,
                                bottom: 18,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.name ?? '',
                                      style: tokenDetailAmount(
                                        color: titleColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomRadioButtonCheck(
                                          isCheckButton: itemSelected ==
                                              (widget.items[index].id ?? ''),
                                          onSelectItem: () {
                                            itemSelected =
                                                widget.items[index].id ?? '';
                                            selectedItemSubject.sink.add(
                                              widget.items[index].name ?? '',
                                            );
                                            widget.onChange(
                                              index,
                                              data.id ?? '',
                                            );
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: cellColorborder,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  spaceH10
                ],
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
                color: titleColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
