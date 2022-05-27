import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

enum stateLDM { ChoXacNhan, ThamGia, TuChoi }

extension StateLichHop on stateLDM {
  bool? getListState (stateLDM state) {
    if (this == state) {
      return true;
    } else {
      return null;
    }
  }
}

extension StateLDM on stateLDM {
  int getIndex(DashBoardLichHopModel model) {
    switch (this) {
      case stateLDM.ChoXacNhan:
        return model.soLichChoXacNhan ?? 0;

      case stateLDM.ThamGia:
        return model.soLichThamGia ?? 0;

      case stateLDM.TuChoi:
        return model.soLichChuTriTuChoi ?? 0;
    }
  }

  int getIndexLichHop(DashBoardLichHopModel model) {
    switch (this) {
      case stateLDM.ChoXacNhan:
        return model.soLichChoXacNhan ?? 0;

      case stateLDM.ThamGia:
        return model.soLichThamGia ?? 0;

      case stateLDM.TuChoi:
        return model.soLichChuTriTuChoi ?? 0;
    }
  }

  Widget getState(int index) {
    switch (this) {
      case stateLDM.ChoXacNhan:
        return ContainerState(
          name: S.current.cho_xac_nhan,
          color: color5A8DEE,
          index: index,
        );

      case stateLDM.ThamGia:
        return ContainerState(
          name: S.current.tham_gia,
          color: itemWidgetUsing,
          index: index,
        );

      case stateLDM.TuChoi:
        return ContainerState(
          name: S.current.tu_choi,
          color: statusCalenderRed,
          index: index,
        );
    }
  }
}

class ContainerState extends StatelessWidget {
  final String name;
  final int index;
  final Color color;

  const ContainerState({
    Key? key,
    required this.name,
    required this.index,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.textScale(),
        vertical: 8.0.textScale(),
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$name($index)',
            style: textNormalCustom(
              color: color,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
