import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RecallCalendar extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final Function() callback;

  const RecallCalendar({
    Key? key,
    required this.cubit,
    required this.callback,
  }) : super(key: key);

  @override
  _RecallCalendarState createState() => _RecallCalendarState();
}

class _RecallCalendarState extends State<RecallCalendar> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChiTietLichLamViecCubit, ChiTietLichLamViecState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is SuccessChiTietLichLamViecState) {
          Navigator.pop(context, true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectTHuHoiCell(
              cubit: widget.cubit,
            ),
            const SizedBox(
              height: 36,
            ),
            Padding(
              padding: APP_DEVICE == DeviceType.MOBILE
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 100),
              child: StreamBuilder<List<Officer>>(
                  stream: widget.cubit.listRecall.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    final dataSN = data
                        .where((element) => element.status == 4)
                        .map((e) => e.getTitle())
                        .toList();
                    return DoubleButtonBottom(
                      disable: dataSN.isEmpty,
                      title1: S.current.dong,
                      title2: S.current.thu_hoi,
                      onClickLeft: () {
                        Navigator.pop(context);
                      },
                      onClickRight: () {
                        if (dataSN.isNotEmpty) {
                          widget.callback();
                        }
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTHuHoiCell extends StatelessWidget {
  final ChiTietLichLamViecCubit cubit;

  const SelectTHuHoiCell({
    Key? key,
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
      child: StreamBuilder<List<Officer>>(
        stream: cubit.listRecall.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          final dataSN = data
              .where((element) => element.status == 4)
              .map((e) => e.getTitle())
              .toList();
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              DropDownSearchThuHoi(
                cubit: cubit,
                showHintText: dataSN.isEmpty,
                title: S.current.thu_hoi_lich,
                listSelect: data,
                hintText: S.current.chon_can_bo_hoac_don_vi_de_thu_hoi,
                onChange: (vl) {
                  if (cubit.dataRecall[vl].status == 4) {
                    cubit.dataRecall[vl].status = 0;
                  } else {
                    cubit.dataRecall[vl].status = 4;
                  }
                  cubit.listRecall.sink.add(cubit.dataRecall);
                },
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(dataSN.length, (index) {
                  final dataSnb = dataSN[index];
                  return tag(
                    title: dataSnb,
                    onDelete: () {
                      cubit
                          .dataRecall[cubit.dataRecall.indexWhere(
                              (element) => element.getTitle() == dataSnb)]
                          .status = 0;
                      cubit.listRecall.sink.add(cubit.dataRecall);
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget tag({required String title, required Function() onDelete}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().colorField().withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            child: Text(
              title,
              style: textNormal(
                AppTheme.getInstance().colorField(),
                12.0.textScale(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              onDelete();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 9.25),
              child: SvgPicture.asset(
                ImageAssets.icClose,
                width: 7.5,
                height: 7.5,
                color: AppTheme.getInstance().colorField(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DropDownSearchThuHoi extends StatefulWidget {
  final List<Officer> listSelect;
  final ChiTietLichLamViecCubit cubit;
  final String title;
  final Function(int) onChange;
  final String hintText;
  final bool showHintText;

  const DropDownSearchThuHoi({
    Key? key,
    required this.listSelect,
    this.title = '',
    required this.onChange,
    this.hintText = '',
    required this.cubit,
    this.showHintText = true,
  }) : super(key: key);

  @override
  State<DropDownSearchThuHoi> createState() => _DropDownSearchThuHoiState();
}

class _DropDownSearchThuHoiState extends State<DropDownSearchThuHoi> {
  final TextEditingController textEditingController = TextEditingController();
  Officer select = Officer();

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
            child: widget.showHintText
                ? Text(
                    widget.hintText,
                    style: textNormal(
                      textBodyTime,
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
        },
      ).then((value) => widget.cubit.keySearchThuHoi.sink.add(''));
    } else {
      showDiaLogTablet(
        context,
        isCenterTitle: true,
        title: widget.title,
        child: dialogCell(),
        isBottomShow: false,
        funcBtnOk: () {},
      ).then((value) => widget.cubit.keySearchThuHoi.sink.add(''));
    }
  }

  int selectIndex() {
    final index = widget.listSelect.indexOf(select);
    return index;
  }

  Widget dialogCell() {
    final listData = widget.cubit.dataRecall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isMobile())
          const SizedBox(
            height: 16.0,
          ),
        BaseSearchBar(
          onChange: (keySearch) {
            widget.cubit.keySearchThuHoi.sink.add(keySearch);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: listData.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: NodataWidget(),
                )
              : StreamBuilder<String>(
                  stream: widget.cubit.keySearchThuHoi.stream,
                  builder: (context, snapshot) {
                    final keySearch = snapshot.data ?? '';
                    final listResult = <Officer>[];
                    for (final item in listData) {
                      if (getKeySearch(item.getTitle()).contains(
                        getKeySearch(keySearch),
                      )) {
                        listResult.add(item);
                      }
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final itemTitle = listResult[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              select = itemTitle;
                            });
                            widget.onChange(selectIndex());
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itemTitle.getTitle(),
                                    style: textNormalCustom(
                                      color: titleItemEdit,
                                      fontWeight: itemTitle == select
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (itemTitle.status == 4)
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
                      itemCount: listResult.length,
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

  String getKeySearch(String keySearch) =>
      keySearch.toLowerCase().vietNameseParse().trim();
}
