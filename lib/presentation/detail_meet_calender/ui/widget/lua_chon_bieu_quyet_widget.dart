import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LuaChonBieuQuyetWidget extends StatefulWidget {
  const LuaChonBieuQuyetWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final DetailMeetCalenderCubit cubit;

  @override
  _LuaChonBieuQuyetWidgetState createState() => _LuaChonBieuQuyetWidgetState();
}

class _LuaChonBieuQuyetWidgetState extends State<LuaChonBieuQuyetWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.cubit.properties.isEmpty) {
      widget.cubit.properties.add(
        '',
      );
    } else {}
  }

  void _addFormWidget() {
    setState(() {
      widget.cubit.properties.add(
        '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 26),
                child: InputInfoUserWidget(
                  isObligatory: true,
                  title: S.current.cac_lua_chon_bieu_quyet,
                  child: const SizedBox(),
                ),
              ),
              spaceH20,
              Container(
                padding: const EdgeInsets.only(left: 26),
                child: Text(
                  '',
                  style: textNormalCustom(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cubit.properties.length,
                  itemBuilder: (context, index) {
                    return FormProperties(
                      data: widget.cubit.properties[index],
                      cubit: widget.cubit,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 26),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(''),
                    ),
                    spaceW6,
                    InkWell(
                      onTap: _addFormWidget,
                      child: Text(
                        'Add more',
                        style: textNormalCustom(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              spaceH24,
            ],
          ),
        ),
        // Container(
        //   width: 312,
        //   height: 1,
        //   color: Colors.blue,
        // ),
        // //btn cancel and save
        // Container(
        //   height: 65,
        //   width: 312,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(36),
        //       bottomRight: Radius.circular(36),
        //     ),
        //     color: Colors.red,
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Center(
        //           child: InkWell(
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //             child: Text(
        //               'Cancel',
        //               style: textNormalCustom(
        //                 color: Colors.amberAccent,
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         width: 1,
        //         height: 65,
        //         color: Colors.amber,
        //       ),
        //       Expanded(
        //         child: GestureDetector(
        //           onTap: () {
        //             // widget.cubit.checkPropertiesWhenSave();
        //             Navigator.pop(context);
        //           },
        //           child: Center(
        //             child: Text(
        //               'Save',
        //               style: textNormalCustom(
        //                 color: AppTheme.getInstance().bgColor(),
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}

enum IS_HAVE_DATA { YES, NO }

class FormProperties extends StatelessWidget {
  const FormProperties({
    Key? key,
    required this.data,
    required this.cubit,
  }) : super(key: key);

  final String data;
  final DetailMeetCalenderCubit cubit;

  @override
  Widget build(BuildContext context) {
    String propertyForm = data;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: AppTheme.getInstance().bgColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 18, left: 20, right: 20),
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: 13,
      ),
      child: Column(
        children: [
          TextFormField(
            initialValue: propertyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length > 30) {
                // data.property = '';
                // cubit.checkPropertiesWhenSave();
                return 'Maximum character is 30 characters';
              }
              return null;
            },
            onChanged: (value) {
              propertyForm = value;
              // data.property = propertyForm;
            },
            cursorColor: AppTheme.getInstance().backGroundColor(),
            style: textNormal(
              AppTheme.getInstance().dfBtnColor(),
              16,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Properties',
              hintStyle: textNormalCustom(
                color: AppTheme.getInstance().accentColor(),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              filled: true,
            ),
          ),
          Container(
            width: 248,
            height: 1,
            color: AppTheme.getInstance().dfTxtColor(),
          ),
        ],
      ),
    );
  }
}
