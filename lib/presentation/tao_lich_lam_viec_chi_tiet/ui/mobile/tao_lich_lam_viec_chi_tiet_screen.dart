import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/sua_lich_cong_tac_trong_nuoc/ui/phone/sua_lich_cong_tac_trong_nuoc_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/search_name_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaoLichLamViecChiTietScreen extends StatefulWidget {
  const TaoLichLamViecChiTietScreen({Key? key}) : super(key: key);

  @override
  _TaoLichLamViecChiTietScreenState createState() =>
      _TaoLichLamViecChiTietScreenState();
}

class _TaoLichLamViecChiTietScreenState
    extends State<TaoLichLamViecChiTietScreen> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  TextEditingController tieuDeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTaoLichLVInherited(
      taoLichLamViecCubit: taoLichLamViecCubit,
      child: Scaffold(
        appBar: BaseAppBar(
          title: S.current.tao_lich_cong_tac_trong_nuoc,
          leadingIcon: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: unselectLabelColor,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ExpandGroup(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 26,),
                  const NhacLaiWidget(),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const ThanhPhanThamGiaTLWidget(),
                  const TaiLieuWidget(),
                  buttonTaoLich(
                    onTap: () {
                      if (taoLichLamViecCubit.checkValidateTime()) {
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: backgroundDrawerMenu,
                            content: Text(
                              S.current.vui_long_kiem_tra_lai_time,
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }

                      if (tieuDeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: backgroundDrawerMenu,
                            content: Text(
                              S.current.khong_duoc_de_trong,
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetTaoLichLVInherited extends InheritedWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const WidgetTaoLichLVInherited({
    Key? key,
    required this.taoLichLamViecCubit,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static WidgetTaoLichLVInherited of(BuildContext context) {
    final WidgetTaoLichLVInherited? result =
        context.dependOnInheritedWidgetOfExactType<WidgetTaoLichLVInherited>();
    assert(result != null, 'No elenment');
    return result!;
  }
}

Widget buttonTaoLich({required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(top: 33, bottom: 10),
      color: textDefault,
      alignment: Alignment.center,
      width: double.maxFinite,
      child: Text(
        S.current.tao_lich_lam_viec,
        style: textNormalCustom(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  );
}
