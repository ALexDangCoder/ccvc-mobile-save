import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class VBDiTheoDoiVanBanBanHanhExpandWidget extends StatelessWidget {
  const VBDiTheoDoiVanBanBanHanhExpandWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        physics: const  AlwaysScrollableScrollPhysics(),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: NodataWidget(),
            )
          ],
        ),
      ),
    );
  }
}
