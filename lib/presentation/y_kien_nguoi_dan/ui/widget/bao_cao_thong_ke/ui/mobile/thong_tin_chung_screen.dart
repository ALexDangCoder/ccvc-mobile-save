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
    print('----------------------------- startDate ${widget.cubit.startDate}------------');
    widget.cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: widget.cubit.selectSearch,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? SafeArea(
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: cellColorborder,
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        // focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: tokenDetailAmount(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          prefixIcon: GestureDetector(
                            onTap: () {
                              widget.cubit.setSelectSearch();
                            },
                            child: const Icon(
                              Icons.search,
                              color: coloriCon,
                            ),
                          ),
                          suffixIcon: widget.cubit.showCleanText
                              ? GestureDetector(
                                  onTap: () {
                                    controller.clear();
                                    widget.cubit.showCleanText = false;
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: coloriCon,
                                  ),
                                )
                              : const SizedBox(),
                          border: InputBorder.none,
                          hintText: S.current.tim_kiem,
                          hintStyle: const TextStyle(
                            color: coloriCon,
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (searchText) {
                          if (searchText.isEmpty) {
                            setState(() {});
                            widget.cubit.showCleanText = false;
                          }
                          setState(() {});
                          widget.cubit.showCleanText = true;
                        },
                        onSubmitted: (searchText) {},
                      ),
                    ),
                )
                : AppBar(
                  elevation: 0.0,
                  title: Text(
                    S.current.thong_tin_pakn,
                    style:
                        titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
                  ),
                  leading: IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: SvgPicture.asset(
                      ImageAssets.icBack,
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        // widget.cubit.setSelectSearch();
                        widget.cubit.setSelectSearch();
                      },
                      child: SvgPicture.asset(ImageAssets.icSearchPAKN),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
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
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                  centerTitle: true,
                );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterDateTimeWidget(
              currentStartDate: widget.cubit.startDate,
              context: context,
              isMobile: true,
              onChooseDateFilter: (DateTime startDate, DateTime endDate) {},
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpandPAKNWidget(
                name: S.current.tinh_hinh_xu_ly_pakn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TiepCanWidget(),
                    SizedBox(
                      height: 33,
                    ),
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
