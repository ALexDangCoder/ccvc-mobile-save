import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum LANGUAGE { vn, en }

class LanguageWidget extends StatelessWidget {
  final String image;
  final String text;
  final bool reverse;

  const LanguageWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reverse
        ? Row(
            children: [
              SvgPicture.asset(image),
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: textNormalCustom(
                  color: textTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              )
            ],
          )
        : Row(
            children: [
              Text(
                text,
                style: textNormalCustom(
                  color: textTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SvgPicture.asset(image),
            ],
          );
  }
}

extension GetLanguage on LANGUAGE {
  Widget languageLeftWidget() {
    switch (this) {
      case LANGUAGE.vn:
        return LanguageWidget(
          image: ImageAssets.icVn,
          reverse: true,
          text: S.current.tieng_viet,
        );

      case LANGUAGE.en:
        return LanguageWidget(
          image: ImageAssets.icEn,
          reverse: true,
          text: S.current.english,
        );
    }
  }

  Widget languageRightWidget() {
    switch (this) {
      case LANGUAGE.en:
        return LanguageWidget(
          image: ImageAssets.icVn,
          reverse: false,
          text: S.current.tieng_viet,
        );

      case LANGUAGE.vn:
        return LanguageWidget(
          image: ImageAssets.icEn,
          reverse: false,
          text: S.current.english,
        );
    }
  }
}
