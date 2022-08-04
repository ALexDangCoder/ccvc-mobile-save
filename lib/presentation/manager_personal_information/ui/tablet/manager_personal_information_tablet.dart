import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/edit_personal_information_tablet.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_don_vi.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_image.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_thong_tin_left.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_thong_tin_right.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_ung_dung.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/bloc/main_cubit.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/tabbar_item.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerPersonalInformationTablet extends StatefulWidget {
  final String id;

  const ManagerPersonalInformationTablet({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ManagerPersonalInformationTabletState createState() =>
      _ManagerPersonalInformationTabletState();
}

class _ManagerPersonalInformationTabletState
    extends State<ManagerPersonalInformationTablet> {
  final ManagerPersonalInformationCubit _cubit =
      ManagerPersonalInformationCubit();

  @override
  void initState() {
    // TODO: implement initState
    _cubit.loadApi(id: widget.id);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ProviderWidget.of<MainCubit>(context)
          .cubit
          .selectDoubleTapTabBar
          .listen((event) {
        if (event == TabBarType.menu) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgManagerColor,
      appBar: BaseAppBar(
        title: S.current.manager_information,
        leadingIcon: IconButton(
          icon: SvgPicture.asset(ImageAssets.icVector),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPersonInformationTabletScreen(
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
            child: SvgPicture.asset(ImageAssets.icManager),
          ),
          spaceW30
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
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderItemCalender.withOpacity(0.5),
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      top: 28,
                      left: 30,
                      right: 30,
                      bottom: 28,
                    ),
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 33,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.thong_tin,
                          style: titleAppbar(fontSize: 16.0.textScale()),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: WidgetThongTinLeft(
                                cubit: _cubit,
                              ),
                            ),
                            spaceW30,
                            Expanded(
                              child: WidgetThongTinRight(
                                cubit: _cubit,
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Container(
                          height: 1,
                          color: borderItemCalender,
                        ),
                        spaceH28,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: WidgetDonVi(
                                cubit: _cubit,
                                isCheckTitle: true,
                              ),
                            ),
                            spaceW30,
                            Expanded(
                              child: WidgetUngDung(
                                cubit: _cubit,
                                isCheckTitle: true,
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Container(
                          height: 1,
                          color: borderItemCalender,
                        ),
                        spaceH28,
                        WigetImage(
                          cubit: _cubit,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
