import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ItemCadresTablet extends StatefulWidget {
  final String ten;
  final String chucVu;
  const ItemCadresTablet({Key? key,required this.ten,required this.chucVu})
      : super(key: key);

  @override
  _ItemCadresTabletState createState() => _ItemCadresTabletState();
}

class _ItemCadresTabletState extends State<ItemCadresTablet> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 0, 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgDropDown),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width:1.5,color:borderColor,),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius:
                  BorderRadius.all(Radius.circular(3.0)),
                  ),
                  checkColor: Colors.white, // color of tick Mark
                  activeColor: bgButtonDropDown,
                  onChanged: (bool? value) {
                     setState(() {
                       isCheck=value?? false;
                     });
                  },
                  value: isCheck,
                ),
              ),
              const SizedBox(width: 12,),
              Text(
                'UBND DONG NAI',
                style: titleAppbar(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 128,
                child: Text(
                  S.current.ten_can_bo,
                  style: textNormal(titleItemEdit, 16),
                ),
              ),
              const SizedBox(width: 14,),
              Text('Vu Duc Hoa',style: textNormal(textTitle,16),)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 128,
                child: Text(
                  S.current.chuc_vu,
                  style: textNormal(titleItemEdit, 16),
                ),
              ),
              const SizedBox(width: 14,),
              Text('Ra Dao',style: textNormal(textTitle,16),)
            ],
          ),
        ],
      ),
    );
  }
}
