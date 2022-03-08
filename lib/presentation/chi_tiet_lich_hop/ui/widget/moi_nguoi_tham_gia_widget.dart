import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thanh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_thanh_phan_tham_gia_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'icon_with_title_widget.dart';

class MoiNguoiThamGiaWidget extends StatefulWidget {
  const MoiNguoiThamGiaWidget({Key? key}) : super(key: key);

  @override
  _MoiNguoiThamGiaWidgetState createState() => _MoiNguoiThamGiaWidgetState();
}

class _MoiNguoiThamGiaWidgetState extends State<MoiNguoiThamGiaWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited.of(context).cubit;

    return SelectOnlyWidget(
      title: S.current.thanh_phan_tham_gia,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.ic_file,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showBottomSheetCustom(
                context,
                title: S.current.them_thanh_phan_tham_gia,
                child: const ThemThanhPhanThamGiaWidget(),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.ic_file,
            title: S.current.diem_danh,
            onPress: () {},
          ),
          StreamBuilder<List<ThanhPhanThamGiaModel>>(
            stream: cubit.thanhPhanThamGia,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return CellThanhPhanThamGia(
                      cubit: cubit,
                      infoModel: _list[index],
                    );
                  },
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: NodataWidget(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}