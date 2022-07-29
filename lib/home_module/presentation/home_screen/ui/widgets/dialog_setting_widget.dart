import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/widgets/custom_select_date_tuy_chon_widgte.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';
import '/home_module/utils/extensions/date_time_extension.dart';
import '/home_module/widgets/radio/radio_button.dart';
import '/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';

class DialogSettingWidget extends StatefulWidget {
  final List<DialogData>? listSelectKey;
  final Function(SelectKey)? onSelect;
  final Widget? customDialog;
  final WidgetType type;
  final Widget? labelWidget;
  final Function()? onLabel;

  const DialogSettingWidget({
    Key? key,
    this.listSelectKey,
    this.onSelect,
    required this.type,
    this.customDialog,
    this.labelWidget,
    this.onLabel,
  }) : super(key: key);

  @override
  State<DialogSettingWidget> createState() => _DialogSettingWidgetState();
}

class _DialogSettingWidgetState extends State<DialogSettingWidget> {
  final _key = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  late ScrollController controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = HomeProvider.of(context).controller;
  }

  @override
  Widget build(BuildContext context) {
    return widget.customDialog != null
        ? StreamBuilder(
            stream: HomeProvider.of(context).homeCubit.showDialogSetting,
            builder: (context, snapshot) {
              return Visibility(
                maintainState: true,
                visible: snapshot.data == widget.type,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: backgroundColorApp,
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: borderColor.withOpacity(0.5)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: widget.customDialog!,
                ),
              );
            },
          )
        : GestureDetector(
            onTap: () {
              HomeProvider.of(context).homeCubit.closeDialog();
              showSelect(context);
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                key: _key,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: Colors.transparent,
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(ImageAssets.icMore),
              ),
            ),
          );
  }

  void showSelect(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final box = _key.currentContext?.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return DialogSelectWidget(
          listSelectKey: widget.listSelectKey,
          offset: position,
          layerLink: _layerLink,
          controller: controller,
          labelWidget: widget.labelWidget,
          customDialog: widget.customDialog,
          onLabel: widget.onLabel,
          onDismis: () {
            overlayEntry.remove();
          },
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}

class DialogSelectWidget extends StatefulWidget {
  final List<DialogData>? listSelectKey;
  final Function(SelectKey)? onSelect;
  final Widget? customDialog;
  final Offset offset;
  final Widget? labelWidget;
  final Function() onDismis;
  final LayerLink layerLink;
  final ScrollController controller;
  final Function()? onLabel;

  const DialogSelectWidget({
    Key? key,
    this.listSelectKey,
    this.onSelect,
    this.customDialog,
    this.labelWidget,
    required this.offset,
    required this.onDismis,
    required this.layerLink,
    required this.controller,
    this.onLabel,
  }) : super(key: key);

  @override
  State<DialogSelectWidget> createState() => _DialogSelectWidgetState();
}

class _DialogSelectWidgetState extends State<DialogSelectWidget>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey();
  double insertBottom = 0;
  bool isShowTp = true;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    )..forward();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final offsetDialog = _key.currentContext?.size?.height ?? 0;
      final double insertBottomDialog = insertBottom - offsetDialog - 120;
      if (insertBottomDialog < 0) {
        isShowTp = false;
        setState(() {});
        // widget.controller.jumpTo(
        //   widget.controller.offset + (-insertBottomDialog),
        // );
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    insertBottom = MediaQuery.of(context).size.height - widget.offset.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              animationController.reverse().whenComplete(() {
                widget.onDismis();
              });
            },
            child: SizedBox.expand(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              followerAnchor:
                  isShowTp ? Alignment.topRight : Alignment.bottomRight,
              targetAnchor: isShowTp ? Alignment.bottomLeft : Alignment.topLeft,
              // offset: Offset(10.0.textScale(space: -7), 20),
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, _) => Opacity(
                  opacity: animationController.value,
                  child: Container(
                    key: _key,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: borderColor.withOpacity(0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: widget.customDialog ??
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.onLabel != null) {
                                    widget.onDismis();
                                    widget.onLabel!();
                                  }
                                },
                                child: widget.labelWidget ?? const SizedBox(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    widget.listSelectKey?.length ?? 0, (index) {
                                  final data = widget.listSelectKey![index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: index == 0 ? 0 : 20,
                                    ),
                                    child: SelectCell(
                                      data: data,
                                      onSelect: (value) {
                                        widget.onDismis();
                                        selectCell(context, value, data);
                                      },
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectTime(SelectKey value, DialogData data) {
    switch (value) {
      case SelectKey.HOM_NAY:
        final result = DateTime.now().dateTimeFormRange();
        data.onSelect(value, result[0], result[1]);
        break;
      case SelectKey.TUAN_NAY:
        final result =
            DateTime.now().dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
        data.onSelect(value, result[0], result[1]);
        break;
      case SelectKey.THANG_NAY:
        final result =
            DateTime.now().dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
        data.onSelect(value, result[0], result[1]);
        break;
      case SelectKey.NAM_NAY:
        final result =
            DateTime.now().dateTimeFormRange(timeRange: TimeRange.NAM_NAY);
        data.onSelect(value, result[0], result[1]);
        break;
      default:
        {
          data.onSelect(value, DateTime.now(), DateTime.now());
          return;
        }
    }
  }

  void selectCell(BuildContext context, SelectKey value, DialogData data) {
    if (value == SelectKey.TUY_CHON) {
      widget.onDismis();
      if (isMobile()) {
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
      selectTime(value, data);
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
            color: textTitle,
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
          color: value == groupValue
              ? AppTheme.getInstance().colorSelect()
              : Colors.transparent,
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
    ],
    this.startDate,
    this.endDate,
    this.initValue = SelectKey.HOM_NAY,
    required this.onSelect,
  });
}
