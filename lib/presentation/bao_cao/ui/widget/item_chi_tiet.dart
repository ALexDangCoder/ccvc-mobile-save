import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/ui/mobile/chia_se_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemChiTiet extends StatelessWidget {
  const ItemChiTiet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.bac_cao),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: SvgPicture.asset(ImageAssets.icNameFile),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  S.current.phuong_xa,
                                  style: textNormalCustom(
                                    color: textTitle,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                S.current.k_hoat_dong,
                                style: tokenDetailAmount(
                                  color: AqiColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: toDayColor.withOpacity(0.5),
                    ),
                    //  spaceH16
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
