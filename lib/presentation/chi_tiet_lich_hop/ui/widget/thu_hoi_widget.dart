import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/phan_cong_thu_ky.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class ThuHoiLichWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const ThuHoiLichWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _ThuHoiLichWidgetState createState() => _ThuHoiLichWidgetState();
}

class _ThuHoiLichWidgetState extends State<ThuHoiLichWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getDanhSachThuHoiLichHop(widget.cubit.idCuocHop);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectThuHoiWidget(
            cubit: widget.cubit,
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: APP_DEVICE == DeviceType.MOBILE
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 100),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.thu_hoi,
              onClickLeft: () {
                Navigator.pop(context);
              },
              onClickRight: () {
                showDiaLog(
                  context,
                  icon:SvgPicture.asset(ImageAssets.icXacNhanThuHoi) ,
                  textContent: S.current.thu_hoi_chi_tiet_lich_hop,
                  btnLeftTxt: S.current.khong,
                  funcBtnRight: () {
                    widget.cubit.postThuHoiHop(
                      widget.id,
                    );
                    Navigator.pop(context);
                  },
                  title: S.current.thu_hoi_ket_luan_hop,
                  btnRightTxt: S.current.dong_y,
                  showTablet: true,
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class SelectThuHoiWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const SelectThuHoiWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SelectThuHoiWidget> createState() => _SelectThuHoiWidgetState();
}

class _SelectThuHoiWidgetState extends State<SelectThuHoiWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SelectTHuHoiCell(
          controller: controller,
          cubit: widget.cubit,
        ),
      ],
    );
  }
}

class SelectTHuHoiCell extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  final TextEditingController controller;

  const SelectTHuHoiCell({
    Key? key,
    required this.controller,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(7.0.textScale(space: 5)),
      decoration: BoxDecoration(
        boxShadow: APP_DEVICE == DeviceType.MOBILE
            ? []
            : [
                BoxShadow(
                  color: shadowContainerColor.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                )
              ],
        border: Border.all(
          color: APP_DEVICE == DeviceType.MOBILE
              ? borderButtomColor
              : borderColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.0.textScale())),
        color: Colors.white,
      ),
      child: StreamBuilder<List<NguoiChutriModel>>(
        stream: cubit.listThuHoi,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          final dataSN = data
              .where((e) => e.trangThai == CoperativeStatus.Revoked)
              .toList();
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              DropDownSearchThuHoi(
                hintText: S.current.chon_can_bo_hoac_don_vi_de_thu_hoi,
                title: S.current.thu_hoi_lich,
                listSelect: data,
                onChange: (vl) {
                  if (cubit.dataThuKyOrThuHoiDeFault[vl].trangThai ==
                      CoperativeStatus.Revoked) {
                    cubit.dataThuKyOrThuHoiDeFault[vl].trangThai =
                        CoperativeStatus.Accepted;
                  } else {
                    cubit.dataThuKyOrThuHoiDeFault[vl].trangThai =
                        CoperativeStatus.Revoked;
                  }
                  cubit.listThuHoi.sink.add(cubit.dataThuKyOrThuHoiDeFault);
                },
              ),
              wrapThis(
                listData: dataSN,
                cubit: cubit,
                isPhanCongThuKy: false,
              )
            ],
          );
        },
      ),
    );
  }
}

class DropDownSearchThuHoi extends StatefulWidget {
  final List<NguoiChutriModel> listSelect;
  final String title;
  final Function(int) onChange;
  final String hintText;

  const DropDownSearchThuHoi({
    Key? key,
    required this.listSelect,
    this.title = '',
    required this.onChange,
    this.hintText = '',
  }) : super(key: key);

  @override
  State<DropDownSearchThuHoi> createState() => _DropDownSearchThuHoiState();
}

class _DropDownSearchThuHoiState extends State<DropDownSearchThuHoi> {
  final TextEditingController textEditingController = TextEditingController();
  BehaviorSubject<List<NguoiChutriModel>> searchItemSubject = BehaviorSubject();
  List<NguoiChutriModel> searchList = [];
  NguoiChutriModel select = NguoiChutriModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showListItem(context);
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: select.hoTen == ''
                ? Text(
                    widget.hintText,
                    style: textNormal(
                      titleItemEdit,
                      14.0.textScale(),
                    ),
                  )
                : Text(
                    '',
                    style: tokenDetailAmount(
                      fontSize: 14.0.textScale(),
                      color: color3D5586,
                    ),
                  ),
          ),
          const Positioned(
            right: 5,
            top: 6,
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AqiColor,
            ),
          ),
        ],
      ),
    );
  }

  void showListItem(BuildContext context) {
    searchItemSubject = BehaviorSubject.seeded(widget.listSelect);
    if (isMobile()) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).viewInsets.bottom <= kHeightKeyBoard
                        ? 100
                        : 20,
                horizontal: 20,
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Container(
                  decoration: const BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 56,
                          child: Stack(
                            children: [
                              Align(
                                child: Text(
                                  widget.title,
                                  style: titleAppbar(
                                    fontSize: 18.0.textScale(space: 6.0),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(ImageAssets.icClose),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(child: dialogCell()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      showDiaLogTablet(context,
          title: widget.title, child: dialogCell(), funcBtnOk: () {});
    }
  }

  int selectIndex() {
    final index = widget.listSelect.indexOf(select);
    return index;
  }

  Widget dialogCell() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseSearchBar(
          onChange: (keySearch) {
            bool isListThuKy(NguoiChutriModel thuKy) {
              return thuKy
                  .title()
                  .toLowerCase()
                  .vietNameseParse()
                  .contains(keySearch);
            }

            searchList = widget.listSelect
                .where(
                  (item) => isListThuKy(item),
                )
                .toList();
            searchItemSubject.sink.add(searchList);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<List<NguoiChutriModel>>(
            stream: searchItemSubject,
            builder: (context, snapshot) {
              final listData = snapshot.data ?? [];
              return listData.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: NodataWidget(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final itemTitle =
                            snapshot.data?[index] ?? NguoiChutriModel();
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              select = itemTitle;
                            });
                            widget.onChange(selectIndex());
                            Navigator.of(context).pop();
                            searchItemSubject.close();
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itemTitle.title(),
                                    style: textNormalCustom(
                                      color: titleItemEdit,
                                      fontWeight: itemTitle == select
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (itemTitle.trangThai == 4)
                                  const Icon(
                                    Icons.done_sharp,
                                    color: buttonColor,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: borderColor,
                        );
                      },
                      itemCount: snapshot.data?.length ?? 0,
                    );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
