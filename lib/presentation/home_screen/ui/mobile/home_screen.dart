import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_item.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/thong_bao_message_widget.dart';
import 'package:ccvc_mobile/presentation/search_screen/ui/mobile/search_screen.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/thong_bao_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final keyHomeMobile = GlobalKey<_HomeScreenMobileState>();

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  ScrollController scrollController = ScrollController();
  HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit.loadApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      homeCubit: homeCubit,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: homeCubit.stateStream,
        child: Scaffold(
          backgroundColor: homeColor,
          appBar: AppBar(
            elevation: 0,
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const SearchScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  ImageAssets.icSearchWhite,
                  height: 18,
                  width: 18,
                ),
              ),
            ),
            title: Text(
              S.current.home,
              style: textNormalCustom(
                fontSize: 18,
                color: AppTheme.getInstance().backGroundColor(),
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.appBarBackground),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ThongBaoScreen(),
                      ),
                    );
                  },
                  child: const SizedBox(
                    width: 24,
                    height: 25,
                    child: ThongBaoWidget(
                      sum: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            },
            child: SizedBox.expand(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    const HeaderWidget(),
                    StreamBuilder<List<WidgetModel>>(
                      stream: homeCubit.getConfigWidget,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? <WidgetModel>[];
                        if (data.isNotEmpty) {
                          return Column(
                            children: List.generate(data.length, (index) {
                              final type = data[index];
                              return type.widgetType?.getItemsMobile() ??
                                  const SizedBox();
                            }),
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
