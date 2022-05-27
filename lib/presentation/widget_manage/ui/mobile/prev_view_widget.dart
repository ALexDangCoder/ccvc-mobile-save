import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/mequee_widget.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/preview_widget_item.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class PrevViewWidget extends StatefulWidget {
  final WidgetManageCubit cubit;

  const PrevViewWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _PrevViewWidgetState createState() => _PrevViewWidgetState();
}

class _PrevViewWidgetState extends State<PrevViewWidget> {
  HomeCubit homeCubit = HomeCubit();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit.loadApi();
  }

  @override
  void dispose() {
    super.dispose();
    homeCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.xem_truoc_widget,
      ),
      body: HomeProvider(
        homeCubit: homeCubit,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: homeColor,
                    child: StreamBuilder<List<WidgetModel>>(
                      stream: widget.cubit.listWidgetUsing,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? <WidgetModel>[];
                        if (data.isNotEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(data.length, (index) {
                              final type = data[index];
                              return type.widgetType?.getItemsMobilePreview() ??
                                  const SizedBox();
                            }),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: backgroundColorApp,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: const MarqueeWidget(),
                  )
                ],
              ),
              Positioned.fill(
                child: Container(
                  width: double.maxFinite,
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
