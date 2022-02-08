import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_button.dart';
import 'package:flutter/material.dart';

class StatePhatBieuWidget extends StatefulWidget {
  String? value;
  List<String> items = [];
  final Function(int)? onSelectItem;
  final Widget? hint;

  StatePhatBieuWidget(
      {Key? key, this.value, required this.items, this.onSelectItem, this.hint})
      : super(key: key);

  @override
  _StatePhatBieuWidgetState createState() => _StatePhatBieuWidgetState();
}

class _StatePhatBieuWidgetState extends State<StatePhatBieuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.items.isEmpty)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.value ?? '',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    )
                  else
                    DropdownButtonWidget<String>(
                      underline: Container(),
                      isExpanded: true,
                      value: widget.value,
                      hint: widget.hint,
                      icon: Container(),
                      focusColor: canceledColor,
                      onChanged: (value) {
                        if (widget.items.isNotEmpty &&
                            widget.items.first != '') {
                          setState(() {
                            widget.value = value;
                          });
                          final index = widget.items.indexOf(value ?? '');
                          widget.onSelectItem!(index);
                        }
                      },
                      items: widget.items.isNotEmpty
                          ? widget.items.map<DropdownMenuItemWidget<String>>(
                              (String value) {
                              return DropdownMenuItemWidget(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                ),
                              );
                            }).toList()
                          : [
                              DropdownMenuItemWidget(
                                value: 'Danh sách rỗng',
                                child: Text(
                                  'Danh sách rỗng',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                ),
                              )
                            ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
