import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetImageMobile extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;

  const WidgetImageMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  _WidgetImageMobileState createState() => _WidgetImageMobileState();
}

class _WidgetImageMobileState extends State<WidgetImageMobile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Image.network(
                widget.cubit.managerPersonalInformationModel
                        .anhDaiDienFilePath ??
                    ImageAssets.icProfile,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    ImageAssets.icProfile,
                  );
                },
              ),
              spaceH12,
              Text(
                S.current.anh_dai_dien,
                style: tokenDetailAmount(
                  fontSize: 12.0.textScale(),
                  color: infoColor,
                ),
              ),
            ],
          ),
        ),
        spaceW16,
        Expanded(
          child: Column(
            children: [
              Image.network(
                widget.cubit.managerPersonalInformationModel.anhChuKyFilePath ??
                    ImageAssets.icProfile,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    ImageAssets.icProfile,
                  );
                },
              ),
              spaceH12,
              Text(
                S.current.anh_chu_ky,
                style: tokenDetailAmount(
                  fontSize: 12.0.textScale(),
                  color: infoColor,
                ),
              ),
            ],
          ),
        ),
        spaceW16,
        Expanded(
          child: Column(
            children: [
              Image.network(
                widget.cubit.managerPersonalInformationModel
                        .anhChuKyNhayFilePath ??
                    ImageAssets.icProfile,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    ImageAssets.icProfile,
                  );
                },
              ),
              spaceH12,
              Text(
                S.current.anh_ky_nhay,
                style: tokenDetailAmount(
                  fontSize: 12.0.textScale(),
                  color: infoColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
