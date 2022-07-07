import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/edit_personal_information.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_image_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_thong_tin.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerPersonalInformation extends StatefulWidget {
  final String id;

  const ManagerPersonalInformation({Key? key, required this.id})
      : super(key: key);

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
    _cubit.loadApi(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        Navigator.pop(context,_cubit.checkLoad);
        return true;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: BaseAppBar(
          title: S.current.manager_information,
          leadingIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(ImageAssets.icBack),
              onPressed: () {
                Navigator.pop(context, _cubit.checkLoad);
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
                      id: widget.id,
                    ),
                  ),
                ).then((value) {
                  if (value == true) {

                    _cubit.loadApi(id: widget.id);
                    _cubit.checkLoad = true;
                  } else if (value == null) {
                    _cubit.checkLoad = false;
                    return;
                  }
                  return;
                });
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
        body: ProviderWidget(
          cubit: _cubit,
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException('1', ''),
            stream: _cubit.stateStream,
            child: RefreshIndicator(
              onRefresh: () async {
                await _cubit.loadApi(id: widget.id);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: StreamBuilder<ManagerPersonalInformationModel>(
                  stream: _cubit.managerStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
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
            ),
          ),
        ),
      ),
    );
  }
}
