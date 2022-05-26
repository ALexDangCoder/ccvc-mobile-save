import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/ban_tin_btn_sheet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/item_tin_radio.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/item_tin_trong_nuoc.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/drop_down_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum dropDown { tinRadio, tinTrongNuoc, tinQuocTe }

class TinTucThoiSuScreen extends StatefulWidget {
  final BuildContext pContext;
  final TinTucThoiSuBloc tinTucThoiSuBloc;
  const TinTucThoiSuScreen({
    Key? key,
    required this.tinTucThoiSuBloc,
    required this.pContext,
  }) : super(key: key);

  @override
  State<TinTucThoiSuScreen> createState() => _TinTucThoiSuScreenState();
}

class _TinTucThoiSuScreenState extends State<TinTucThoiSuScreen>
    with AutomaticKeepAliveClientMixin {
  dropDown? valueChoose = dropDown.tinRadio;


  @override
  void initState() {
    super.initState();
    widget.tinTucThoiSuBloc.listTinTuc.clear();
    widget.tinTucThoiSuBloc.changeItem(dropDown.tinRadio);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: StreamBuilder<int>(
                        stream: widget.tinTucThoiSuBloc.dropDownStream,
                        builder: (context, snapshot) {
                          return DropdownButton(
                            isExpanded: true,
                            elevation: 0,
                            value: valueChoose,
                            onChanged: (value) {
                              valueChoose = value as dropDown?;
                              widget.tinTucThoiSuBloc.changeItem(valueChoose);
                            },
                            items: <dropDown>[
                              dropDown.tinRadio,
                              dropDown.tinTrongNuoc,
                              dropDown.tinQuocTe
                            ]
                                .map<DropdownMenuItem<dropDown>>(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value.getString(),
                                      style: textNormalCustom(
                                        color: color3D5586,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                StreamBuilder<int>(
                  stream: widget.tinTucThoiSuBloc.dropDownSubject.stream,
                  builder: (context, snapshot) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: widget.pContext,
                            builder: (context) {
                              return BanTinBtnSheet(
                                listTinTuc: valueChoose == dropDown.tinRadio
                                    ? widget.tinTucThoiSuBloc.listTinTuc
                                    : valueChoose == dropDown.tinTrongNuoc
                                        ? widget.tinTucThoiSuBloc.listTinTucTrongNuoc
                                        : widget.tinTucThoiSuBloc.listTinTucQuocTe,
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 45,
                          decoration: BoxDecoration(
                            color:  AppTheme.getInstance().colorField().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageAssets.icPlay.svgToTheme()),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                S.current.nghe_doc_tin,
                                style: textNormalCustom(
                                  color:  AppTheme.getInstance().colorField(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: widget.tinTucThoiSuBloc.dropDownStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                switch (snapshot.data) {
                  case 1:
                    {
                      widget.tinTucThoiSuBloc.listTinTuc.clear();
                      return Expanded(
                        child: ListViewLoadMore(
                          cubit: widget.tinTucThoiSuBloc,
                          isListView: true,
                          callApi: (page) => {
                            callApi(
                              page,
                            )
                          },
                          viewItem: (value, index) => itemTinTucThoiSu(
                            value as TinTucRadioModel,
                            index ?? 0,
                          ),
                        ),
                      );
                    }
                  case 2:
                    {
                      widget.tinTucThoiSuBloc.listTinTucTrongNuoc.clear();
                      return Expanded(
                        child: ListViewLoadMore(
                          cubit:widget.tinTucThoiSuBloc,
                          isListView: true,
                          callApi: (page) => {
                            callApiTrongNuoc(
                              page,
                            )
                          },
                          viewItem: (value, index) => itemTinTucThoiSuTrongNuoc(
                            value as TinTucRadioModel,
                            index ?? 0,
                          ),
                        ),
                      );
                    }
                  case 3:
                    {
                      widget.tinTucThoiSuBloc.listTinTucQuocTe.clear();
                      return Expanded(
                        child: ListViewLoadMore(
                          cubit: widget.tinTucThoiSuBloc,
                          isListView: true,
                          callApi: (page) => {
                            callApiQuocTe(
                              page,
                            )
                          },
                          viewItem: (value, index) => itemTinTucThoiSuQuocTe(
                            value as TinTucRadioModel,
                            index ?? 0,
                          ),
                        ),
                      );
                    }
                  default:
                    {
                      return const SizedBox();
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void callApi(int page) {
    widget.tinTucThoiSuBloc.getListTinTucRadio(page, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget itemTinTucThoiSu(TinTucRadioModel data, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ItemTinRadio(
        '',
        data.title,
        DateTime.parse(
          data.publishedTime.replaceAll('/', '-').replaceAll(' ', 'T'),
        ).formatApiSSAM,
        () {
          showBottomSheet(
            context: widget.pContext,
            builder: (context) {
              return BanTinBtnSheet(
                listTinTuc: widget.tinTucThoiSuBloc.listTinTuc,
                index: index,
              );
            },
          );
        },
      ),
    );
  }

  void callApiTrongNuoc(int page) {
    widget.tinTucThoiSuBloc.getListTinTucRadioTrongNuoc(
        page, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget itemTinTucThoiSuTrongNuoc(TinTucRadioModel data, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ItemTinTrongNuoc(
        title: data.domain ?? '',
        content: data.title,
        url: data.url ?? '',
        date: DateTime.parse(
                data.publishedTime.replaceAll('/', '-').replaceAll(' ', 'T'))
            .formatApiSSAM,
        imgContent: data.urlImage?[0] ?? '',
        imgTitle: '',
        clickItem: () {
          showBottomSheet(
            context: widget.pContext,
            builder: (context) {
              return BanTinBtnSheet(
                listTinTuc: widget.tinTucThoiSuBloc.listTinTucTrongNuoc,
                index: index,
              );
            },
          );
        },
      ),
    );
  }

  void callApiQuocTe(int page) {
    widget.tinTucThoiSuBloc.getListTinTucRadioQuocTe(
        page, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget itemTinTucThoiSuQuocTe(TinTucRadioModel data, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ItemTinTrongNuoc(
        title: data.domain ?? '',
        url: data.url ?? '',
        content: data.title,
        date: DateTime.parse(
                data.publishedTime.replaceAll('/', '-').replaceAll(' ', 'T'))
            .formatApiSSAM,
        imgContent: data.urlImage?[0] ?? '',
        imgTitle: '',
        clickItem: () {
          showBottomSheet(
            context: widget.pContext,
            builder: (context) {
              return BanTinBtnSheet(
                listTinTuc: widget.tinTucThoiSuBloc.listTinTucQuocTe,
                index: index,
              );
            },
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
