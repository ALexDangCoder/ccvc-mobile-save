import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/tra_cuu_van_ban_phap_luat_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/tra_cuu_van_ban_phap_luat/bloc/tra_cuu_van_ban_phap_luat_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/tra_cuu_van_ban_phap_luat/ui/tablet/ui/widget_tra_cuu_van_ban_phap_luat_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class TraCuuVanBanPhapLuatTablet extends StatefulWidget {
  const TraCuuVanBanPhapLuatTablet({Key? key}) : super(key: key);

  @override
  _TraCuuVanBanPhapLuatTabletState createState() =>
      _TraCuuVanBanPhapLuatTabletState();
}

class _TraCuuVanBanPhapLuatTabletState
    extends State<TraCuuVanBanPhapLuatTablet> {
  late TraCuuVanBanPhapLuatCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TraCuuVanBanPhapLuatCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.tra_cuu_van_ban_phap_luat),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: BaseSearchBar(
              hintText: S.current.tim_kiem_theo_trich_yeu,
              onChange: (value) {
                setState(() {});
                cubit.search = value;
              },
            ),
          ),
          Expanded(
            child: _content(),
          )
        ],
      ),
    );
  }

  void callApi(int page) {
    cubit.getTraCuuVanBanPhapLuat(page, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {
        callApi(
          page,
        )
      },
      viewItem: (value, index) => WidgetTraCuuVanBanPhapLuatTablet(
        data: value as TraCuuVanBanPhapLuatModel,
        index: index ?? 0,
      ),
    );
  }
}
