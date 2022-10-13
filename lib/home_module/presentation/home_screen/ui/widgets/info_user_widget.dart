import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/danh_sach_thiep_va_loi_chuc_screen.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/utils/constants/image_asset.dart';

class InfoUserWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;

  const InfoUserWidget({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInformationModel>(
      stream: HomeProvider.of(context).homeCubit.getInforUser,
      builder: (context, snapshot) {
        final data = snapshot.data ?? UserInformationModel();
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${S.current.hello},',
                        style: textNormal(
                          textTitle,
                          16.0.textScale(),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          data.hoTen ?? '',
                          style: titleText(
                            color: textTitle,
                            fontSize: 16.0.textScale(),
                          ),
                        ),
                      )
                    ],
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: '${S.current.hello}, ',
                  //     style: textNormal(
                  //       textTitle,
                  //       16.0.textScale(),
                  //     ),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: data.hoTen,
                  //         style: titleText(
                  //           color: textTitle,
                  //           fontSize: 16.0.textScale(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.chucVu ?? '',
                    style: textNormal(
                      subTitle,
                      14.0.textScale(),
                    ),
                  )
                ],
              ),
            ),
            // Visibility(
            //   visible: data.isSinhNhat(),
            //   child: Expanded(
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 const DanhSachThiepVaLoiChucScreen(),
            //           ),
            //         );
            //       },
            //       child: Container(
            //         color: Colors.transparent,
            //         child: Image.asset(
            //           ImageAssets.icHappyBirthday,
            //           height: 40,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              height: 40.0.textScale(space: 8),
              width: 40.0.textScale(space: 8),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: data.anhDaiDienFilePath ?? '',
                errorWidget: (context, url, error) => Container(
                  color: Colors.black,
                  child: Image.asset(ImageAssets.anhDaiDienMacDinh),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
