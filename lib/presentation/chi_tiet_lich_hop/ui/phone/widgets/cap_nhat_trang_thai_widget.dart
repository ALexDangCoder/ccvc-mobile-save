import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';

import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';

import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:flutter/material.dart';

class CapNhapTrangThaiWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final ThongTinPhongHopModel model;

  const CapNhapTrangThaiWidget({
    Key? key,
    required this.cubit,
    required this.model,
  }) : super(key: key);

  @override
  State<CapNhapTrangThaiWidget> createState() => _CapNhapTrangThaiWidgetState();
}

class _CapNhapTrangThaiWidgetState extends State<CapNhapTrangThaiWidget> {
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noiDungController.text = widget.model.ghiChu ?? '';
    widget.cubit.idCapNhatTrangThai = widget.model.trangThaiChuanBiId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardEdt(
      bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.cap_nhat,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: ()  {
            widget.cubit
                .capNhatTrangThai(
              id: widget.model.lichHopPhongHopId ?? '',
              ghiChu: noiDungController.text,
              trangThai: widget.cubit.idCapNhatTrangThai,
            )
                .then((value) {
              if (value) {
                widget.cubit.callApiCongTacChuanBi();
              }
            });
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            spaceH10,
            InputInfoUserWidget(
              title: S.current.cap_nhat_trang_thai,
              child: CoolDropDown(
                useCustomHintColors: true,
                initData: widget.model.trangThaiChuanBi ?? '',
                placeHoder: S.current.chon_trang_thai,
                onChange: (index) {
                  widget.cubit.idCapNhatTrangThai =
                      widget.cubit.listStatusRom[index].id ?? '';
                },
                listData: widget.cubit.listStatusRom
                    .map((e) => e.displayName ?? '')
                    .toSet()
                    .toList(),
              ),
            ),
            spaceH20,
            BlockTextViewLich(
              isRequired: false,
              hintText: S.current.nhap_ghi_chu,
              formKey: formKeyNoiDung,
              contentController: noiDungController,
              title: S.current.ghi_chu,
            ),
          ],
        ),
      ),
    );
  }
}
