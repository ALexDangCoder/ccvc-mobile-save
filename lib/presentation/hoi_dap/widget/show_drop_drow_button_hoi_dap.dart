import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/widgets/form_display_text.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/bloc/hoi_dap_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowDropDownButtonHoiDap extends StatefulWidget {
  final Function(String) onChanged;
  final HoiDapCubit cubit;

  const ShowDropDownButtonHoiDap({
    Key? key,
    required this.onChanged,
    required this.cubit,
  }) : super(key: key);

  @override
  _ShowDropDownButtonHoiDapState createState() =>
      _ShowDropDownButtonHoiDapState();
}

class _ShowDropDownButtonHoiDapState extends State<ShowDropDownButtonHoiDap> {
  GlobalKey globalKey = GlobalKey();
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Offset getPosition() {
    final box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset position =
        box?.localToGlobal(Offset.zero) ?? Offset.zero; //thi

    setState(() {
      x = position.dx;
      y = position.dy;
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          key: globalKey,
          width: 163,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorE2E8F0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: FormDisplayText(widget.cubit.textContent),
              ),
              Expanded(
                flex: 4,
                child: widget.cubit.isCheck
                    ? RotatedBox(
                        quarterTurns: 2,
                        child: IconButton(
                          icon: SvgPicture.asset(ImageAssets.icDropDownButton),
                          onPressed: () {},
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          _showMyDialog(getPosition());
                          setState(() {
                            widget.cubit.isCheck = true;
                          });
                        },
                        icon: SvgPicture.asset(ImageAssets.icDropDownButton),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(Offset position) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // account must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              widget.cubit.isCheck = false;
            });
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(
                  top: position.dy + 20,
                  left: position.dx,
                  child: Container(
                    width: 163,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: colorE2E8F0,
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.cubit.textContent =
                                  widget.cubit.listText[index];
                            });
                            Navigator.pop(context);
                            widget.cubit.isCheck = false;
                            widget.onChanged(
                              widget.cubit.textContent,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  widget.cubit.listText[index],
                                  style: textNormal(color3D5586, 14),
                                ),
                              ),
                              if (index == 2)
                                Container()
                              else
                                Container(
                                  height: 1,
                                  color: colorE2E8F0,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
