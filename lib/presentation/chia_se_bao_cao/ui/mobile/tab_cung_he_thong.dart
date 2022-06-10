import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TabCungHeThongMobile extends StatefulWidget {
  const TabCungHeThongMobile({Key? key, required this.cubit}) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;
  @override
  _TabCungHeThongMobileState createState() => _TabCungHeThongMobileState();
}

class _TabCungHeThongMobileState extends State<TabCungHeThongMobile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH24,
        Container(
          height: 40.h,
          width: double.infinity,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4.r)),
            border: Border.all(color: containerColorTab),
          ),
          child: Theme(
            data: ThemeData(
              hintColor: Colors.white24,
              selectedRowColor: Colors.white24,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                buttonDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                items: widget.cubit.listDropDown.map((String model) {
                  return DropdownMenuItem(
                    value: model,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: color4C6FFF.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            ImageAssets.img_company,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                        spaceW5,
                        Text(
                          model,
                          style: textNormal(
                            color3D5586,
                            16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {

                },
                dropdownMaxHeight: 200,
                dropdownWidth: MediaQuery.of(context).size.width - 32.w,
                dropdownDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                ),
                scrollbarThickness: 0,
                scrollbarAlwaysShow: false,
                offset: Offset(-16.w, 0),
                value: 'Nhóm A',
                icon: SvgPicture.asset(
                  ImageAssets.imgAcount,
                  height: 10.h,
                  width: 10.w,
                ),
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
