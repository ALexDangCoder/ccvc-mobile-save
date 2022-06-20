import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/radio/radio_button.dart';
import 'package:flutter/material.dart';

class ThemLinkHopDialog extends StatefulWidget {
  const ThemLinkHopDialog({
    Key? key,
    this.title,
    this.imageUrl,
    this.textRadioAbove,
    this.textRadioBelow,
    this.isConfirm = true,
    this.textConfirm,
  }) : super(key: key);
  final String? title;
  final String? textConfirm;
  final String? imageUrl;
  final String? textRadioAbove;
  final String? textRadioBelow;
  final bool isConfirm;

  @override
  State<ThemLinkHopDialog> createState() => _ThemLinkHopDialogState();
}

class _ThemLinkHopDialogState extends State<ThemLinkHopDialog> {
  bool isLinkHeThong = true;

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
              ImageAssets.svgAssets(widget.imageUrl ?? ImageAssets.icLink),
              spaceH14,
              Text(
                widget.title ?? S.current.them_link_hop,
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
              Center(
                child: RadioButton<bool>(
                  value: isLinkHeThong,
                  groupValue: true,
                  onChange: (value) {
                    isLinkHeThong = true;
                    setState(() {});
                  },
                  title: widget.textRadioAbove ?? S.current.link_trong_he_thong,
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              spaceH20,
              RadioButton<bool>(
                value: !isLinkHeThong,
                groupValue: true,
                onChange: (value) {
                  isLinkHeThong = false;
                  setState(() {});
                },
                title: widget.textRadioBelow ?? S.current.link_ngoai_he_thong,
                mainAxisSize: MainAxisSize.min,
              ),
              spaceH30,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: DoubleButtonBottom(
                  onPressed2: () {
                    Navigator.pop(context, isLinkHeThong);
                  },
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  title1: S.current.khong,
                  title2:
                      widget.isConfirm ? S.current.xac_nhan : S.current.dong_y,
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
