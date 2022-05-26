import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TongSoLuongKhachWidget extends StatefulWidget {
  const TongSoLuongKhachWidget({Key? key}) : super(key: key);

  @override
  State<TongSoLuongKhachWidget> createState() => _TongSoLuongKhachWidgetState();
}

class _TongSoLuongKhachWidgetState extends State<TongSoLuongKhachWidget> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: RichText(
            text: TextSpan(
              text: S.current.tong_so_luong_khach,
              style: textNormal(infoColor, 14),
              children: const <TextSpan>[
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
        spaceW16,
        Expanded(child: textField(onChange: (value) {}))
      ],
    );
  }

  Widget textField({required Function(String) onChange}) {
    return Form(
      key: _key,
      child: TextFormField(
        style: textNormal(color3D5586, 14.0.textScale()),
        onChanged: (value) {
          _key.currentState?.validate();
          onChange(value);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          isDense: true,
          hintText: S.current.nhap_so_luong,
          hintStyle: textNormal(textBodyTime, 14.0.textScale()),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: borderButtomColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderButtomColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderButtomColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderButtomColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderButtomColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        validator: (value) {
          return (value ?? '').checkInt();
        },
      ),
    );
  }
}
