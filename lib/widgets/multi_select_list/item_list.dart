import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/multi_select_list/multi_select_list.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final String name;
  final int index;
  final Logic logic;

  const ItemList({
    Key? key,
    required this.name,
    required this.index,
    required this.logic,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.logic.selectedItemStream,
      builder: (context, snapshot) {
        final selectedIndex = snapshot.data ?? [];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomCheckBox(
                          onChange: (isCheck) {
                            widget.logic.checkIndex(widget.index);
                          },
                          isCheck: selectedIndex.contains(widget.index),
                          title: '',
                        ),
                        spaceW10,
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              widget.logic.checkIndex(widget.index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.name,
                                      style: textNormal(
                                        textTitle,
                                        14.0.textScale(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
