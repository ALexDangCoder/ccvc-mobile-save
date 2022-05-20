import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/tra_cuu_van_ban_phap_luat_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/tra_cuu_van_ban_phap_luat/bloc/tra_cuu_van_ban_phap_luat_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TraCuuVanBanPhapLuatMobile extends StatefulWidget {
  const TraCuuVanBanPhapLuatMobile({Key? key}) : super(key: key);

  @override
  _TraCuuVanBanPhapLuatMobileState createState() =>
      _TraCuuVanBanPhapLuatMobileState();
}

class _TraCuuVanBanPhapLuatMobileState
    extends State<TraCuuVanBanPhapLuatMobile> {
  late TraCuuVanBanPhapLuatCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TraCuuVanBanPhapLuatCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.tra_cuu_van_ban_phap_luat),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
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
      viewItem: (value, index) => itemTraCuuVanBan(
          value as TraCuuVanBanPhapLuatModel, index ?? 0, context),
    );
  }
}

Widget itemTraCuuVanBan(
    TraCuuVanBanPhapLuatModel data, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      bottom: 16,
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorE2E8F0),
        borderRadius: BorderRadius.circular(10.0),
        color: colorE2E8F0.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    S.current.ngay_bh,
                    style: textNormalCustom(
                      color: color667793,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    data.day ?? '',
                    style: textNormalCustom(
                      color: color667793,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    S.current.trich_yeu,
                    style: textNormalCustom(
                      color: color667793,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => WebViewScreen(
                            title: '',
                            url: data.url ?? '',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      data.title ?? '',
                      style: textNormalCustom(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getInstance().colorField()),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
