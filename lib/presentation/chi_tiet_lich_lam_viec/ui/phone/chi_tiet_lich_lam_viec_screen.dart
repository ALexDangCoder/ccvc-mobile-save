import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/buttom_chi_tiet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiTietLichLamViecScreen extends StatefulWidget {
  const ChiTietLichLamViecScreen({Key? key}) : super(key: key);

  @override
  State<ChiTietLichLamViecScreen> createState() =>
      _ChiTietLichLamViecScreenState();
}

class _ChiTietLichLamViecScreenState extends State<ChiTietLichLamViecScreen> {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  @override
  void initState() {
    super.initState();
    chiTietLichLamViecCubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_lam_viec,
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(ImageAssets.icMenuDot),
          ),
          const SizedBox(width: 20,),
        ],
        leadingIcon: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back_ios,
            color: AqiColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 12,
                    color: statusCalenderRed,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    S.current.hop_noi_bo_cong_ty,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              StreamBuilder<ChiTietLichLamViecModel>(
                stream: chiTietLichLamViecCubit.chiTietLichLamViecStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final data = snapshot.data;

                  return Column(
                    children: data
                            ?.dataRow()
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.only(top: 24),
                                child: RowValueWidget(
                                  row: e, isTablet: false,
                                ),
                              ),
                            )
                            .toList() ??
                        [Container()],
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: ButtomChiTietWidget(
                  title: S.current.danh_sach_bao_cao_ket_qua,
                  icon: ImageAssets.icGraph,
                  onTap: () {},
                ),
              ),
              ButtomChiTietWidget(
                onTap: () {},
                title: S.current.danh_sach_y_kien,
                icon: ImageAssets.icMess,
              )
            ],
          ),
        ),
      ),
    );
  }
}
