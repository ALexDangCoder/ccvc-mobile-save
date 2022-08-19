import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tablet/tabbar_newspaper_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/config/themes/app_theme.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/press_network_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/api_constants.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/extensions/date_time_extension.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';
import '/presentation/webview/web_view_screen.dart';

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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xaHoiCubit.getPress();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _xaHoiCubit.getPress();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.press_socialNetWord,
      maxHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isShowCaNhan: true,
      onTapTitle: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TabbarNewspaperTablet(),
          ),
        );
      },
      spacingTitle: 0,
      selectKeyDialog: _xaHoiCubit,
      dialogSelect: StreamBuilder(
          stream: _xaHoiCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              onLabel: () {
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
              labelWidget: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.icTag,
                      color: AppTheme.getInstance().colorSelect(),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      S.current.chinh_sua_tag,
                      style: textNormalCustom(
                        fontSize: 14,
                        color: AppTheme.getInstance().colorSelect(),
                      ),
                    )
                  ],
                ),
              ),
              type: widget.homeItemType,
              listSelectKey: [
                DialogData(
                    key: [
                      SelectKey.HOM_NAY,
                      SelectKey.TUAN_NAY,
                      SelectKey.THANG_NAY,
                      SelectKey.NAM_NAY,
                    ],
                    onSelect: (value, startDate, endDate) {
                      _xaHoiCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate,
                      );
                    },
                    startDate: _xaHoiCubit.startDate,
                    endDate: _xaHoiCubit.endDate,
                    title: S.current.time,
                    initValue: _xaHoiCubit.selectKeyTime,)
              ],
            );
          },),
      padding: EdgeInsets.zero,
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
            StreamBuilder<List<PressNetWorkModel>>(
              stream: _xaHoiCubit.getPressNetWork,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <PressNetWorkModel>[];
                if (data.isEmpty) {
                  return  Padding(
                    padding:const EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Text(
                        S.current.khong_co_du_lieu_hien_thi,
                        style: textNormal(
                          titleColor,
                          14.0.textScale(),
                        ),
                      ),
                    ),
                  );
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
            )
          ],
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
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
                              ? AppTheme.getInstance().colorSelect()
                              : AppTheme.getInstance()
                                  .colorSelect()
                                  .withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#$result',
                              style: textNormal(
                                result == _xaHoiCubit.tagKey
                                    ? dfBtnTxtColor
                                    : AppTheme.getInstance().colorSelect(),
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
                                                      ? dfBtnTxtColor
                                                      : AppTheme.getInstance()
                                                          .colorSelect(),
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
            ? SizedBox(
                width: 97,
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
                        const EdgeInsets.symmetric(vertical: 6),
                    filled: true,
                    isDense: false,
                    hintText: S.current.them_tag,
                    hintStyle: textNormal(textBodyTime, 12.0.textScale()),
                    fillColor: Colors.transparent,
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
