import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class DropDownSearch extends StatefulWidget {
  final List<String> listSelect;
  final String title;
  final Function(int) onChange;
  final String hintText;
  final String initSelected;

  const DropDownSearch({
    Key? key,
    required this.listSelect,
    this.title = '',
    required this.onChange,
    this.hintText = '',
    this.initSelected = '',
  }) : super(key: key);

  @override
  State<DropDownSearch> createState() => _DropDownSearchState();
}

class _DropDownSearchState extends State<DropDownSearch> {
  final TextEditingController textEditingController = TextEditingController();
  BehaviorSubject<List<String>> searchItemSubject = BehaviorSubject();
  List<String> searchList = [];
  late String select;

  @override
  void initState() {
    super.initState();
    select = widget.initSelected;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showListItem(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: select.isEmpty
            ? Text(
                widget.hintText,
                style: textNormal(
                  titleItemEdit,
                  14.0.textScale(),
                ),
              )
            : Text(
                select,
                style: tokenDetailAmount(
                  fontSize: 14.0.textScale(),
                  color: color3D5586,
                ),
              ),
      ),
    );
  }

  void showListItem(BuildContext context) {
    searchItemSubject = BehaviorSubject.seeded(widget.listSelect);
    if (isMobile()) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).viewInsets.bottom <= kHeightKeyBoard
                        ? 100
                        : 20,
                horizontal: 20,
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Container(
                  decoration: const BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 56,
                          child: Stack(
                            children: [
                              Align(
                                child: Text(
                                  widget.title,
                                  style: titleAppbar(
                                      fontSize: 18.0.textScale(space: 6.0)),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(ImageAssets.icClose),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(child: dialogCell()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      showDiaLogTablet(context,
          title: widget.title, child: dialogCell(), funcBtnOk: () {});
    }
  }

  int selectIndex() {
    final index = widget.listSelect.indexOf(select);
    return index;
  }

  Widget dialogCell() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        BaseSearchBar(
          onChange: (keySearch) async {
            searchList = widget.listSelect
                .where(
                  (item) =>
                      item.trim().toLowerCase().vietNameseParse().contains(
                            keySearch.trim().toLowerCase().vietNameseParse(),
                          ),
                )
                .toList();
            searchItemSubject.sink.add(searchList);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<List<String>>(
            stream: searchItemSubject,
            builder: (context, snapshot) {
              final listData = snapshot.data ?? [];
              return listData.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: NodataWidget(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final itemTitle = snapshot.data?[index] ?? '';
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              select = itemTitle;
                            });
                            widget.onChange(selectIndex());
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
                              style: textNormalCustom(
                                color: titleItemEdit,
                                fontWeight: itemTitle == select
                                    ? FontWeight.w600
                                    : FontWeight.w400,
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
    );
  }
}
