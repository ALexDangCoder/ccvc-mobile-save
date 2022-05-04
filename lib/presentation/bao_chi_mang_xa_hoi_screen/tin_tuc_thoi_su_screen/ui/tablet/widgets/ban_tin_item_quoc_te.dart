import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_btn_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/item_tin_radio_trong_nuoc_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BanTinItemQuocTeTablet extends StatefulWidget {
  final String title;
  final String description;
  final Function() clickPLay;
  final Function() clickXemThem;
  final List<TinTucRadioModel> listTinTuc;
  final TinTucThoiSuBloc tinTucThoiSuBloc;

  const BanTinItemQuocTeTablet({
    Key? key,
    required this.listTinTuc,
    required this.clickXemThem,
    required this.title,
    required this.tinTucThoiSuBloc,
    required this.description,
    required this.clickPLay,
  }) : super(key: key);

  @override
  _BanTinItemQuocTeTabletState createState() => _BanTinItemQuocTeTabletState();
}

class _BanTinItemQuocTeTabletState extends State<BanTinItemQuocTeTablet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: textNormalCustom(
            color: AppTheme.getInstance().colorField(),
            fontSize: 14.0.textScale(space: 6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.description,
          style: textNormalCustom(
            color: dateColor,
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 380,
                decoration: BoxDecoration(
                  color: backgroundColorApp,
                  boxShadow: [
                    BoxShadow(
                      color: shadowContainerColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cellColorborder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.clickPLay();
                      },
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: SvgPicture.asset(ImageAssets.icPlay,color: AppTheme.getInstance().colorField(),),
                      ),
                    ),
                    Image.asset(
                      ImageAssets.ic_dongnai_title,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            Expanded(
              flex: 13,
              child: SizedBox(
                height: 380,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                hint: const Text('Mới Nhất'),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(ImageAssets.ic_xem_them,color: AppTheme.getInstance().colorField(),),
                          onTap: () {
                            widget.clickXemThem();
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (widget.listTinTuc.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.listTinTuc.length > 2
                              ? 2
                              : widget.listTinTuc.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ItemTinRadioTrongNuocTablet(
                                widget.listTinTuc[index].urlImage?[0] ?? '',
                                widget.listTinTuc[index].title,
                                DateTime.parse(widget
                                        .listTinTuc[index].publishedTime
                                        .replaceAll('/', '-')
                                        .replaceAll(' ', 'T'))
                                    .formatApiSSAM,
                                url: widget.listTinTuc[index].url,
                                clickItem: () {
                                  showBottomSheetCustom(
                                    context,
                                    title: S.current.ban_tin_trua_ngay,
                                    child: BanTinBtnSheetTablet(
                                      listTinTuc: widget
                                          .tinTucThoiSuBloc.listTinTucQuocTe,
                                      index:index,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Expanded(child: Center(child: NodataWidget())),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
