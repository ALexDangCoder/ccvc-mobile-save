import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/select_don_vi_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SearchBaoCaoThongKeWidget extends StatefulWidget {
  final String startDate;
  final String endDate;
  final Function(List<Node<DonViModel>>) onChange;
  final List<DonViModel> listSelectNode;
  final ThanhPhanThamGiaCubit cubit;
  final List<Node<DonViModel>> listNode;
  final Function(
    List<String> donViID,
  ) onSearch;

  const SearchBaoCaoThongKeWidget({
    Key? key,
    required this.onChange,
    this.listSelectNode = const [],
    required this.onSearch,
    required this.cubit,
    required this.startDate,
    required this.endDate,
    this.listNode = const [],
  }) : super(key: key);

  @override
  State<SearchBaoCaoThongKeWidget> createState() =>
      _SearchBaoCaoThongKeWidgetState();
}

class _SearchBaoCaoThongKeWidgetState extends State<SearchBaoCaoThongKeWidget> {
  final ThemDonViCubit _themDonViCubit = ThemDonViCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getTreeDonVi.listen((event) {
      _themDonViCubit.getTreeDonVi(event);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _themDonViCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeDonVi(
      startDate: widget.startDate,
      endDate: widget.endDate,
      themDonViCubit: _themDonViCubit,
      onSearch: widget.onSearch,
      listNode: widget.listNode,
    );
  }
}

class TreeDonVi extends StatefulWidget {
  final String startDate;
  final String endDate;
  final ThemDonViCubit themDonViCubit;
  final Function(
    List<String> donViID,
  ) onSearch;
  final List<Node<DonViModel>> listNode;
  const TreeDonVi({
    Key? key,
    required this.themDonViCubit,
    required this.onSearch,
    required this.startDate,
    required this.endDate,
    this.listNode = const [],
  }) : super(key: key);

  @override
  State<TreeDonVi> createState() => _TreeDonViState();
}

class _TreeDonViState extends State<TreeDonVi> {
  late String selectStartDate;
  late String selectEndDate;
  List<String> donViID = [];

  @override
  void initState() {
    super.initState();
    selectStartDate = widget.startDate;
    selectEndDate = widget.endDate;
    widget.themDonViCubit.selectDonVi.listen((event) {
      donViID = event.map((e) => e.value.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0.textScale(space: 4),
          ),
          SelectSearchDonViWidget(
            themDonViCubit: widget.themDonViCubit,
            data: widget.listNode,
          ),
          SizedBox(
            height: 18.0.textScale(),
          ),
          Text(
            S.current.danh_sach_don_vi_tham_gia,
            style: textNormal(textTitle, 16),
          ),
          SizedBox(
            height: 22.0.textScale(space: -9),
          ),
          Flexible(
            child: StreamBuilder<List<Node<DonViModel>>>(
              stream: widget.themDonViCubit.getTree,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <Node<DonViModel>>[];
                if (data.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    keyboardDismissBehavior: isMobile()
                        ? ScrollViewKeyboardDismissBehavior.onDrag
                        : ScrollViewKeyboardDismissBehavior.manual,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TreeViewWidget(
                        themDonViCubit: widget.themDonViCubit,
                        node: data[index],
                      );
                    },
                  );
                }
                return Column(
                  children: const [
                    NodataWidget(),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                S.current.tu_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              const Text('~'),
              const SizedBox(
                width: 1,
              ),
              Text(
                S.current.den_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: DateFormat(DateFormatApp.date)
                      .parse(widget.startDate)
                      .toString(),
                  onSelectDate: (dateTime) {
                    selectStartDate =
                        DateFormat(DateFormatApp.pickDateSearchFormat)
                            .parse(dateTime)
                            .toStringWithListFormat;
                  },
                ),
              ),
              const SizedBox(
                width: 40,
                child: Center(
                  child: Text('~'),
                ),
              ),
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: DateFormat(DateFormatApp.date)
                      .parse(widget.endDate)
                      .toString(),
                  onSelectDate: (dateTime) {
                    selectEndDate = DateFormat(
                      DateFormatApp.pickDateSearchFormat,
                    ).parse(dateTime).toStringWithListFormat;
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          screenDevice(
            mobileScreen: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ButtonCustomBottom(
                    title: S.current.dong,
                    isColorBlue: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ButtonCustomBottom(
                    title: S.current.tim_kiem,
                    isColorBlue: true,
                    onPressed: () {
                      eventBus.fire(
                        DateSearchEvent(
                          selectStartDate,
                          selectEndDate,
                        ),
                      );
                      widget.onSearch(donViID);
                      Navigator.pop(context, false);
                    },
                  ),
                ),
              ],
            ),
            tabletScreen: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 44,
                  width: 142,
                  child: ButtonCustomBottom(
                    title: S.current.dong,
                    isColorBlue: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  height: 44,
                  width: 142,
                  child: ButtonCustomBottom(
                    title: S.current.tim_kiem,
                    isColorBlue: true,
                    onPressed: () {
                      eventBus.fire(
                        DateSearchEvent(
                          selectStartDate,
                          selectEndDate,
                        ),
                      );
                      widget.onSearch(donViID);
                      Navigator.pop(context, false);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
        ],
      ),
    );
  }
}
