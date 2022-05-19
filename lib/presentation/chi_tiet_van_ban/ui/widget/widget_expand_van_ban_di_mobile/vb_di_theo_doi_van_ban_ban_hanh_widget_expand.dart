
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class VBDiTheoDoiVanBanBanHanhExpandWidget extends StatelessWidget {
  const VBDiTheoDoiVanBanBanHanhExpandWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: NodataWidget(),
          ),
        ),
      ],
    );
  }
}
