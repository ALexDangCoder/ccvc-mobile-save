import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/fake_data_tao_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tablet/widgets/button_save_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/row_column_tablet.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuaLichHopTabletScreen extends StatefulWidget {
  const SuaLichHopTabletScreen({Key? key}) : super(key: key);

  @override
  _SuaLichHopScreenState createState() => _SuaLichHopScreenState();
}

class _SuaLichHopScreenState extends State<SuaLichHopTabletScreen> {
  final TaoLichHopCubit _cubit = TaoLichHopCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCalenderColor,
      resizeToAvoidBottomInset: true,
      appBar: BaseAppBar(
        title: S.current.sua_lich_hop,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: MenuSelectWidget(
              listSelect: [],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RowColunmTabletWidget(
              widgetLeft: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandGroup(
                    child: Column(
                      children: [
                        spaceH20,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icEdit,
                          hintText: S.current.tieu_de,
                        ),
                        spaceH5,
                        ContainerToggleWidget(
                          title: S.current.hop_truc_tuyen,
                          onChange: (value) {},
                        ),
                        spaceH5,
                        ContainerToggleWidget(
                          title: S.current.trong_don_vi,
                          onChange: (value) {},
                        ),
                        spaceH5,
                        StreamBuilder<List<LoaiSelectModel>>(
                          stream: _cubit.loaiLich,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <LoaiSelectModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icCalendar,
                              title: S.current.loai_hop,
                              value: _cubit.selectLoaiHop?.name ?? '',
                              listSelect: data.map((e) => e.name).toList(),
                            );
                          },
                        ),
                        spaceH5,
                        StreamBuilder<List<LoaiSelectModel>>(
                          stream: _cubit.linhVuc,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <LoaiSelectModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icWork,
                              title: S.current.linh_vuc,
                              value: _cubit.selectLinhVuc?.name ?? '',
                              listSelect: data.map((e) => e.name).toList(),
                            );
                          },
                        ),
                        StartEndDateWidget(
                          icMargin: false,
                          onEndDateTimeChanged: (DateTime value) {},
                          onStartDateTimeChanged: (DateTime value) {},
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
                          value: FakeDataTaoLichHop.lichLap.first,
                          listSelect: FakeDataTaoLichHop.lichLap,
                        ),
                        spaceH5,
                        SelectOnlyExpand(
                          urlIcon: ImageAssets.icMucDoHop,
                          title: S.current.muc_do_hop,
                          value: FakeDataTaoLichHop.mucDoHop.first,
                          listSelect: FakeDataTaoLichHop.mucDoHop,
                        ),
                        spaceH5,
                        StreamBuilder<List<NguoiChutriModel>>(
                          stream: _cubit.nguoiChuTri,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <NguoiChutriModel>[];
                            return SelectOnlyExpand(
                              urlIcon: ImageAssets.icPeople,
                              title: S.current.nguoi_chu_tri,
                              value: _cubit.selectNguoiChuTri?.title() ?? '',
                              listSelect: data.map((e) => e.title()).toList(),
                            );
                          },
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
                  spaceH5,
                ],
              ),
              widgetRight: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleChildWidget(
                    title: S.current.dau_moi_lien_he,
                    sizeTitle: 18,
                    child: Column(
                      children: [
                        TextFieldStyle(
                          urlIcon: ImageAssets.icPeople,
                          hintText: S.current.ho_ten,
                        ),
                        spaceH16,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icCuocGoi,
                          hintText: S.current.so_dien_thoai,
                        ),
                      ],
                    ),
                  ),
                  spaceH24,
                  ChonPhongHopScreen(
                    onChange: (value) {},
                  ),
                ],
              ),
              titleLeft: S.current.thong_tin_lich,
              titleRight: '',
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 28, bottom: 30),
                child: ButtonSaveWidget(
                  leftTxt: S.current.dong,
                  rightTxt: S.current.luu,
                  funcBtnOk: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}