import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/radio/cuctom_radio_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

class NguoiThamGiaWidget extends StatefulWidget {
  final String title;

  NguoiThamGiaWidget({required this.title});

  @override
  State<NguoiThamGiaWidget> createState() => _NguoiThamGiaWidgetState();
}

class _NguoiThamGiaWidgetState extends State<NguoiThamGiaWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: radioUnfocusColor.withOpacity(0.1),
        border: Border.all(color: bgDropDown),
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  S.current.nguoi_tham_gia,
                  style: tokenDetailAmount(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  widget.title,
                  style: textNormalCustom(
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: CustomRadioButtonCheck(
                canSelect: true,
                isTheRadio: false,
                onSelectItem: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
