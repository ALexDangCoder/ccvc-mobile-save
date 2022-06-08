import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class VBDiTheoDoiVanBanBanHanhExpandWidget extends StatefulWidget {
  final TrackTextDetailDocumentCubit cubit;
  final String id;
  final bool isTablet;

  const VBDiTheoDoiVanBanBanHanhExpandWidget({
    Key? key,
    required this.cubit,
    required this.id,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<VBDiTheoDoiVanBanBanHanhExpandWidget> createState() =>
      _VBDiTheoDoiVanBanBanHanhExpandWidgetState();
}

class _VBDiTheoDoiVanBanBanHanhExpandWidgetState
    extends State<VBDiTheoDoiVanBanBanHanhExpandWidget> {
  @override
  void initState() {
    widget.cubit.getTheoDoiVanBan(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getTheoDoiVanBan(widget.id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getTheoDoiVanBan(widget.id);
        },
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: NodataWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
