import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/sreach_sheet_btn_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/widgets/show_drop_down_button.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTimeScreen extends StatefulWidget {
  final DateTime today;
  final Function(String text)? onChange;
  final Function(String text)? onSubmit;
  final Function()? onChangTime;
  final ChooseTimeCubit baseChooseTimeCubit;
  final ChuDeCubit chuDeCubit;

  const ChooseTimeScreen({
    Key? key,
    required this.today,
    required this.baseChooseTimeCubit,
    this.onChange,
    this.onSubmit,
    this.onChangTime,
    required this.chuDeCubit,
  }) : super(key: key);

  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  String defaultTime = ChuDeCubit.HOM_NAY;

  @override
  void initState() {
    widget.baseChooseTimeCubit.getState(widget.today);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: bgDropDown),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: CustomDropDown(
              paddingTop: 0,
              paddingLeft: 16,
              value: defaultTime,
              items: widget.chuDeCubit.dropDownItem,
              onSelectItem: (index) {
                widget.chuDeCubit.getOptionDate(
                  widget.chuDeCubit.dropDownItem[index],
                );
                widget.chuDeCubit.getDashboard(
                  widget.chuDeCubit.startDate,
                  widget.chuDeCubit.endDate,
                  isShow: true,
                );
                widget.chuDeCubit.getListTatCaCuDe(
                  widget.chuDeCubit.startDate,
                  widget.chuDeCubit.endDate,
                  isShow: true,
                );
              },
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Expanded(
              flex: 4,
              child: GestureDetector(
                child: Center(
                  child: SizedBox(
                    height: 22,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.ic_box_serach,
                          fit: BoxFit.cover,
                          color: AppTheme.getInstance().colorField(),
                        ),
                        spaceW15,
                        Text(
                          S.current.tim_kiem,
                          style: textNormalCustom(
                            color: color3D5586,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showBottomSheetCustom(
                    context,
                    child: SearchBanTinBtnSheet(
                      cubit: widget.chuDeCubit,
                    ),
                    title: S.current.tim_kiem,
                  );
                },
              ))
        ],
      ),
    );
  }
}
