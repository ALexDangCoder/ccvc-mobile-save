import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/ui/mobile/widget/item_chon_nhom.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabCungHeThongMobile extends StatefulWidget {
  const TabCungHeThongMobile({Key? key, required this.cubit}) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;

  @override
  _TabCungHeThongMobileState createState() => _TabCungHeThongMobileState();
}

class _TabCungHeThongMobileState extends State<TabCungHeThongMobile> {
  final ThanhPhanThamGiaCubit cubit = ThanhPhanThamGiaCubit();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH24,
              StreamBuilder<String>(
                stream: widget.cubit.callAPI,
                builder: (context, snapshot) {
                  return Container(
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
                                    child: Image.asset(
                                      ImageAssets.img_company,
                                      height: 5.h,
                                      width: 5.w,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  spaceW5,
                                  Text(
                                    model,
                                    style: textNormal(
                                      color3D5586,
                                      14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            widget.cubit.themNhom(newValue ?? '');
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
                          hint: Text(
                            S.current.chon_nhom,
                            style: textNormalCustom(
                              color: color3D5586,
                              fontSize: 14,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: colorA2AEBD,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
              spaceH20,
              StreamBuilder<List<NhomCungHeThong>>(
                  stream: widget.cubit.themNhomStream,
                  builder: (context, snapshot) {
                    if (snapshot.data?.isNotEmpty ?? false) {
                      return SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                ChonNhomWidget(
                                  item: snapshot.data![index],
                                  delete: () {
                                    widget.cubit.xoaNhom(
                                        snapshot.data![index].tenNhom ?? '',);
                                  },
                                ),
                                spaceH12,
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
              spaceH24,
              Container(
                height: 114,
                decoration: BoxDecoration(
                  border: Border.all(color: containerColorTab),
                ),
              ), // Stream list nhóm
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: containerColorTab),
                ),
              ),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              height: 63.h,
              color: Colors.white,
              child: DoubleButtonBottom(
                title1: 'Đóng',
                title2: S.current.chia_se,
                onPressed1: () {},
                onPressed2: () {},
                noPadding: true,
              )),
        ),
      ],
    );
  }
}
