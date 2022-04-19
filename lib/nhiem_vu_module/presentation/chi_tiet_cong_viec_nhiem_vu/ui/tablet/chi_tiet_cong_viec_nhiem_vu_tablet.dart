import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/widget/widget_thong_tin_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChitietCongViecNhiemVuTablet extends StatefulWidget {
  final String id;

  const ChitietCongViecNhiemVuTablet({Key? key, required this.id})
      : super(key: key);

  @override
  _ChitietCongViecNhiemVuTabletState createState() =>
      _ChitietCongViecNhiemVuTabletState();
}

class _ChitietCongViecNhiemVuTabletState
    extends State<ChitietCongViecNhiemVuTablet> {
  ChiTietCongViecNhiemVuCubit cubit = ChiTietCongViecNhiemVuCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getChiTietCongViecNhiemVu(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.chi_tiet_cong_viec),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.getChiTietCongViecNhiemVu(widget.id);
        },
        child: ProviderWidget<ChiTietCongViecNhiemVuCubit>(
          cubit: cubit,
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: cubit.stateStream,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    StreamBuilder<ChiTietCongViecNhiemVuModel>(
                      stream: cubit.chiTietCongViecSubject,
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        return WidgetThongTinCongViecNhiemVu(
                          cubit: cubit,
                          data: data ?? ChiTietCongViecNhiemVuModel(),
                        );
                      },
                    ),
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
