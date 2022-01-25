import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/custom_select_date_tuy_chon_widgte.dart';

import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/radio/radio_button.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';

import 'package:flutter/material.dart';

class DialogSettingWidget extends StatelessWidget {
  final List<DialogData>? listSelectKey;
  final Function(SelectKey)? onSelect;
  final Widget? customDialog;
  final WidgetType type;
  final Widget? labelWidget;
  const DialogSettingWidget({
    Key? key,
    this.listSelectKey,
    this.onSelect,
    required this.type,
    this.customDialog,
    this.labelWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listSelectKey == null && customDialog == null
        ? const SizedBox()
        : StreamBuilder<WidgetType?>(
            stream: HomeProvider.of(context).homeCubit.showDialogSetting,
            builder: (context, snapshot) {
              return Visibility(
                maintainState: true,
                visible: snapshot.data == type,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().backGroundColor(),
                    boxShadow: [
                      BoxShadow(
                        color: shadowContainerColor.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: borderColor.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: customDialog ??
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelWidget ?? const SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(listSelectKey?.length ?? 0,
                                (index) {
                              final data = listSelectKey![index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 20,
                                ),
                                child: SelectCell(
                                  data: data,
                                  onSelect: (value) {
                                    selectCell(context, value, data);
                                  },
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                ),
              );
            },
          );
  }

  void selectCell(BuildContext context, SelectKey value, DialogData data) {
    if (value == SelectKey.TUY_CHON) {
      if (APP_DEVICE == DeviceType.MOBILE) {
        showBottomSheetCustom(
          context,
          child: CustomSelectDateWidget(
            startDate: data.startDate ?? DateTime.now(),
            endDate: data.endDate ?? DateTime.now(),
            onXacNhan: (startDate, endDate) {
              data.startDate = startDate;
              data.endDate = endDate;
              data.onSelect(
                value,
                startDate,
                endDate,
              );
            },
          ),
          title: S.current.chon_khoang_thoi_gian,
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomSelectDateWidget(
            startDate: data.startDate ?? DateTime.now(),
            endDate: data.endDate ?? DateTime.now(),
            onXacNhan: (startDate, endDate) {
              data.startDate = startDate;
              data.endDate = endDate;
              data.onSelect(
                value,
                startDate,
                endDate,
              );
            },
          ),
        );
      }
    } else {
      data.onSelect(
        value,
        DateTime.now(),
        DateTime.now(),
      );
    }
  }
}

class SelectCell extends StatefulWidget {
  final DialogData data;
  final Function(SelectKey)? onSelect;
  const SelectCell({Key? key, required this.data, this.onSelect})
      : super(key: key);

  @override
  _SelectCellState createState() => _SelectCellState();
}

class _SelectCellState extends State<SelectCell> {
  late SelectKey selectKey;
  @override
  void initState() {
    super.initState();
    selectKey = widget.data.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.data.title,
          style: textNormalCustom(
            fontSize: 16,
            color: AppTheme.getInstance().titleColor(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.data.key.length, (index) {
            final data = widget.data.key[index];
            return screenDevice(
              mobileScreen: Padding(
                padding: EdgeInsets.only(top: index == 0 ? 12 : 8),
                child: MenuSelectCell<SelectKey>(
                  value: data,
                  title: data.getText(),
                  groupValue: selectKey,
                  onChange: (value) {
                    selectKey = value ?? SelectKey.HOM_NAY;
                    if (widget.onSelect != null) {
                      widget.onSelect!(selectKey);
                    }
                    setState(() {});
                  },
                ),
              ),
              tabletScreen: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RadioButton<SelectKey>(
                  value: data,
                  title: data.getText(),
                  groupValue: selectKey,
                  onChange: (value) {
                    selectKey = value ?? SelectKey.HOM_NAY;
                    if (widget.onSelect != null) {
                      widget.onSelect!(selectKey);
                    }
                    setState(() {});
                  },
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}

class MenuSelectCell<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T?) onChange;
  final String title;
  const MenuSelectCell({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: value == groupValue ? buttonColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          title,
          style: textNormalCustom(
            color:
                value == groupValue ? backgroundColorApp : unselectLabelColor,
            fontSize: 14.0.textScale(),
          ),
        ),
      ),
    );
  }
}

class DialogData {
  final String title;
  final List<SelectKey> key;
  final SelectKey initValue;
  final Function(SelectKey, DateTime, DateTime) onSelect;
  DateTime? startDate;
  DateTime? endDate;
  DialogData({
    required this.title,
    this.key = const [
      SelectKey.HOM_NAY,
      SelectKey.TUAN_NAY,
      SelectKey.THANG_NAY,
      SelectKey.NAM_NAY,
      SelectKey.TUY_CHON
    ],
    this.startDate,
    this.endDate,
    this.initValue = SelectKey.HOM_NAY,
    required this.onSelect,
  });
}
