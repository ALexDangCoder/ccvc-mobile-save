import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/widgets/show_drop_down_button.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTimeScreen extends StatefulWidget {
  final DateTime today;
  final Function(String text)? onChange;
  final Function(String text)? onSubmit;

  const ChooseTimeScreen({
    Key? key,
    required this.today,
    this.onChange,
    this.onSubmit,
  }) : super(key: key);

  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  final ChooseTimeCubit baseChooseTimeCubit = ChooseTimeCubit();

  @override
  void initState() {
    baseChooseTimeCubit.getState(widget.today);
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
                    color: bgButtonDropDown.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      baseChooseTimeCubit.ontoDay();
                    },
                    child: Text(
                      S.current.today,
                      textAlign: TextAlign.center,
                      style: textNormalCustom(
                        color: bgButtonDropDown,
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
                              setState(() {});
                              baseChooseTimeCubit.checkToOptionBackDay(
                                baseChooseTimeCubit.changeOption,
                              );
                            },
                            child: SvgPicture.asset(ImageAssets.ic_prev_box),
                          ),
                          spaceW12,
                          Expanded(
                            child: StreamBuilder<Object>(
                              stream: baseChooseTimeCubit.textDateTimeStream,
                              builder: (context, snapshot) {
                                return FittedBox(
                                  child: Text(
                                    '${snapshot.data}',
                                    style: textNormal(
                                      textDropDownColor,
                                      14.0.textScale(space: 4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          spaceW12,
                          GestureDetector(
                            onTap: () {
                              baseChooseTimeCubit.checkToOption(
                                baseChooseTimeCubit.changeOption,
                              );
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
                      baseChooseTimeCubit.changeOption = value;
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
            child: TextField(
              onChanged: (text) {
                widget.onChange != null ? widget.onChange!(text) : null;
              },
              onSubmitted: (text) {
                widget.onChange != null ? widget.onSubmit!(text) : null;
              },
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 36,
                  height: 14,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SvgPicture.asset(ImageAssets.ic_KinhRong),
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 26,
                  minHeight: 26,
                ),
                contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
                isCollapsed: true,
                fillColor: bgDropDown.withOpacity(0.1),
                filled: true,
                hintText: S.current.tiem_kiem,
                hintStyle: textNormal(
                  sideTextInactiveColor,
                  14,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgDropDown),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
