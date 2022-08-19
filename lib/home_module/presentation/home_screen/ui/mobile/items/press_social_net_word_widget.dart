import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tabbar_newspaper.dart';
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
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/bao_chi_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/widgets/text/views/loading_only.dart';
import '/presentation/webview/web_view_screen.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _xaHoiCubit.getPress();
      });
    });
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
      minHeight: 420,
      title: S.current.press_socialNetWord,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isShowCaNhan: true,
      onTapTitle: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TabbarNewspaper(),
          ),
        );
      },
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
                  _xaHoiCubit.editSelectDate(value);
                  _xaHoiCubit.selectDate(
                    selectKey: value,
                    startDate: _xaHoiCubit.startDate,
                    endDate: endDate,
                  );
                },
                title: S.current.time,
                startDate: _xaHoiCubit.startDate,
                endDate: _xaHoiCubit.endDate,
                initValue: _xaHoiCubit.selectKeyTime,
              )
            ],
          );
        },
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
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
                addTagWidget(),
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
                  style: textNormal(linkColor, 12),
                  onSubmitted: (value) {
                    _xaHoiCubit.addTag(value);
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    filled: true,
                    isDense: false,
                    hintText: S.current.nhap_tag,
                    hintStyle: textItalic(fontSize: 12),
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
