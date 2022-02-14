import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/edit_personal_information_tablet.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_don_vi.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_image.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_thong_tin_left.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_thong_tin_right.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_ung_dung.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerPersonalInformationTablet extends StatefulWidget {
  const ManagerPersonalInformationTablet({Key? key}) : super(key: key);

  @override
  _ManagerPersonalInformationTabletState createState() =>
      _ManagerPersonalInformationTabletState();
}

class _ManagerPersonalInformationTabletState
    extends State<ManagerPersonalInformationTablet> {
  @override
  Widget build(BuildContext context) {
    final ManagerPersonalInformationCubit _cubit =
        ManagerPersonalInformationCubit();
    return Scaffold(
      backgroundColor: bgManagerColor,
      appBar: BaseAppBar(
        backGroundColor: bgCalenderColor,
        title: S.current.manager_information,
        leadingIcon: IconButton(
          icon: SvgPicture.asset(ImageAssets.icVector),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPersonInformationTabletScreen(
                    managerPersonalInformationModel:
                        _cubit.managerPersonalInformationModel,
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icManager),
          ),
          spaceW30
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColorApp,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderItemCalender.withOpacity(0.5)),
          ),
          margin:
              const EdgeInsets.only(top: 28, left: 30, right: 30, bottom: 156),
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.thong_tin,
                style: titleAppbar(fontSize: 16.0.textScale()),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: WidgetThongTinLeft(),
                  ),
                  Expanded(
                    child: WidgetThongTinRight(),
                  )
                ],
              ),
              spaceH28,
              Container(
                height: 1,
                color: borderItemCalender,
              ),
              spaceH28,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: WidgetDonVi(),
                  ),
                  Expanded(
                    child: WidgetUngDung(),
                  )
                ],
              ),
              spaceH28,
              Container(
                height: 1,
                color: borderItemCalender,
              ),
              spaceH28,
              const WigetImage(),
            ],
          ),
        ),
      ),
    );
  }
}
