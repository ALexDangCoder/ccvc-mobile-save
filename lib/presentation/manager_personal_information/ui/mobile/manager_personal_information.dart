import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/images.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_image_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_thong_tin.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: BaseAppBar(
        title: S.current.manager_information,
        leadingIcon: IconButton(
          icon: SvgPicture.asset('$baseImg/ic_vector.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('$baseImg/ic_edit_manager_person.svg'),
          ),
          spaceW10
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: backgroundColorApp,
          padding: const EdgeInsets.only(top: 2, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WidgetThongTinMobile(),
              spaceH20,
              const WidgetDonVibMobile(),
              spaceH20,
              const WidgetUngDungMobile(),
              spaceH20,
              const WidgetImageMobile(),
              spaceH24,
            ],
          ),
        ),
      ),
    );
  }
}
