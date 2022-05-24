import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/debouncer.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/bloc/phat_ban_tin_bloc.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'item_search_tablet.dart';

class SearchBanTinBtnSheet extends StatefulWidget {
  final ChuDeCubit cubit;

  const SearchBanTinBtnSheet({Key? key, required this.cubit}) : super(key: key);

  @override
  _SearchBanTinBtnSheetState createState() => _SearchBanTinBtnSheetState();
}

class _SearchBanTinBtnSheetState extends State<SearchBanTinBtnSheet> {
  PhatBanTinBloc phatBanTinBloc = PhatBanTinBloc();
  AudioPlayer player = AudioPlayer();
  late final Debouncer _debounce;

  @override
  void initState() {
    _debounce = Debouncer(milliseconds: 500);
    widget.cubit.addNull();
    widget.cubit.search(
      widget.cubit.getDateMonth(),
      DateTime.now().formatApiEndDay,
      '',
    );

    super.initState();

  }

  @override
  void dispose() {
    widget.cubit.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          BaseSearchBar(
            onChange: (value) {
              _debounce.run(() {
                widget.cubit.search(
                  widget.cubit.getDateMonth(),
                  DateTime.now().formatApiEndDay,
                  value,
                );
              });
            },
          ),
          Expanded(
            child: StateStreamLayout(
              textEmpty: S.current.khong_co_thong_tin,
              retry: () {
                widget.cubit.search(
                  widget.cubit.getDateMonth(),
                  DateTime.now().formatApiEndDay,
                  '',
                );
              },
              error: AppException(
                S.current.something_went_wrong,
                S.current.something_went_wrong,
              ),
              stream: widget.cubit.stateStream,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder<List<TinTucData>?>(
                      stream: widget.cubit.listDataSearch,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return snapshot.data != null
                            ? data.isNotEmpty
                                ? ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ItemSearch(
                                        title: data[index].title,
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewScreen(
                                                url: data[index].url,
                                                title: '',
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : NodataWidget(
                                    title: S.current.khong_co_thong_tin,
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
