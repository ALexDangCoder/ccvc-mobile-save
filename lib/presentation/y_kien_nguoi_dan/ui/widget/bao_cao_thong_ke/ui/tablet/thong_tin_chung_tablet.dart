import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/filter_date_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/menu_y_kien_nguoi_dan_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongTinChungYKNDTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDTabletState createState() =>
      _ThongTinChungYKNDTabletState();
}

class _ThongTinChungYKNDTabletState extends State<ThongTinChungYKNDTablet>
    with SingleTickerProviderStateMixin {
  YKienNguoiDanCubitt cubit = YKienNguoiDanCubitt();
  ChooseTimeCubit chooseTimeScreen = ChooseTimeCubit();

  @override
  void initState() {
    super.initState();
    cubit.initTimeRange();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: MenuYKIenNguoiDanTablet(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', S.current.something_went_wrong),
          stream: cubit.stateStream,
          child: SizedBox.expand(
            child: Container(
              color: colorEEF3FF,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12,),
                        decoration: BoxDecoration(
                          color: colorFFFFFF,
                          border: Border.all(
                            color: colorDBDFEF.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color6566E9.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            FilterDateTablet(
                              onChooseDateFilter:
                                  (DateTime startDate, DateTime endDate) {},
                              context: context,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 4,
                              child: TextField(
                                onChanged: (text) {

                                },
                                onSubmitted: (text) {

                                },
                                decoration: InputDecoration(
                                  prefixIcon: SizedBox(
                                    width: 36,
                                    height: 14,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: SvgPicture.asset(
                                          ImageAssets.ic_KinhRong,
                                          color: AppTheme.getInstance().colorField(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 26,
                                    minHeight: 26,
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
                                  isCollapsed: true,
                                  fillColor: colorE2E8F0.withOpacity(0.1),
                                  filled: true,
                                  hintText: S.current.tiem_kiem,
                                  hintStyle: textNormal(
                                    colorB9C4D0,
                                    14,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: colorE2E8F0),
                                  ),
                                ),
                              ),
                            )
                            // Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 66),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorDBDFEF.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color6566E9.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: TiepCanWidget(),
                          ),
                          SizedBox(
                            width: 115,
                          ),
                          Expanded(
                            child: XuLyWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
