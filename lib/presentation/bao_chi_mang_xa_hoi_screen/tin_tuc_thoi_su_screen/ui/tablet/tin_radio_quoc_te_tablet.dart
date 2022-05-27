import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_btn_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/item_tin_radio_trong_nuoc_tablet.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:readmore/readmore.dart';

class TinRadioQuocTeTabletScreen extends StatefulWidget {
  final String title;
  final List<TinTucRadioModel> listBanTin;
  final TinTucThoiSuBloc tinTucThoiSuBloc;
  final BuildContext pContext;

  const TinRadioQuocTeTabletScreen({
    Key? key,
    required this.title,
    required this.listBanTin,
    required this.tinTucThoiSuBloc,
    required this.pContext,
  }) : super(key: key);

  @override
  _TinRadioQuocTeTabletScreenState createState() =>
      _TinRadioQuocTeTabletScreenState();
}

class _TinRadioQuocTeTabletScreenState
    extends State<TinRadioQuocTeTabletScreen> {
  late List<TinTucRadioModel> listTinTuc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCalenderColor,
      appBar: AppBarDefaultBack(
        widget.title,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    ImageAssets.ic_bg_radio,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 124,
                        width: 124,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              ImageAssets.icDongNai,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.ubnd_dongnai,
                            style: textNormalCustom(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0.textScale(space: 20),
                              color: backgroundColorApp,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            S.current.tin_radio,
                            style: textNormalCustom(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0.textScale(space: 8),
                              color: backgroundColorApp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Text(
                        S.current.sap_xep_theo,
                        style: textNormalCustom(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.textScale(),
                          color: infoColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        color: backgroundColorApp,
                        height: 50,
                        width: 160,
                        child: CustomDropDown(
                          items: ['A', 'B', "c"],
                          onSelectItem: (value) {},
                          hint: const Text('Mới nhất'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    S.current.thong_tin_gioi_thieu,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.textScale(space: 4),
                      color: titleCalenderWork,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 2,
                          color: colorECEEF7,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListViewLoadMore(
                            cubit: widget.tinTucThoiSuBloc,
                            isListView: true,
                            callApi: (page) => {
                              callApiQuocTe(
                                page,
                              )
                            },
                            viewItem: (value, index) => itemTinTucThoiSuQuocTe(
                                value as TinTucRadioModel, index ?? 0),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ReadMoreText(
                              'Kênh radio chính thức của UBND tỉnh Đồng Nai. '
                              'Kênh radio chính thức của UBND tỉnh Đồng Nai '
                              'Kênh radio chính thức của UBND tỉnh Đồng Nai '
                              'Kênh radio chính thức của UBND tỉnh Đồng Nai '
                              'Kênh radio chính thức của UBND tỉnh Đồng Nai '
                              'Kênh radio chính thức của UBND tỉnh Đồng NaiKênh '
                              'Kênh radio chính thức của UBND tỉnh Đồng NaiKênh '
                              'Kênh radio chính thức của UBND tỉnh Đồng NaiKênh '
                              'radio chính thức của UBND tỉnh Đồng NaiKênh radio chính'
                              ' thức của UBND tỉnh Đồng Nai',
                              trimLines: 6,
                              colorClickableText: labelColor,
                              trimMode: TrimMode.Line,
                              style: textNormalCustom(
                                color: infoColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              trimCollapsedText: 'Xem thêm',
                              trimExpandedText: 'Thu gọn',
                              moreStyle: textNormalCustom(
                                color: labelColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callApiQuocTe(int page) {
    widget.tinTucThoiSuBloc
        .getListTinTucRadioQuocTe(page, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget itemTinTucThoiSuQuocTe(TinTucRadioModel data, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ItemTinRadioTrongNuocTablet(
        data.urlImage?[0] ?? '',
        data.title,
        DateTime.parse(
                data.publishedTime.replaceAll('/', '-').replaceAll(' ', 'T'))
            .formatApiSSAM,
        clickItem: () {
          showBottomSheetCustom(
            widget.pContext,
            title: S.current.ban_tin_trua_ngay,
            child: BanTinBtnSheetTablet(
              listTinTuc: widget.tinTucThoiSuBloc.listTinTucQuocTe,
              index: index,
            ),
          );
        },
        url: data.url,
      ),
    );
  }
}
