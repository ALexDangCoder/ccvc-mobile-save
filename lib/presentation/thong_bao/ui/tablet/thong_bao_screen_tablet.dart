import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/presentation/thong_bao/fake_data.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/thong_bao_screen.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongBaoScreenTablet extends StatefulWidget {
  const ThongBaoScreenTablet({
    Key? key,
  }) : super(key: key);

  @override
  _ThongBaoScreenTabletState createState() => _ThongBaoScreenTabletState();
}

class _ThongBaoScreenTabletState extends State<ThongBaoScreenTablet> {
  String titleAppbar =
      '${S.current.thong_bao} ';

  ThongBaoCubit thongBaoCubit = ThongBaoCubit();

  @override
  void initState() {
    super.initState();
    thongBaoCubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return ThongBaoInherted(
    //   thongBaoCubit: thongBaoCubit,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         titleAppbar,
    //         style: textNormalCustom(
    //           color: buttonColor,
    //           fontSize: 24,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //       centerTitle: true,
    //       elevation: 0.2,
    //       leading: IconButton(
    //         icon: const Icon(
    //           Icons.arrow_back_ios_sharp,
    //           color: unselectLabelColor,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       actions: [
    //         GestureDetector(
    //           onTap: () {},
    //           child: SvgPicture.asset(ImageAssets.icUnion),
    //         ),
    //         const SizedBox(
    //           width: 18.5,
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: SvgPicture.asset(ImageAssets.icSetting),
    //         ),
    //         const SizedBox(
    //           width: 18.5,
    //         ),
    //       ],
    //     ),
    //     body: Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 16),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             StreamBuilder<List<ThongBaoModel>>(
    //               stream: thongBaoCubit.thongBaoStream,
    //               builder: (context, snapshot) {
    //                 if (!snapshot.hasData) {
    //                   return Container();
    //                 }
    //
    //                 final data = snapshot.data ?? [];
    //
    //                 return ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: data.length,
    //                   itemBuilder: (context, index) {
    //                     return ItemThongBaoTablet(
    //                       image: data[index].image,
    //                       title: data[index].title,
    //                       content: data[index].content,
    //                       time: data[index].time,
    //                       status: data[index].status,
    //                       typeNotify: data[index].typeNotify,
    //                     );
    //                   },
    //                 );
    //               },
    //             ),
    //             const SizedBox(
    //               height: 49.5,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   S.current.thong_bao_khan,
    //                   style: textNormalCustom(
    //                     color: titleColor,
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //                 CustomSwitch(
    //                   onToggle: (value) {
    //                     thongBaoCubit.isSwitch = value;
    //                     setState(() {});
    //                   },
    //                   value: thongBaoCubit.isSwitch,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 29.5,
    //             ),
    //             if (thongBaoCubit.isSwitch)
    //               StreamBuilder<List<ThongBaoModel>>(
    //                 stream: thongBaoCubit.canhBaoStream,
    //                 builder: (context, snapshot) {
    //                   if (!snapshot.hasData) {
    //                     return Container();
    //                   }
    //
    //                   final data = snapshot.data ?? [];
    //
    //                   return ListView.builder(
    //                     shrinkWrap: true,
    //                     itemCount: data.length,
    //                     itemBuilder: (context, index) {
    //                       return ItemThongBaoTablet(
    //                         image: data[index].image,
    //                         title: data[index].title,
    //                         content: data[index].content,
    //                         time: data[index].time,
    //                         status: data[index].status,
    //                         typeNotify: data[index].typeNotify,
    //                       );
    //                     },
    //                   );
    //                 },
    //               )
    //             else
    //               Container(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
