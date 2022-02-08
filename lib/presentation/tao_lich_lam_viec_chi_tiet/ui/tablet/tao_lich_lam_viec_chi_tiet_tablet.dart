import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/mau_mac_dinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/search_name_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class TaoLichLamViecChiTietTablet extends StatefulWidget {
  const TaoLichLamViecChiTietTablet({Key? key}) : super(key: key);

  @override
  _TaoLichLamViecChiTietTabletState createState() =>
      _TaoLichLamViecChiTietTabletState();
}

class _TaoLichLamViecChiTietTabletState
    extends State<TaoLichLamViecChiTietTablet> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  final _formKey = GlobalKey<FormState>();
  TextEditingController tieuDeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WidgetTaoLichLVInherited(
      taoLichLamViecCubit: taoLichLamViecCubit,
      child: Scaffold(
        backgroundColor: bgWidgets,
        appBar: BaseAppBar(
          title: S.current.tao_lich_cong_tac_trong_nuoc,
          leadingIcon: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: unselectLabelColor,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(vertical: 28, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: borderColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.thong_tin_lich,
                              style: textNormalCustom(
                                color: textTitle,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormWidget(
                                controller: tieuDeController,
                                image: ImageAssets.icEdit,
                                hint: S.current.tieu_de,
                              ),
                            ),
                            const LoaiLichWidget(),
                            const SearchNameWidget(),
                            StartEndDateWidget(
                              onEndDateTimeChanged: (DateTime value) {},
                              onStartDateTimeChanged: (DateTime value) {},
                            ),
                            const NhacLaiWidget(),
                            const MauMacDinhWidget(),
                            const NguoiChuTriWidget(),
                            const LinhVucWidget(),
                            TextFormWidget(
                              image: ImageAssets.icViTri,
                              hint: S.current.dia_diem,
                            ),
                            TextFormWidget(
                              image: ImageAssets.icDocument,
                              hint: S.current.noi_dung,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 14),
                        child: Column(
                          children: const [
                            ThanhPhanThamGiaTLWidget(),
                            TaiLieuWidget(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buttomWidget(
                      title: S.current.huy,
                      background: bgTag,
                      textColor: labelColor,
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    buttomWidget(
                      title: S.current.tao_lich_lam_viec,
                      background: textDefault,
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttomWidget({
  required String title,
  required Color background,
  required Color textColor,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: textNormalCustom(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  );
}
