
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/bloc/chon_phong_hoc_cubit.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/widgets/loai_phong_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/widgets/yeu_cau_them_thiet_bi_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/widgets/select_don_vi.dart';
import 'package:flutter/material.dart';

class ChonPhongHopScreen extends StatefulWidget {
  final Function(ChonPhongHopModel) onChange;
  const ChonPhongHopScreen({Key? key, required this.onChange})
      : super(key: key);

  @override
  _ChonPhongHopWidgetState createState() => _ChonPhongHopWidgetState();
}

class _ChonPhongHopWidgetState extends State<ChonPhongHopScreen> {
  final ChonPhongHopCubit _cubit = ChonPhongHopCubit();
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showBottomSheet();
      },
      text: S.current.chon_phong_hop,
      urlIcon: ImageAssets.icChonPhongHop,
    );
  }

  void showBottomSheet() {
    showBottomSheetCustom<ChonPhongHopModel>(
      context,
      child: _ChonPhongHopScreen(
        chonPhongHopCubit: _cubit,
      ),
      title: S.current.chon_phong_hop,
    ).then((value) {
      if (value != null) {
        widget.onChange(value);
      }
    });
  }
}

class _ChonPhongHopScreen extends StatefulWidget {
  final ChonPhongHopCubit chonPhongHopCubit;
  const _ChonPhongHopScreen({Key? key, required this.chonPhongHopCubit})
      : super(key: key);
  @override
  __ChonPhongHopScreenState createState() => __ChonPhongHopScreenState();
}

class __ChonPhongHopScreenState extends State<_ChonPhongHopScreen> {
  final TextEditingController controller = TextEditingController();
  ThanhPhanThamGiaCubit cubit =ThanhPhanThamGiaCubit();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      width: double.infinity,
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: DoubleButtonBottom(
            title1: S.current.dong,
            title2: S.current.xac_nhan,
            onPressed1: () {
              Navigator.pop(context);
            },
            onPressed2: () {
              Navigator.pop(
                context,
                ChonPhongHopModel(
                  loaiPhongHopEnum:
                  widget.chonPhongHopCubit.loaiPhongHopEnum,
                  listThietBi: widget.chonPhongHopCubit.listThietBi,
                  yeuCauKhac: controller.text,
                ),
              );
            },
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoaiPhongHopWidget(
                onChange: (value) {
                  widget.chonPhongHopCubit.setLoaiPhongHop(value);
                },
              ),
              spaceH25,
              SelectDonVi(
                title: S.current.don_vi,
                hintText: S.current.chon_don_vi,
                onChange: (value) {},
                cubit: cubit,
              ),
              spaceH20,
              YeuCauThemThietBiWidget(
                chonPhongHopCubit: widget.chonPhongHopCubit,
                onClose: () {
                },
              ),
              spaceH20,
              BlockTextView(
                formKey: _key,
                isRequired: false,
                title: S.current.yeu_cau_de_chuan_bi_phong,
                contentController: controller,
              ),

            ],
          ),
        ),
      ),
    );
  }

}
