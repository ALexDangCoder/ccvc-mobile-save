import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_item.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/mequee_widget.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class PrevViewWidget extends StatefulWidget {
  const PrevViewWidget({Key? key}) : super(key: key);

  @override
  _PrevViewWidgetState createState() => _PrevViewWidgetState();
}

class _PrevViewWidgetState extends State<PrevViewWidget> {
  WidgetManageCubit cubit = WidgetManageCubit();
  HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.loadApi();
    homeCubit.loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.xem_truoc_widget,
      ),
      body: HomeProvider(
        homeCubit: homeCubit,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 65,
                color: Colors.transparent,
                margin: const EdgeInsets.only(left: 16),
                child: const MarqueeWidget(),
              ),
              Container(
                color: homeColor,
                child: StreamBuilder<List<WidgetModel>>(
                  stream: cubit.listWidgetUsing,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <WidgetModel>[];
                    if (data.isNotEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(data.length, (index) {
                          final type = data[index];
                          return type.widgetType?.getItemsMobile() ??
                              const SizedBox();
                        }),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
