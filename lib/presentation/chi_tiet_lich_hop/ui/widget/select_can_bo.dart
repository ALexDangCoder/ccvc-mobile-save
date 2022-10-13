import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text_filed/follow_keyboard.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/dialog/cupertino_loading.dart';
import 'package:ccvc_mobile/widgets/dialog/modal_progress_hud.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCanBo extends StatefulWidget {
  final Function(DonViModel) onChange;
  final String? title;
  final String? hintText;
  final ThanhPhanThamGiaCubit cubit;
  final ThemCanBoCubit themCanBoCubit;
  final bool needCheckTrung;
  final Function(DonViModel) onChangeCheckbox;

  const SelectCanBo({
    Key? key,
    required this.onChange,
    this.title,
    this.hintText,
    required this.cubit,
    required this.themCanBoCubit,
    required this.needCheckTrung,
    required this.onChangeCheckbox,
  }) : super(key: key);

  @override
  State<SelectCanBo> createState() => _SelectCanBoState();
}

class _SelectCanBoState extends State<SelectCanBo> {
  final controllerSearch = TextEditingController();
  String tenCanBo = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.themCanBoCubit.listCanBoTemp = [...widget.themCanBoCubit.listCanBo];
    widget.themCanBoCubit.getCanbo.sink.add(widget.themCanBoCubit.listCanBo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? S.current.can_bo,
          style: textNormal(titleItemEdit, 14.0.textScale()),
        ),
        SizedBox(
          height: 8.0.textScale(),
        ),
        GestureDetector(
          onTap: () {
            isMobile()
                ? showBottomSheetCustom<List<DonViModel>>(
                    context,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FollowKeyBoardEdt(
                        bottomWidget: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: DoubleButtonBottom(
                            title1: S.current.dong,
                            title2: S.current.them,
                            onClickLeft: () {
                              Navigator.pop(context);
                            },
                            onClickRight: () {
                              widget.themCanBoCubit.titleCanBo.sink
                                  .add(tenCanBo);
                              Navigator.pop(
                                context,
                                widget.onChangeCheckbox(
                                  widget.themCanBoCubit.donViModel,
                                ),
                              );
                            },
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              spaceH16,
                              BaseSearchBar(
                                controller: controllerSearch,
                                hintText: S.current.tim_kiem_can_bo,
                                onChange: (value) {
                                  widget.themCanBoCubit.search(value);
                                },
                              ),
                              spaceH16,
                              BlocBuilder<ThemCanBoCubit, ThemCanBoState>(
                                bloc: widget.themCanBoCubit,
                                builder: (context, state) {
                                  return StreamBuilder<List<DonViModel>>(
                                    stream:
                                        widget.themCanBoCubit.getCanboStream,
                                    builder: (context, snapshot) {
                                      final data =
                                          widget.themCanBoCubit.searchCanBo(
                                        controllerSearch.text,
                                      );
                                      if (data.isNotEmpty) {
                                        return Column(
                                          children: List.generate(
                                            data.length,
                                            (index) {
                                              final result = data[index];
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  top: index == 0 ? 0 : 16,
                                                ),
                                                child: itemCanBo(
                                                  onCheckBox: (value) async {
                                                    widget.themCanBoCubit
                                                        .addDataListByModel(
                                                      result,
                                                      sinkData: false,
                                                    );
                                                    if (!value) {
                                                      widget.themCanBoCubit
                                                          .addDataListByModel(
                                                        result,
                                                        sinkData: false,
                                                      );
                                                    } else {
                                                      widget.themCanBoCubit
                                                          .removeByModel(
                                                        result,
                                                      );
                                                    }
                                                  },
                                                  canBoModel: result,
                                                  themCanBoCubit:
                                                      widget.themCanBoCubit,
                                                  onChange: (value) {
                                                    tenCanBo = value.tenCanBo;
                                                    widget.themCanBoCubit
                                                        .donViModel = value;
                                                  },
                                                  isCheck: data[index].isCheck,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: const NodataWidget(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    title: S.current.danh_sach_can_bo,
                  )
                : showDiaLogTablet(
                    context,
                    title: S.current.danh_sach_can_bo,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: FollowKeyBoardWidget(
                        bottomWidget: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: DoubleButtonBottom(
                            title1: S.current.dong,
                            title2: S.current.them,
                            onClickLeft: () {
                              Navigator.pop(context);
                            },
                            onClickRight: () {
                              widget.themCanBoCubit.titleCanBo.sink
                                  .add(tenCanBo);
                              Navigator.pop(
                                context,
                                widget.onChangeCheckbox(
                                  widget.themCanBoCubit.donViModel,
                                ),
                              );
                            },
                          ),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                spaceH16,
                                BaseSearchBar(
                                  hintText: S.current.tim_kiem_can_bo,
                                  onChange: (value) {
                                    widget.themCanBoCubit.search(value);
                                  },
                                ),
                                spaceH16,
                                BlocBuilder<ThemCanBoCubit, ThemCanBoState>(
                                  bloc: widget.themCanBoCubit,
                                  builder: (context, state) {
                                    return ModalProgressHUD(
                                      inAsyncCall: state is Loading,
                                      color: Colors.transparent,
                                      progressIndicator:
                                          const CupertinoLoading(),
                                      child: StreamBuilder<List<DonViModel>>(
                                        stream: widget.themCanBoCubit.getCanbo,
                                        builder: (context, snapshot) {
                                          final data =
                                              widget.themCanBoCubit.searchCanBo(
                                            controllerSearch.text,
                                          );
                                          if (data.isNotEmpty) {
                                            return ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              keyboardDismissBehavior: isMobile()
                                                  ? ScrollViewKeyboardDismissBehavior
                                                      .onDrag
                                                  : ScrollViewKeyboardDismissBehavior
                                                      .manual,
                                              children: List.generate(
                                                data.length,
                                                (index) {
                                                  final result = data[index];
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                      top: index == 0 ? 0 : 16,
                                                    ),
                                                    child: itemCanBo(
                                                      onCheckBox:
                                                          (value) async {
                                                        widget.themCanBoCubit
                                                            .addDataListByModel(
                                                          result,
                                                          sinkData: false,
                                                        );
                                                        if (!value) {
                                                          widget.themCanBoCubit
                                                              .addDataListByModel(
                                                            result,
                                                            sinkData: false,
                                                          );
                                                        } else {
                                                          widget.themCanBoCubit
                                                              .removeByModel(
                                                            result,
                                                          );
                                                        }
                                                      },
                                                      canBoModel: result,
                                                      themCanBoCubit:
                                                          widget.themCanBoCubit,
                                                      onChange: (value) {
                                                        tenCanBo =
                                                            value.tenCanBo;
                                                        widget.themCanBoCubit
                                                            .donViModel = value;
                                                      },
                                                      isCheck:
                                                          data[index].isCheck,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                          return Column(
                                            children: const [
                                              SizedBox(
                                                height: 30,
                                              ),
                                              NodataWidget(),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<String>(
                  stream: widget.themCanBoCubit.titleCanBo,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? S.current.ten_nguoi_phoi_hop;
                    if (data.isNotEmpty) {
                      return Text(
                        data,
                        style: textNormal(textTitle, 14.0.textScale()),
                      );
                    }
                    return Text(
                      S.current.ten_nguoi_phoi_hop,
                      style: textNormal(
                        titleItemEdit.withOpacity(0.5),
                        14.0.textScale(),
                      ),
                    );
                  },
                ),
                SvgPicture.asset(ImageAssets.icEditInfor)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget itemCanBo({
    required DonViModel canBoModel,
    required Function(bool) onCheckBox,
    required ThemCanBoCubit themCanBoCubit,
    required Function(DonViModel) onChange,
    required bool isCheck,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomCheckBox(
                  key: UniqueKey(),
                  title: '',
                  onChange: (isCheck) {
                    onCheckBox(!isCheck);
                    onChange(canBoModel);
                  },
                  isCheck: isCheck,
                ),
              ),
              spaceW10,
              Expanded(
                flex: 9,
                child: Text(
                  canBoModel.name,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontSize: 14.0.textScale(),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          SizedBox(
            height: 11.0.textScale(space: 11),
          ),
          rowInfo(key: S.current.ten_can_bo, value: canBoModel.tenCanBo),
          SizedBox(
            height: 11.0.textScale(space: 9),
          ),
          rowInfo(key: S.current.chuc_vu, value: canBoModel.chucVu),
        ],
      ),
    );
  }
}

Widget rowInfo({required String key, required String value}) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text(
          key,
          style: textNormal(infoColor, 14.0.textScale()),
        ),
      ),
      Expanded(
        flex: 6,
        child: Text(
          value,
          style: textNormal(color3D5586, 14.0.textScale()),
        ),
      )
    ],
  );
}
