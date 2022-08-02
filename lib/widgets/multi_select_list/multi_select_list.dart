import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/multi_select_list/item_list.dart';
import 'package:ccvc_mobile/widgets/multi_select_list/selected_item.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

class MultiSelectList extends StatefulWidget {
  final Function(List<int>) onChange;
  final String? title;
  final String? listTitle;
  final String? hintText;
  final bool isRequire;
  final List<String> items;
  final List<String>? initSelectedItems;
  final bool isInit;

  const MultiSelectList({
    Key? key,
    required this.onChange,
    this.title,
    this.hintText,
    this.isRequire = false,
    required this.items,
    this.listTitle,
    this.initSelectedItems,
    required this.isInit,
  }) : super(key: key);

  @override
  State<MultiSelectList> createState() => _MultiSelectListState();
}

class _MultiSelectListState extends State<MultiSelectList> {
  final logic = Logic();

  @override
  void initState() {
    logic.allValue = widget.items;
    logic.selectedItemStream.sink.add(logic.selectedIndex);
    logic.checkInit(widget.initSelectedItems);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultiSelectList oldWidget) {
    logic.allValue = widget.items;
    if(widget.isInit) {
      logic.checkInit(widget.initSelectedItems);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title ?? '',
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: titleItemEdit,
              ),
            ),
            if (widget.isRequire)
              const Text(
                ' *',
                style: TextStyle(color: canceledColor),
              )
          ],
        ),
        SizedBox(
          height: 8.0.textScale(),
        ),
        GestureDetector(
          onTap: () {
            showSelect();
          },
          child: Container(
            height: 56,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (logic.selectedValue.isNotEmpty)
                  Row(
                    children: logic.selectedValue
                        .map(
                          (element) => Text(
                            getTextList(
                              title: element,
                              listTitle: logic.selectedValue,
                            ),
                            style: textNormal(textTitle, 14.0.textScale()),
                          ),
                        )
                        .toList(),
                  )
                else
                  Text(
                    S.current.chon,
                    style: tokenDetailAmount(
                      fontSize: 14,
                      color: color3D5586,
                    ),
                  ),
                SvgPicture.asset(ImageAssets.icEditInfor)
              ],
            ),
          ),
        )
      ],
    );
  }

  String getTextList({
    required String title,
    required List<String> listTitle,
  }) =>
      title +
      ((listTitle.length !=
              listTitle.indexWhere((element) => element == title) + 1)
          ? ', '
          : '');

  void showSelect() {
    if (isMobile()) {
      showBottomSheetCustom<List<int>>(
        context,
        title: widget.title ?? '',
        child: Issue(
          logic: logic,
          items: widget.items,
          title: widget.listTitle ?? '',
        ),
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
          setState(() {});
        }
      });
    } else {
      showDiaLogTablet<List<int>>(
        context,
        title: widget.title ?? '',
        child: Issue(
          logic: logic,
          title: widget.listTitle ?? '',
          items: widget.items,
        ),
        isBottomShow: true,
        funcBtnOk: () {
          Navigator.pop(context);
        },
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
          setState(() {});
        }
      });
    }
  }

  List<String> title() {
    if (logic.selectedIndex.isEmpty) {
      return [widget.hintText ?? ''];
    } else {
      return logic.selectedValue;
    }
  }
}

class Issue extends StatefulWidget {
  final List<String> items;
  final String title;
  final Logic logic;

  const Issue({
    Key? key,
    required this.items,
    required this.title,
    required this.logic,
  }) : super(key: key);

  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          StreamBuilder<List<int>>(
            stream: widget.logic.selectedItemStream,
            builder: (context, snapshot) {
              return SelectedItemCell(
                controller: controller,
                listSelect: widget.logic.selectedValue,
                onChange: (value) {},
                onDelete: (value) {
                  widget.logic.checkValue(value);
                },
              );
            },
          ),
          SizedBox(
            height: 18.0.textScale(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.title.isNotEmpty)
                  Text(
                    widget.title,
                    style: textNormal(textTitle, 16),
                  ),
                if (widget.title.isNotEmpty)
                  SizedBox(
                    height: 22.0.textScale(space: -9),
                  ),
                Expanded(
                  child: widget.items.isNotEmpty
                      ? SingleChildScrollView(
                          keyboardDismissBehavior: isMobile()
                              ? ScrollViewKeyboardDismissBehavior.onDrag
                              : ScrollViewKeyboardDismissBehavior.manual,
                          child: Column(
                            children: List.generate(
                              widget.items.length,
                              (index) => ItemList(
                                logic: widget.logic,
                                name: widget.items[index],
                                index: index,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: const [
                            NodataWidget(),
                          ],
                        ),
                )
              ],
            ),
          ),
          screenDevice(
            mobileScreen: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.luu,
                onClickLeft: () {
                  Navigator.pop(context);
                },
                onClickRight: () {
                  Navigator.pop(context, widget.logic.selectedIndex);
                },
              ),
            ),
            tabletScreen: const SizedBox(),
          )
        ],
      ),
    );
  }
}

class Logic {
  BehaviorSubject<List<int>> selectedItemStream = BehaviorSubject();
  List<String> allValue = [];
  List<int> selectedIndex = [];
  List<String> selectedValue = [];

  void checkIndex(int _index) {
    if (selectedIndex.contains(_index)) {
      selectedIndex.remove(_index);
      selectedValue.remove(allValue[_index]);
    } else {
      selectedIndex.add(_index);
      selectedValue.add(allValue[_index]);
    }
    selectedIndex.toSet().toList();
    selectedItemStream.sink.add(selectedIndex);
  }

  void checkValue(String value) {
    if (selectedValue.contains(value)) {
      selectedIndex.remove(allValue.indexOf(value));
      selectedValue.remove(value);
    } else {
      selectedIndex.add(allValue.indexOf(value));
      selectedValue.add(value);
    }
    selectedItemStream.sink.add(selectedIndex);
  }

  void checkInit(List<String>? initValue) {
    selectedValue = initValue ?? [];
    if (selectedValue.isNotEmpty && allValue.isNotEmpty) {
      for (final e in selectedValue) {
        selectedIndex.add(allValue.indexOf(e));
      }
    }
    selectedValue.toSet().toList();
    selectedItemStream.sink.add(selectedIndex);
  }
}
