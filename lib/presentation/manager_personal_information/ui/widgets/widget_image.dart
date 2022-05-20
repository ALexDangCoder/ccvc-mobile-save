import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WigetImage extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;

  const WigetImage({Key? key, required this.cubit}) : super(key: key);

  @override
  _WigetImageState createState() => _WigetImageState();
}

class _WigetImageState extends State<WigetImage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 150,
              width: 155,
              decoration: BoxDecoration(
                border: Border.all(color: color80CACFD7.withOpacity(0.3)),
                shape: BoxShape.circle,
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: colorE4E9FD.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: widget.cubit.managerPersonalInformationModel
                          .anhDaiDienFilePath ??
                      '',
                  errorWidget: (_, __, ___) {
                    return Container(
                      padding: const EdgeInsets.all(54.0),
                      child: SvgPicture.asset(ImageAssets.icImage),
                    );
                  },
                ),
              ),
            ),
            spaceH24,
            Text(
              S.current.anh_dai_dien,
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: color667793,
              ),
            ),
          ],
        ),
        spaceW56,
        Column(
          children: [
            Container(
              height: 150,
              width: 155,
              decoration: BoxDecoration(
                border: Border.all(color: color80CACFD7.withOpacity(0.3)),
                shape: BoxShape.circle,
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: colorE4E9FD.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: widget.cubit.managerPersonalInformationModel
                          .anhChuKyFilePath ??
                      '',
                  errorWidget: (_, __, ___) {
                    return Container(
                      padding: const EdgeInsets.all(54.0),
                      child: SvgPicture.asset(ImageAssets.icImage),
                    );
                  },
                ),
              ),
            ),
            spaceH24,
            Text(
              S.current.anh_chu_ky,
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: color667793,
              ),
            ),
          ],
        ),
        spaceW56,
        Column(
          children: [
            Container(
              height: 150,
              width: 155,
              decoration: BoxDecoration(
                border: Border.all(color: color80CACFD7.withOpacity(0.3)),
                shape: BoxShape.circle,
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: colorE4E9FD.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: widget.cubit.managerPersonalInformationModel
                          .anhChuKyNhayFilePath ??
                      '',
                  errorWidget: (_, __, ___) {
                    return Container(
                      padding: const EdgeInsets.all(54.0),
                      child: SvgPicture.asset(ImageAssets.icImage),
                    );
                  },
                ),
              ),
            ),
            spaceH24,
            Text(
              S.current.anh_ky_nhay,
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: color667793,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
