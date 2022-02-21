import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PressSocialNetWorkTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const PressSocialNetWorkTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<PressSocialNetWorkTabletWidget> createState() =>
      _PressSocialNetWorkState();
}

class _PressSocialNetWorkState extends State<PressSocialNetWorkTabletWidget> {
  late HomeCubit cubit;
  final BaoChiMangXaHoiCubit _xaHoiCubit = BaoChiMangXaHoiCubit();
  final ScrollController scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
    _xaHoiCubit.getPress();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.press_socialNetWord,
      maxHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      spacingTitle: 0,
      selectKeyDialog: _xaHoiCubit,
      dialogSelect: DialogSettingWidget(
        labelWidget: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              SvgPicture.asset(ImageAssets.icTag),
              const SizedBox(
                width: 9,
              ),
              GestureDetector(
                onTap: () {
                  cubit.closeDialog();
                  _xaHoiCubit.showAddTag();
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  });
                },
                child: Text(
                  S.current.chinh_sua_tag,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: textDefault,
                  ),
                ),
              )
            ],
          ),
        ),
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value, startDate, endDate) {
              _xaHoiCubit.selectDate(
                selectKey: value,
                startDate: startDate,
                endDate: endDate,
              );
            },
            title: S.current.time,
          )
        ],
      ),
      padding: EdgeInsets.zero,
      child: Flexible(
        child: LoadingOnly(
          stream: _xaHoiCubit.stateStream,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              tagWidget(cubit),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: StreamBuilder<List<PressNetWorkModel>>(
                  stream: _xaHoiCubit.getPressNetWork,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <PressNetWorkModel>[];
                    if (data.isEmpty) {
                      return const NodataWidget();
                    }
                    return ScrollBarWidget(
                      children: List.generate(data.length, (index) {
                        final result = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => WebViewScreen(
                                    title: '',
                                    url: result.url,
                                  ),
                                ),
                              );
                            },
                            child: baoChiWidget(result),
                          ),
                        );
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget baoChiWidget(PressNetWorkModel data) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 106,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  data.avatar,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: data.avatar,
              fit: BoxFit.cover,
              errorWidget: (context, _, err) {
                return Image.network(
                  ImageConstants.noImageFound,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: textNormal(
                    titleColor,
                    14.0.textScale(space: 4),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icCalendarUnFocus),
                    const SizedBox(
                      width: 13,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 20,
                        child: FittedBox(
                          child: Text(
                            DateTime.parse(data.publishedTime).formatDdMMYYYY,
                            style: textNormal(
                              infoColor,
                              14.0.textScale(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: FittedBox(
                    child: Text(
                      data.domain,
                      style: textNormal(
                        linkColor,
                        14.0.textScale(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tagWidget(HomeCubit cubit) {
    return SizedBox(
      height: 26,
      child: StreamBuilder<List<String>>(
        initialData: const [],
        stream: _xaHoiCubit.getTag,
        builder: (context, snapshot) {
          final data = snapshot.data ?? <String>[];
          return SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final result = data[index];
                    return GestureDetector(
                      onTap: () {
                        cubit.closeDialog();
                        _xaHoiCubit.selectTag(result);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 16,
                          left: index == 0 ? 16 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: result == _xaHoiCubit.tagKey
                              ? linkColor
                              : radioFocusColor.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#$result',
                              style: textNormal(
                                result == _xaHoiCubit.tagKey
                                    ? AppTheme.getInstance().dfBtnTxtColor()
                                    : linkColor,
                                12.0.textScale(),
                              ),
                            ),
                            StreamBuilder<bool>(
                              stream: _xaHoiCubit.showAddTagStream,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? false;
                                return data
                                    ? GestureDetector(
                                        onTap: () {
                                          _xaHoiCubit.removeTag(result);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 7,
                                            height: 7,
                                            child: SvgPicture.asset(
                                              ImageAssets.icClose,
                                              color:
                                                  result == _xaHoiCubit.tagKey
                                                      ? AppTheme.getInstance()
                                                          .dfBtnTxtColor()
                                                      : linkColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                addTagWidget()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addTagWidget() {
    return StreamBuilder<bool>(
      stream: _xaHoiCubit.showAddTagStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? false;
        return data
            ? Container(
                width: 97,
                decoration: BoxDecoration(
                  color: textDefault.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextField(
                  style: textNormal(linkColor, 12.0.textScale()),
                  onSubmitted: (value) {
                    _xaHoiCubit.addTag(value);
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    filled: true,
                    isDense: false,
                    hintText: S.current.them_tag,
                    hintStyle: textNormal(textBodyTime, 12.0.textScale()),
                    fillColor: Colors.transparent,
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: 12.0.textScale(),
                      maxHeight: 20,
                    ),
                    prefixIcon: Text(
                      '#',
                      style: textNormal(textBodyTime, 12.0.textScale()),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
