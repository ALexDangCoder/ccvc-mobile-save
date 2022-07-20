import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeDateInputWidget extends StatefulWidget {
  final TimerData? initTimerData;
  final Function(TimerData) onChange;
  final bool isRemoveDidUpdate;

  const TimeDateInputWidget({
    Key? key,
    this.initTimerData,
    required this.onChange,
    this.isRemoveDidUpdate = false,
  }) : super(key: key);

  @override
  _TimeDateInputWidgetState createState() => _TimeDateInputWidgetState();
}

class _TimeDateInputWidgetState extends State<TimeDateInputWidget> {
  final timeFocus = FocusNode();
  final minuteFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeFocus.addListener(() {
      setState(() {});
    });
    minuteFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        timeFocus.requestFocus();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: minuteFocus.hasFocus || timeFocus.hasFocus
                ? AppTheme.getInstance().colorField()
                : borderColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.isRemoveDidUpdate)
              TimeDatePickerRemoveDidUpdate(
                timeFocus: timeFocus,
                minuteFocus: minuteFocus,
                initTimer:
                    widget.initTimerData ?? TimerData(hour: 0, minutes: 0),
                onChange: (value) {
                  widget.onChange(value);
                },
              )
            else
              TimeDatePickerWidget(
                timeFocus: timeFocus,
                minuteFocus: minuteFocus,
                initTimer:
                    widget.initTimerData ?? TimerData(hour: 0, minutes: 0),
                onChange: (value) {
                  widget.onChange(value);
                },
              ),
            SvgPicture.asset(
              ImageAssets.icClock,
              color: minuteFocus.hasFocus || timeFocus.hasFocus
                  ? AppTheme.getInstance().colorField()
                  : textBodyTime,
            )
          ],
        ),
      ),
    );
  }
}

class TimeDatePickerWidget extends StatefulWidget {
  final FocusNode timeFocus;
  final FocusNode minuteFocus;
  final TimerData initTimer;
  final Function(TimerData) onChange;

  const TimeDatePickerWidget({
    Key? key,
    required this.timeFocus,
    required this.minuteFocus,
    required this.initTimer,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TimeDatePickerWidget> createState() => _TimeDatePickerWidgetState();
}

class _TimeDatePickerWidgetState extends State<TimeDatePickerWidget> {
  final timeController = FixedExtentScrollController();
  final minusController = FixedExtentScrollController();
  late TimerData selectDate;

  @override
  void initState() {
    super.initState();
    selectDate = widget.initTimer;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      timeController.jumpToItem(selectDate.hour);
      minusController.jumpToItem(selectDate.minutes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            width: 20,
            child: TimePickerinputWidget(
              textAlign: TextAlign.end,
              focusNode: widget.timeFocus,
              controller: timeController,
              itemCount: 24,
              onChange: (value) {
                selectDate.hour = value;
                widget.onChange(selectDate);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              ':',
              style: textNormal(color3D5586, 14),
            ),
          ),
          SizedBox(
            height: 50,
            width: 20,
            child: TimePickerinputWidget(
              textAlign: TextAlign.start,
              itemCount: 61,
              onChange: (value) {
                selectDate.minutes = value;
                widget.onChange(selectDate);
              },
              focusNode: widget.minuteFocus,
              controller: minusController,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeDatePickerRemoveDidUpdate extends StatefulWidget {
  final FocusNode timeFocus;
  final FocusNode minuteFocus;
  final TimerData initTimer;
  final Function(TimerData) onChange;

  const TimeDatePickerRemoveDidUpdate({
    Key? key,
    required this.timeFocus,
    required this.minuteFocus,
    required this.initTimer,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TimeDatePickerRemoveDidUpdate> createState() =>
      _TimeDatePickerRemoveDidUpdateState();
}

class _TimeDatePickerRemoveDidUpdateState
    extends State<TimeDatePickerRemoveDidUpdate> {
  final timeController = FixedExtentScrollController();
  final minusController = FixedExtentScrollController();
  late TimerData selectDate;

  @override
  void initState() {
    super.initState();
    selectDate = widget.initTimer;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      timeController.jumpToItem(selectDate.hour);
      minusController.jumpToItem(selectDate.minutes);
    });
  }

  @override
  void didUpdateWidget(covariant TimeDatePickerRemoveDidUpdate oldWidget) {
    selectDate = widget.initTimer;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      timeController.jumpToItem(selectDate.hour);
      minusController.jumpToItem(selectDate.minutes);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            width: 20,
            child: TimePickerinputWidget(
              textAlign: TextAlign.end,
              focusNode: widget.timeFocus,
              controller: timeController,
              itemCount: 24,
              onChange: (value) {
                selectDate.hour = value;
                widget.onChange(selectDate);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              ':',
              style: textNormal(color3D5586, 14),
            ),
          ),
          SizedBox(
            height: 50,
            width: 20,
            child: TimePickerinputWidget(
              textAlign: TextAlign.start,
              itemCount: 61,
              onChange: (value) {
                selectDate.minutes = value;
                widget.onChange(selectDate);
              },
              focusNode: widget.minuteFocus,
              controller: minusController,
            ),
          ),
        ],
      ),
    );
  }
}

class TimePickerinputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final FixedExtentScrollController controller;
  final int itemCount;
  final Function(int) onChange;
  final TextAlign textAlign;

  const TimePickerinputWidget({
    Key? key,
    required this.focusNode,
    required this.controller,
    this.itemCount = 1,
    required this.onChange,
    required this.textAlign,
  }) : super(key: key);

  @override
  _TimePickerinputWidgetState createState() => _TimePickerinputWidgetState();
}

class _TimePickerinputWidgetState extends State<TimePickerinputWidget> {
  double opacity = 0;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      if (widget.focusNode.hasFocus) {
        opacity = 1;
        setState(() {});
      }
      if (opacity == 0) {
        widget.controller.jumpToItem(widget.controller.selectedItem);
      }
    });
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus == true) {
        opacity = 1;
        setState(() {});
      } else {
        widget.controller.jumpToItem(widget.controller.selectedItem);
        opacity = 0;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.focusNode.requestFocus();
      },
      child: Stack(
        children: [
          Opacity(
            opacity: 1 - opacity,
            child: TimeTextFieldWidget(
              textAlign: widget.textAlign,
              controller: controller,
              maximun: widget.itemCount,
              focusNode: widget.focusNode,
              onChange: (value) {
                widget.onChange(value);
                widget.controller.jumpToItem(value);
                opacity = 0;
                setState(() {});
              },
            ),
          ),
          Opacity(
            opacity: opacity,
            child: BuildPicker(
              itemCount: widget.itemCount,
              onChange: (value) {
                if (value < 10) {
                  controller.text = '0$value';
                } else {
                  controller.text = value.toString();
                }
                widget.onChange(value);

                controller.selection = TextSelection.collapsed(
                  offset: controller.text.length,
                );
              },
              controller: widget.controller,
              focusNode: widget.focusNode,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildPicker extends StatefulWidget {
  final FocusNode focusNode;
  final FixedExtentScrollController controller;
  final Function(int) onChange;
  final int itemCount;

  const BuildPicker({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.onChange,
    this.itemCount = 1,
  }) : super(key: key);

  @override
  State<BuildPicker> createState() => _BuildPickerState();
}

class _BuildPickerState extends State<BuildPicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const double kItemExtent = 20.0;

    const double kMagnification = 1.02;
    const double kSqueeze = 1;

    return CupertinoPicker(
      useMagnifier: true,
      itemExtent: kItemExtent,
      magnification: kMagnification,
      backgroundColor: Colors.transparent,
      diameterRatio: 3,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      onSelectedItemChanged: (value) {
        widget.onChange(value);
      },
      squeeze: kSqueeze,
      looping: true,
      scrollController: widget.controller,
      children: List.generate(
        widget.itemCount,
        (index) => SizedBox(
          width: 100,
          child: Align(
            child: Text(
              index < 10 ? '0$index' : '$index',
              style: textNormal(
                widget.focusNode.hasFocus
                    ? AppTheme.getInstance().colorField()
                    : color3D5586,
                15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimeTextFieldWidget extends StatefulWidget {
  final FocusNode focusNode;
  final int maximun;
  final TextEditingController controller;
  final Function(int) onChange;
  final TextAlign textAlign;

  const TimeTextFieldWidget({
    Key? key,
    required this.focusNode,
    this.maximun = 24,
    required this.onChange,
    required this.controller,
    required this.textAlign,
  }) : super(key: key);

  @override
  State<TimeTextFieldWidget> createState() => _TimeTextFieldWidgetState();
}

class _TimeTextFieldWidgetState extends State<TimeTextFieldWidget> {
  late final TextEditingController textEditing;
  int selectTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditing = widget.controller;
    if (selectTime < 10) {
      textEditing.text = '0$selectTime';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditing,
      focusNode: widget.focusNode,
      cursorColor: Colors.transparent,
      onChanged: (value) {
        inputTime(value);
      },
      cursorHeight: 0,
      cursorWidth: 0,
      textAlign: widget.textAlign,
      style: textNormal(
        widget.focusNode.hasFocus
            ? AppTheme.getInstance().colorField()
            : color3D5586,
        15,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
      ),
    );
  }

  void inputTime(String value) {
    final int hour = int.parse(value);
    if (hour > widget.maximun) {
      textEditing.text = '0${hour % 10}';
    } else {
      textEditing.text =
          textEditing.text = hour < 10 ? '0$hour' : hour.toString();
    }
    textEditing.selection = TextSelection.collapsed(
      offset: textEditing.text.length,
    );
    widget.onChange(int.parse(textEditing.text));
  }
}

class TimerData {
  int hour;
  int minutes;

  TimerData({required this.hour, required this.minutes});

  String? equalTime(TimerData otherTime) {
    if (hour > otherTime.hour) {
      return S.current.validate_thoi_gian;
    }
    if (hour == otherTime.hour && minutes >= otherTime.minutes) {
      return S.current.validate_thoi_gian;
    }
    return null;
  }
}
