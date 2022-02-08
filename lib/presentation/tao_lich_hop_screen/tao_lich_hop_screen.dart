import 'dart:developer';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/fake_data_tao_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/chon_phong_hop_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/don_vi_khac_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/thanh_phan_tham_gia_widget_expand.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class TaoLichHopScreen extends StatefulWidget {
  const TaoLichHopScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.tao_lich_hop),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ExpandGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandGroup(
                child: Column(
                  children: [
                    TextFieldStyle(
                      urlIcon: ImageAssets.icEdit,
                      hintText: S.current.tieu_de,
                    ),
                    spaceH5,
                    ContainerToggleWidget(
                      title: S.current.hop_truc_tiep,
                      onChange: (value) {},
                    ),
                    spaceH5,
                    ContainerToggleWidget(
                      title: S.current.trong_don_vi,
                      onChange: (value) {},
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icCalendar,
                      title: S.current.loai_hop,
                      value: FakeDataTaoLichHop.loaiHop.first,
                      listSelect: FakeDataTaoLichHop.loaiHop,
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icWork,
                      title: S.current.linh_vuc,
                      value: FakeDataTaoLichHop.linhVuc.first,
                      listSelect: FakeDataTaoLichHop.linhVuc,
                    ),
                    spaceH5,
                    TextFieldStyle(
                      urlIcon: ImageAssets.icDoublePerson,
                      hintText: S.current.them_nguoi,
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icNhacLai,
                      title: S.current.nhac_lai,
                      value: FakeDataTaoLichHop.nhacLai.first,
                      listSelect: FakeDataTaoLichHop.nhacLai,
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icNhacLai,
                      title: S.current.lich_lap,
                      value: FakeDataTaoLichHop.nhacLai.first,
                      listSelect: FakeDataTaoLichHop.nhacLai,
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icMucDoHop,
                      title: S.current.muc_do_hop,
                      value: FakeDataTaoLichHop.mucDoHop.first,
                      listSelect: FakeDataTaoLichHop.mucDoHop,
                    ),
                    spaceH5,
                    SelectOnlyExpand(
                      urlIcon: ImageAssets.icPeople,
                      title: S.current.nguoi_chu_tri,
                      value: FakeDataTaoLichHop.nguoiChuTri.last,
                      listSelect: FakeDataTaoLichHop.nguoiChuTri,
                    ),
                    spaceH24,
                    TextFieldStyle(
                      urlIcon: ImageAssets.icDocument,
                      hintText: S.current.noi_dung,
                      maxLines: 4,
                    ),
                    spaceH24
                  ],
                ),
              ),
              TitleChildWidget(
                title: S.current.thong_tin_lien_he,
                child: Column(
                  children: [
                    TextFieldStyle(
                      urlIcon: ImageAssets.icPeople,
                      hintText: S.current.ho_ten,
                    ),
                    TextFieldStyle(
                      urlIcon: ImageAssets.icCuocGoi,
                      hintText: S.current.so_dien_thoai,
                    ),
                  ],
                ),
              ),
              spaceH24,
              const ChonPhongHopWidget(),
              spaceH15,
              const ThanhPhanThamGiaExpandWidget(),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
