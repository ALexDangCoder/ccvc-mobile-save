import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_hdsd/bloc/detail_hdsd_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_hdsd/ui/tablet/widget_button_hdsd/widget_button_hdsd.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailHDSDScreenTablet extends StatefulWidget {
  const DetailHDSDScreenTablet({Key? key}) : super(key: key);

  @override
  _DetailHDSDScreenTabletState createState() => _DetailHDSDScreenTabletState();
}

class _DetailHDSDScreenTabletState extends State<DetailHDSDScreenTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DetailHDSDCubit cubit = DetailHDSDCubit();
    return Scaffold(
      backgroundColor: bgTabletColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.xem_hdsd),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH28,
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                S.current.thong_tin_chuong_trinh_hop,
                style: textNormalCustom(color: labelColor, fontSize: 18),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: backgroundColorApp,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderItemCalender.withOpacity(0.5)),
              ),
              margin: const EdgeInsets.only(
                top: 24,
                left: 30,
                right: 30,
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.listHDSD.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      cubit.listHDSD[index],
                      style: textDetailHDSD(color: titleColor, fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            spaceH28,
            Center(
              child: WidgetButtonHDSD(
                title: S.current.huy,
                isColorBlue: false,
                onPressed: () {},
                top: 13,
                bottom: 13,
                left: 90,
                right: 90,
              ),
            )
          ],
        ),
      ),
    );
  }
}
