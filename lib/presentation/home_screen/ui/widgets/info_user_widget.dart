import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class InfoUserWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const InfoUserWidget({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataUser>(
        stream: HomeProvider.of(context).homeCubit.getUserInformation,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataUser();
          final result = data.userInformation;
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${S.current.hello}, ',
                      style: textNormal(
                        AppTheme.getInstance().titleColor(),
                        16.0.textScale(),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: result?.hoTen ?? '',
                          style: titleText(
                            color: AppTheme.getInstance().titleColor(),
                            fontSize: 16.0.textScale(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    result?.chucVu ?? '',
                    style: textNormal(
                      subTitle,
                      14.0.textScale(),
                    ),
                  )
                ],
              ),
              Container(
                height: 40.0.textScale(space: 8),
                width: 40.0.textScale(space: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              )
            ],
          );
        });
  }
}
