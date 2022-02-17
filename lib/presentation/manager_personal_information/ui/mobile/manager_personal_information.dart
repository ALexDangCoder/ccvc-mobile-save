import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/edit_personal_information.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_image_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_thong_tin.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerPersonalInformation extends StatefulWidget {
  const ManagerPersonalInformation({Key? key}) : super(key: key);

  @override
  _ManagerPersonalInformationState createState() =>
      _ManagerPersonalInformationState();
}

class _ManagerPersonalInformationState
    extends State<ManagerPersonalInformation> {
  final ManagerPersonalInformationCubit _cubit =
      ManagerPersonalInformationCubit();

  @override
  void initState() {
    // TODO: implement initState
    _cubit.getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: BaseAppBar(
        title: S.current.manager_information,
        leadingIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset(ImageAssets.icBack),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPersonInformationScreen(
                    managerPersonalInformationModel:
                        _cubit.managerPersonalInformationModel,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              ImageAssets.icManager,
              width: 17,
              height: 17,
            ),
          ),
          spaceW10
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder<ManagerPersonalInformationModel>(
          stream: _cubit.managerStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              color: backgroundColorApp,
              padding: const EdgeInsets.only(top: 2, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetThongTinMobile(
                    cubit: _cubit,
                  ),
                  spaceH20,
                  WidgetDonVibMobile(
                    cubit: _cubit,
                  ),
                  spaceH20,
                  WidgetUngDungMobile(
                    cubit: _cubit,
                  ),
                  spaceH20,
                  WidgetImageMobile(
                    cubit: _cubit,
                  ),
                  spaceH24,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
