import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/bao_chi_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';

import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PressSocialNetWork extends StatefulWidget {
  final WidgetType homeItemType;
  const PressSocialNetWork({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<PressSocialNetWork> createState() => _PressSocialNetWorkState();
}

class _PressSocialNetWorkState extends State<PressSocialNetWork> {
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _xaHoiCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 380,
      title: S.current.press_socialNetWord,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
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
      child: LoadingOnly(
        stream: _xaHoiCubit.stateStream,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tagWidget(cubit),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<List<PressNetWorkModel>>(
                stream: _xaHoiCubit.getPressNetWork,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <PressNetWorkModel>[];
                  if (data.isNotEmpty) {
                    return Column(
                      children: List.generate(data.length, (index) {
                        final result = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
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
                            child: BaoChiWidget(data: result),
                          ),
                        );
                      }),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: NodataWidget(),
                  );
                },
              ),
            )
          ],
        ),
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final result = data[index];
                    return GestureDetector(
                      onTap: () {
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
                                12,
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
                  style: textNormal(linkColor, 12),
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
                    hintStyle: textNormal(textBodyTime, 12),
                    fillColor: Colors.transparent,
                    prefixIconConstraints:
                        const BoxConstraints(maxWidth: 12, maxHeight: 20),
                    prefixIcon: Text(
                      '#',
                      style: textNormal(textBodyTime, 12),
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
