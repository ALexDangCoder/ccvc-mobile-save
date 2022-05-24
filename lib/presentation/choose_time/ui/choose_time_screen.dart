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
  final ChuDeCubit? chuDeCubit;

  const ChooseTimeScreen(
      {Key? key,
      required this.today,
      required this.baseChooseTimeCubit,
      this.onChange,
      this.onSubmit,
      this.onChangTime,
      this.chuDeCubit})
      : super(key: key);

  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
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
            flex: 6,
            child: Row(
              children: [
                spaceW8,
                Container(
                  width: 90,
                  height: 32,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().colorField().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      widget.baseChooseTimeCubit.ontoDay();
                      widget.onChangTime != null ? widget.onChangTime!() : null;
                    },
                    child: Text(
                      S.current.today,
                      textAlign: TextAlign.center,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().colorField(),
                        fontSize: 14.0.textScale(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.baseChooseTimeCubit.checkToOptionBackDay(
                                widget.baseChooseTimeCubit.changeOption,
                              );
                              widget.onChangTime != null
                                  ? widget.onChangTime!()
                                  : null;
                            },
                            child: SvgPicture.asset(ImageAssets.ic_prev_box),
                          ),
                          spaceW12,
                          Expanded(
                            child: StreamBuilder<Object>(
                              stream:
                                  widget.baseChooseTimeCubit.textDateTimeStream,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 22,
                                  child: FittedBox(
                                    child: Text(
                                      '${snapshot.data}',
                                      style: textNormal(
                                        textDropDownColor,
                                        14.0.textScale(space: 4),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          spaceW12,
                          GestureDetector(
                            onTap: () {
                              widget.baseChooseTimeCubit.checkToOption(
                                widget.baseChooseTimeCubit.changeOption,
                              );
                              widget.onChangTime != null
                                  ? widget.onChangTime!()
                                  : null;
                            },
                            child: SvgPicture.asset(ImageAssets.ic_next_box),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: ShowDropDownButton(
                    onChanged: (value) {
                      widget.baseChooseTimeCubit.changeOption = value;
                      widget.baseChooseTimeCubit.checkToOption(
                        widget.baseChooseTimeCubit.changeOption,
                      );
                    },
                    chooseTimeCubit: ChooseTimeCubit(),
                  ),
                ),
                spaceW8,
              ],
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
                            color: titleColor,
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
                      cubit: widget.chuDeCubit ?? ChuDeCubit(),
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
