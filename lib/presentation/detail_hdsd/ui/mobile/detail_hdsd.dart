import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_hdsd/bloc/detail_hdsd_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailHDSDScreen extends StatefulWidget {
  const DetailHDSDScreen({Key? key}) : super(key: key);

  @override
  _DetailHDSDScreenState createState() => _DetailHDSDScreenState();
}

class _DetailHDSDScreenState extends State<DetailHDSDScreen> {
  final DetailHDSDCubit cubit = DetailHDSDCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.xem_hdsd),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH16,
            Text(
              S.current.thong_tin_chuong_trinh_hop,
              style: textNormalCustom(color: color7966FF, fontSize: 16),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.listHDSD.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    cubit.listHDSD[index],
                    style: textDetailHDSD(color: color3D5586, fontSize: 16),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 32, left: 17, right: 17, top: 20),
        child: ButtonCustomBottom(
          title: S.current.huy,
          isColorBlue: false,
          onPressed: () {},
        ),
      ),
    );
  }
}
