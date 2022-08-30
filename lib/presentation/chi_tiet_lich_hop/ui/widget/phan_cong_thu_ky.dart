import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rxdart/rxdart.dart';

class PhanCongThuKyWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const PhanCongThuKyWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _PhanCongThuKyWidgetState createState() => _PhanCongThuKyWidgetState();
}

class _PhanCongThuKyWidgetState extends State<PhanCongThuKyWidget> {
  @override
  void initState() {
    widget.cubit.getDanhSachNguoiChuTriPhienHop(
      id: widget.id,
      onlyPerson: true,
      isShowloading: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isMobile())
              Text(
                S.current.chon_thu_ky_cuoc_hop,
                style: textNormalCustom(color: infoColor),
              ),
            spaceH8,
            SelectThuKyWidget(cubit: widget.cubit),
            spaceH30,
            Padding(
              padding: APP_DEVICE == DeviceType.MOBILE
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 100),
              child: StreamBuilder<int>(
                  stream: widget.cubit.initThuKyNumber.stream,
                  builder: (context, snapshot) {
                    final initThuKyNumber = snapshot.data ?? 0;
                    return StreamBuilder<List<NguoiChutriModel>>(
                        stream: widget.cubit.listNguoiCHuTriModel,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          final currentThukyNumber = data
                              .where((e) => e.isThuKy == true)
                              .toList()
                              .length;
                          final disable =
                              initThuKyNumber == 0 && currentThukyNumber == 0;
                          return DoubleButtonBottom(
                            title1: S.current.dong,
                            title2: S.current.xac_nhan,
                            onClickLeft: () {
                              Navigator.pop(context);
                            },
                            disable: disable,
                            onClickRight: () {
                              if (!disable) {
                                widget.cubit.postPhanCongThuKy(
                                  widget.id,
                                  isShowLoading: false,
                                );
                                Navigator.pop(context);
                              }
                            },
                          );
                        });
                  }),
            ),
            spaceH16,
          ],
        ),
      ),
    );
  }
}

class SelectThuKyWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const SelectThuKyWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SelectThuKyWidget> createState() => _SelectThuKyWidgetState();
}

class _SelectThuKyWidgetState extends State<SelectThuKyWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SelectThuKyCell(
          controller: controller,
          cubit: widget.cubit,
        ),
      ],
    );
  }
}

class SelectThuKyCell extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;
  final TextEditingController controller;

  const SelectThuKyCell({
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
        stream: cubit.listNguoiCHuTriModel,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          final dataSN = data.where((e) => e.isThuKy == true).toList();
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              DropDownSearchThuKy(
                hintText: S.current.chon_thu_ky,
                title: S.current.chon_thu_ky_cuoc_hop,
                listSelect: data,
                onChange: (vl) {
                  if (cubit.dataThuKyOrThuHoiDeFault[vl].isThuKy == true) {
                    cubit.dataThuKyOrThuHoiDeFault[vl].isThuKy = false;
                  } else {
                    cubit.dataThuKyOrThuHoiDeFault[vl].isThuKy = true;
                  }
                  cubit.listNguoiCHuTriModel.sink
                      .add(cubit.dataThuKyOrThuHoiDeFault);
                  log(cubit.listNguoiCHuTriModel.value.toString());
                },
              ),
              wrapThis(
                listData: dataSN,
                cubit: cubit,
                isPhanCongThuKy: true,
                onRemove: () {},
              )
            ],
          );
        },
      ),
    );
  }
}

class DropDownSearchThuKy extends StatefulWidget {
  final List<NguoiChutriModel> listSelect;
  final String title;
  final Function(int) onChange;
  final String hintText;

  const DropDownSearchThuKy({
    Key? key,
    required this.listSelect,
    this.title = '',
    required this.onChange,
    this.hintText = '',
  }) : super(key: key);

  @override
  State<DropDownSearchThuKy> createState() => _DropDownSearchThuKyState();
}

class _DropDownSearchThuKyState extends State<DropDownSearchThuKy> {
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
            child: widget.listSelect
                    .where((element) => element.isThuKy ?? false)
                    .toList()
                    .isEmpty
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
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
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
        },
      );
    } else {
      showDiaLogTablet(
        context,
        isCenterTitle: true,
        title: widget.title,
        child: dialogCell(),
        funcBtnOk: () {},
      );
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
        if (!isMobile())
          const SizedBox(
            height: 16.0,
          ),
        BaseSearchBar(
          colorIcon: AppTheme.getInstance().colorField(),
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
                                      fontWeight:
                                          (itemTitle.isThuKy ?? false) == true
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (itemTitle.isThuKy ?? false)
                                  Icon(
                                    Icons.done_sharp,
                                    color: AppTheme.getInstance().colorField(),
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

Widget tag({required String title, required Function onDelete}) {
  return GestureDetector(
    onTap: () {
      onDelete();
    },
    child: Container(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().colorField(),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Text(
              title,
              style: textNormal(
                backgroundColorApp,
                12.0.textScale(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: SvgPicture.asset(
              ImageAssets.icClose,
              width: 7.5,
              height: 7.5,
              color: backgroundColorApp,
            ),
          )
        ],
      ),
    ),
  );
}

Widget wrapThis({
  required List<NguoiChutriModel> listData,
  required DetailMeetCalenderCubit cubit,
  required bool isPhanCongThuKy,
  required Function onRemove,
}) =>
    Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(listData.length, (index) {
        final dataSnb = listData[index];
        return tag(
          title: dataSnb.titleDonVi(),
          onDelete: () {
            final indexThis = cubit.dataThuKyOrThuHoiDeFault.indexOf(dataSnb);
            if (isPhanCongThuKy) {
              cubit.dataThuKyOrThuHoiDeFault[indexThis].isThuKy = false;
              cubit.listNguoiCHuTriModel.sink
                  .add(cubit.dataThuKyOrThuHoiDeFault);
            } else {
              cubit.dataThuKyOrThuHoiDeFault[indexThis].trangThai =
                  CoperativeStatus.WaitAccept;
              cubit.listThuHoi.sink.add(cubit.dataThuKyOrThuHoiDeFault);
            }
            onRemove();
          },
        );
      }),
    );
