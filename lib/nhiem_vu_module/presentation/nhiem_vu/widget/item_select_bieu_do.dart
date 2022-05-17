import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum stateBieuDo { TheoTrangThai, TheoLoai, TheoDonVi }

extension StateLichHop on stateBieuDo {
  bool? getListState (stateBieuDo state) {
    if (this == state) {
      return true;
    } else {
      return null;
    }
  }
}

extension statusColor on int{
  Color trangThaiColor() {
    switch (this) {
      case 0:
        return linkColor;
      case 1:
        return linkColor;
      case 2:
        return linkColor;
      default:
        return redChart;
    }
  }
}

extension StateLDM on stateBieuDo {
  // int getIndex(DashBoardLichHopModel model) {
  //   switch (this) {
  //     case stateBieuDo.ChoXacNhan:
  //       return model.soLichChoXacNhan ?? 0;
  //
  //     case stateBieuDo.ThamGia:
  //       return model.soLichThamGia ?? 0;
  //
  //     case stateBieuDo.TuChoi:
  //       return model.soLichChuTriTuChoi ?? 0;
  //   }
  // }
  //
  // int getIndexLichHop(DashBoardLichHopModel model) {
  //   switch (this) {
  //     case stateBieuDo.ChoXacNhan:
  //       return model.soLichChoXacNhan ?? 0;
  //
  //     case stateBieuDo.ThamGia:
  //       return model.soLichThamGia ?? 0;
  //
  //     case stateBieuDo.TuChoi:
  //       return model.soLichChuTriTuChoi ?? 0;
  //   }
  // }

  Widget getState(bool isCheck) {
    switch (this) {
      case stateBieuDo.TheoTrangThai:
        return ContainerState(
          name: S.current.theo_trang_thai,
          isCheck: isCheck,
        );

      case stateBieuDo.TheoLoai:
        return ContainerState(
          name: S.current.theo_loai,
          isCheck: isCheck,
        );

      case stateBieuDo.TheoDonVi:
        return ContainerState(
          name: S.current.theo_don_vi,
          isCheck: isCheck,
        );
    }
  }
}

class ContainerState extends StatelessWidget {
  final String name;
  final bool isCheck;


  const ContainerState({
    Key? key,
    required this.name,
    required this.isCheck,

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
        color: isCheck?linkColor:backgroundColorApp
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: textNormalCustom(
              color: isCheck?backgroundColorApp:unselectedLabelColor,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
