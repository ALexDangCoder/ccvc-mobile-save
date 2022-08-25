import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/row_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/them_phien_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/sua_phien_hop.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChuongTrinhHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ChuongTrinhHopWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ChuongTrinhHopWidget> createState() => _ChuongTrinhHopWidgetState();
}

class _ChuongTrinhHopWidgetState extends State<ChuongTrinhHopWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isMobile()) {
      widget.cubit.callApiChuongTrinhHop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value && isMobile()) {
            widget.cubit.callApiChuongTrinhHop();
          }
        },
        title: S.current.chuong_trinh_hop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceH10,
            buttonThemPhienHop(),
            spaceH20,
            listPhienHopWidget()
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH10,
              buttonThemPhienHop(),
              spaceH20,
              listPhienHopWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonThemPhienHop() {
    if (widget.cubit.isBtnThemSuaXoaPhienHop()) {
      return SolidButton(
        text: S.current.them_phien_hop,
        urlIcon: ImageAssets.icAddButtonCalenderTablet,
        onTap: () {
          if (isMobile()) {
            showBottomSheetCustom(
              context,
              child: ThemPhienHopScreen(
                id: widget.cubit.idCuocHop,
                cubit: widget.cubit,
              ),
              title: S.current.them_phien_hop,
            );
            return;
          }
          showDiaLogTablet(
            context,
            title: S.current.them_phien_hop,
            child: ThemPhienHopScreen(
              cubit: widget.cubit,
              id: widget.cubit.idCuocHop,
            ),
            isBottomShow: false,
            funcBtnOk: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
    return const SizedBox();
  }

  Widget listPhienHopWidget() => StreamBuilder<List<ListPhienHopModel>>(
        stream: widget.cubit.danhSachChuongTrinhHop.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const NodataWidget(
              height: 50.0,
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return cellDetailMeet(
                listPhienHopModel: data[index],
                context: context,
                id: widget.cubit.idCuocHop,
              );
            },
          );
        },
      );

  Widget cellDetailMeet({
    required ListPhienHopModel listPhienHopModel,
    required BuildContext context,
    required String id,
  }) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: borderItemCalender),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    (listPhienHopModel.tieuDe ?? '').removeSpace,
                    style: titleAppbar(
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RowDataWidget(
                  keyTxt: S.current.thoi_gian,
                  value: listPhienHopModel.dateTimeView(),
                ),
                const SizedBox(height: 8),
                RowDataWidget(
                  keyTxt: S.current.nguoi_phu_trach,
                  value: listPhienHopModel.hoTen ?? '',
                ),
                const SizedBox(height: 8),
                RowDataWidget(
                  keyTxt: S.current.noidung,
                  value: listPhienHopModel.noiDung ?? '',
                ),
                const SizedBox(height: 8),
                listFileDinhKem(
                  keyTxt: S.current.file_dinh_kem,
                  listPhienHopModel: listPhienHopModel,
                ),
              ],
            ),
            if (widget.cubit.isBtnThemSuaXoaPhienHop())
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            child: SuaPhienHopScreen(
                              id: listPhienHopModel.id ?? '',
                              cubit: widget.cubit,
                              phienHopModel: listPhienHopModel,
                              lichHopId: id,
                            ),
                          ),
                          title: S.current.sua_phien_hop,
                        ).then((value) {
                          if (value == true) {
                            widget.cubit.callApiChuongTrinhHop();
                          } else if (value == null) {
                            return;
                          }
                        });
                      },
                      child: SvgPicture.asset(ImageAssets.icEditBlue),
                    ),
                    spaceW16,
                    GestureDetector(
                      onTap: () {
                        showDiaLog(
                          context,
                          title: S.current.xoa_chuong_trinh_hop,
                          icon: SvgPicture.asset(
                            ImageAssets.deleteChuongTrinhHop,
                          ),
                          btnLeftTxt: S.current.khong,
                          btnRightTxt: S.current.dong_y,
                          funcBtnRight: () {
                            widget.cubit
                                .xoaChuongTrinhHop(
                              id: listPhienHopModel.id ?? '',
                            )
                                .then((value) {
                              if (value) {
                                widget.cubit.callApiChuongTrinhHop();
                              }
                            });
                          },
                          showTablet: false,
                          textContent: S.current.conten_xoa_chuong_trinh,
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.ic_delete_do),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
      tabletScreen: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: borderItemCalender),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    listPhienHopModel.tieuDe ?? '',
                    style: titleAppbar(
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              S.current.thoi_gian,
                              style: textDetailHDSD(
                                fontSize: 14.0.textScale(),
                                color: infoColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              S.current.nguoi_phu_trach,
                              style: textDetailHDSD(
                                fontSize: 14.0.textScale(),
                                color: infoColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              S.current.noidung,
                              style: textDetailHDSD(
                                fontSize: 14.0.textScale(),
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            listPhienHopModel.dateTimeView(),
                            style: textDetailHDSD(
                              fontSize: 14.0.textScale(),
                              color: textTitle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            listPhienHopModel.hoTen ?? '',
                            style: textDetailHDSD(
                              fontSize: 14.0.textScale(),
                              color: textTitle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            listPhienHopModel.noiDung ?? '',
                            style: textDetailHDSD(
                              fontSize: 14.0.textScale(),
                              color: textTitle,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.file_dinh_kem}                      ',
                      style: textDetailHDSD(
                        fontSize: 14.0.textScale(),
                        color: infoColor,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listPhienHopModel.files.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = listPhienHopModel.files.toList();
                          return GestureDetector(
                            onTap: () {
                              saveFile(
                                  fileName: data[index].name ?? '',
                                  url: data[index].path ?? '');
                            },
                            child: Text(
                              data[index].name ?? S.current.khong_co_tep_nao,
                              style: textDetailHDSD(
                                fontSize: 14.0.textScale(),
                                color: color5A8DEE,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            if (widget.cubit.isBtnThemSuaXoaPhienHop())
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDiaLogTablet(
                          context,
                          title: S.current.sua_phien_hop,
                          child: SuaPhienHopScreen(
                            id: listPhienHopModel.id ?? '',
                            cubit: widget.cubit,
                            phienHopModel: listPhienHopModel,
                            lichHopId: id,
                          ),
                          isBottomShow: false,
                          funcBtnOk: () {
                            Navigator.pop(context);
                          },
                        ).then((value) {
                          if (value == true) {
                            widget.cubit.callApiChuongTrinhHop();
                          } else if (value == null) {
                            return;
                          }
                        });
                      },
                      child: SvgPicture.asset(ImageAssets.icEditBlue),
                    ),
                    spaceW16,
                    GestureDetector(
                      onTap: () {
                        showDiaLog(
                          context,
                          title: S.current.xoa_chuong_trinh_hop,
                          icon: SvgPicture.asset(
                            ImageAssets.deleteChuongTrinhHop,
                          ),
                          btnLeftTxt: S.current.khong,
                          btnRightTxt: S.current.dong_y,
                          funcBtnRight: () {
                            widget.cubit
                                .xoaChuongTrinhHop(
                              id: listPhienHopModel.id ?? '',
                            )
                                .then((value) {
                              if (value) {
                                widget.cubit.callApiChuongTrinhHop();
                              }
                            });
                          },
                          showTablet: false,
                          textContent: S.current.conten_xoa_chuong_trinh,
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.ic_delete_do),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget listFileDinhKem({
    required String keyTxt,
    required ListPhienHopModel listPhienHopModel,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              keyTxt,
              style: textNormal(infoColor, 14.0.textScale()),
            ),
          ),
          spaceW30,
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: listPhienHopModel.files.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = listPhienHopModel.files;
                return GestureDetector(
                  onTap: () {
                    saveFile(
                      fileName: data[index].name ?? '',
                      url: data[index].path ?? '',
                    );
                  },
                  child: SizedBox(
                    child: Text(
                      data[index].name ?? S.current.khong_co_tep_nao,
                      style: textDetailHDSD(
                        fontSize: 14.0.textScale(),
                        color: color5A8DEE,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
}
