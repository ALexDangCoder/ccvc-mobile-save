import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_person_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchNameWidget extends StatefulWidget {
  const SearchNameWidget({Key? key}) : super(key: key);

  @override
  _SearchNameWidgetState createState() => _SearchNameWidgetState();
}

class _SearchNameWidgetState extends State<SearchNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.5.textScale()),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(ImageAssets.icDoublePerson),
              SizedBox(
                width: 14.0.textScale(),
              ),
              Expanded(
                child: SizedBox(
                  height: 29,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: S.current.them_nguoi,
                        hintStyle: textNormalCustom(
                          color: unselectLabelColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.textScale(),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: lineColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: lineColor),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          StreamBuilder(
              stream: WidgetTaoLichLVInherited.of(context)
                  .taoLichLamViecCubit
                  .listItemPersonStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return Column(
                  children: listPerson
                      .map(
                        (e) => ItemPersonWidget(
                          name: e,
                        ),
                      )
                      .toList(),
                );
              },),
        ],
      ),
    );
  }
}
