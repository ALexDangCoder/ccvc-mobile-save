import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/radio/radio_button.dart';
import 'package:flutter/material.dart';

class RadioOptionDialog extends StatefulWidget {
  const RadioOptionDialog({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.textRadioAbove,
    required this.textRadioBelow,
    this.textConfirm,
    this.textLeftButton,
    this.textRightButton,
    this.onChange,
  }) : super(key: key);
  final String title;
  final String? textConfirm;
  final String imageUrl;
  final String textRadioAbove;
  final String textRadioBelow;
  final String? textLeftButton;
  final String? textRightButton;
  final Function(bool)? onChange;

  @override
  State<RadioOptionDialog> createState() => _RadioOptionDialogState();
}

class _RadioOptionDialogState extends State<RadioOptionDialog> {
  bool valueSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().dfBtnTxtColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              spaceH40,
              ImageAssets.svgAssets(widget.imageUrl),
              spaceH14,
              Text(
                widget.title,
                style: textNormal(
                  AppTheme.getInstance().titleColor(),
                  18,
                ).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              spaceH20,
              if (widget.textConfirm != null) ...[
                Text(
                  widget.textConfirm ?? '',
                  style: textNormal(
                    AppTheme.getInstance().titleColor(),
                    14,
                  ).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceH20,
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioButton<bool>(
                    value: valueSelected,
                    groupValue: true,
                    onChange: (value) {
                      valueSelected = true;
                      setState(() {});
                    },
                    title: widget.textRadioAbove,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  spaceH20,
                  RadioButton<bool>(
                    value: !valueSelected,
                    groupValue: true,
                    onChange: (value) {
                      valueSelected = false;
                      setState(() {});
                    },
                    title: widget.textRadioBelow,
                    mainAxisSize: MainAxisSize.min,
                  ),
                ],
              ),
              spaceH30,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: DoubleButtonBottom(
                  onClickRight: () {
                    /// return true if radio above selected
                    /// return false if radio below selected
                    Navigator.pop(context, valueSelected);
                    widget.onChange?.call(valueSelected);
                  },
                  onClickLeft: () {
                    Navigator.pop(context);
                  },
                  title1: widget.textLeftButton ?? S.current.khong,
                  title2: widget.textRightButton ?? S.current.dong_y,
                ),
              ),
              spaceH40,
            ],
          ),
        ),
      ),
    );
  }
}
