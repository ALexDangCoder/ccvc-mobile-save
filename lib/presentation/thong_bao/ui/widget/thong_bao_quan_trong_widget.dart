import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongBaoQuanTrongWidget extends StatelessWidget {
  final ThongBaoCubit cubit;

  const ThongBaoQuanTrongWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.maxFinite,
          color: colorECEEF7,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.thong_bao_quan_trong,
                style: textNormalCustom(
                  color: textTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.textScale(space: 9),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDiaLog(
                    context,
                    title: S.current.doc_tat_ca,
                    textContent: S.current.danh_dau_tat_ca_da_doc,
                    icon: Container(),
                    btnRightTxt: S.current.xac_nhan,
                    btnLeftTxt: S.current.dong,
                    funcBtnRight: () {
                      cubit.readAllNoti(true);
                    },
                  );
                },
                child: SvgPicture.asset(ImageAssets.icPickAll),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.maxFinite,
          color: colorECEEF7,
        ),
      ],
    );
  }
}
