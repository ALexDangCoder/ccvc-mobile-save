import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinChungYKNDScreen extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDScreenState createState() =>
      _ThongTinChungYKNDScreenState();
}

class _ThongTinChungYKNDScreenState extends State<ThongTinChungYKNDScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.cubit.initTimeRange();
    widget.cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          color: Colors.red,
          child: StreamBuilder<bool>(
            stream: widget.cubit.selectSreach,
            builder: (context, snapshot) {
              final selectData = snapshot.data ?? false;
              return selectData
                  ? TextFormField(
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                  widget.cubit.search = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.current.tim_kiem,
                  hintStyle: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: unselectLabelColor,
                  ),
                ),
              )
                  : Text(
                S.current.thong_tin_pakn,
                style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
              );
            },
          ),
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              ImageAssets.icBack,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              widget.cubit.setSelectSearch();
            },
            child: SvgPicture.asset(ImageAssets.icSearchPAKN),
          ),
          const SizedBox(width: 16,),
          GestureDetector(
            onTap: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: YKienNguoiDanMenu(
                  cubit: widget.cubit,
                ),
              );
            },
            child: SvgPicture.asset(ImageAssets.icMenuCalender),
          ),
          const SizedBox(width: 16,),
        ],
        // centerTitle: true,
      ),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: StreamBuilder<bool>(
      //     stream: widget.cubit.selectSreach,
      //     builder: (context, snapshot) {
      //       final selectData = snapshot.data ?? false;
      //       return selectData
      //           ? TextFormField(
      //         controller: controller,
      //         onChanged: (value) {
      //           setState(() {});
      //           widget.cubit.search = value;
      //         },
      //         decoration: InputDecoration(
      //           border: InputBorder.none,
      //           hintText: S.current.tim_kiem,
      //           hintStyle: textNormalCustom(
      //             fontSize: 14,
      //             fontWeight: FontWeight.w400,
      //             color: unselectLabelColor,
      //           ),
      //         ),
      //       )
      //           : Text(
      //         S.current.thong_tin_pakn,
      //         style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
      //       );
      //     },
      //   ),
      //   leading: IconButton(
      //     onPressed: () => {Navigator.pop(context)},
      //     icon: SvgPicture.asset(
      //       ImageAssets.icBack,
      //     ),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         widget.cubit.setSelectSearch();
      //       },
      //       child: SvgPicture.asset(ImageAssets.icSearchPAKN),
      //     ),
      //     const SizedBox(width: 16,),
      //     GestureDetector(
      //       onTap: () {
      //         DrawerSlide.navigatorSlide(
      //           context: context,
      //           screen: YKienNguoiDanMenu(
      //             cubit: widget.cubit,
      //           ),
      //         );
      //       },
      //       child: SvgPicture.asset(ImageAssets.icMenuCalender),
      //     ),
      //     const SizedBox(width: 16,),
      //   ],
      //   centerTitle: true,
      // ),

      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterDateTimeWidget(
              currentStartDate:widget.cubit.startDate,
              context: context,
              isMobile: true,
              onChooseDateFilter: (DateTime startDate, DateTime endDate) {

              },
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpandPAKNWidget(
                name: S.current.tinh_hinh_xu_ly_pakn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const[
                    TiepCanWidget(),
                    SizedBox(height: 33,),
                    XuLyWidget(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              color: homeColor,
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
