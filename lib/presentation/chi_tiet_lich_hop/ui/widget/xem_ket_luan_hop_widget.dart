import 'dart:io';

import 'package:ccvc_mobile/bao_cao_module/widget/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class CreateOrUpdateKetLuanHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final bool isCreate;
  final bool isOnlyViewContent;
  final List<FileDetailMeetModel> listFile;

  const CreateOrUpdateKetLuanHopWidget({
    Key? key,
    required this.cubit,
    this.isCreate = false,
    this.isOnlyViewContent = false,
    required this.listFile,
  }) : super(key: key);

  @override
  _CreateOrUpdateKetLuanHopWidgetState createState() =>
      _CreateOrUpdateKetLuanHopWidgetState();
}

class _CreateOrUpdateKetLuanHopWidgetState
    extends State<CreateOrUpdateKetLuanHopWidget> {
  final BehaviorSubject<bool> show = BehaviorSubject.seeded(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.ketLuanHopState = KetLuanHopState();
    if ((widget.cubit.xemKetLuanHopModel.reportStatus ?? '').isNotEmpty) {
      widget.cubit.ketLuanHopState.reportStatusId =
          widget.cubit.xemKetLuanHopModel.reportStatusId ?? '';
    }
    widget.cubit.ketLuanHopState.reportTemplateId =
        widget.cubit.xemKetLuanHopModel.reportTemplateId ?? '';
    widget.cubit.ketLuanHopState.filesApi.addAll(widget.listFile);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isCreate) {
      widget.cubit.dataMauBienBan.close();
    }
    widget.cubit.ketLuanHopState.listFileDefault.close();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.cubit.ketLuanHopState;
    return BlocListener(
        bloc: widget.cubit,
        listener: (context, state) {
          if (state is Success) {
            Navigator.pop(context);
            widget.cubit.needRefreshMainMeeting = true;
            widget.cubit.emit(DetailMeetCalenderInitial());
          }
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: FollowKeyBoardWidget(
            bottomWidget: !widget.isOnlyViewContent
                ? Padding(
              padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 5.0.textScale(space: 100),
                  ),
                  child: DoubleButtonBottom(
                    title1: S.current.dong,
                    title2: S.current.xac_nhan,
                    onClickLeft: () {
                      Navigator.pop(context);
                    },
                    onClickRight: () {
                      if (state.reportStatusId.isNotEmpty) {
                        btnThem();
                      } else {
                        state.validateTinhTrang.sink.add(true);
                        }
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ButtonCustomBottom(
                      isColorBlue: false,
                      title: S.current.dong,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
            child: SingleChildScrollView(
              child: !widget.isOnlyViewContent
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// tinh trang

                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 16),
                          child: TitleWithRedStartWidget(
                            title: S.current.tinh_trang,
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: state.validateTinhTrang.stream,
                            builder: (context, snapshot) {
                              return ShowRequied(
                                textShow: S.current.vui_long_chon_tinh_trang,
                                isShow: snapshot.data ?? false,
                                child:
                                    StreamBuilder<List<StatusKetLuanHopModel>>(
                                  stream: widget.cubit.dataTinhTrangKetLuanHop,
                                  builder: (context, snapshot) {
                                    final dataTinhTrang = snapshot.data ?? [];
                                    return CoolDropDown(
                                      useCustomHintColors: true,
                                      initData:
                                          widget.cubit.getValueTinhTrangnWithId(
                                        state.reportStatusId,
                                      ),
                                      placeHoder: S.current.chon_tinh_trang,
                                      listData: dataTinhTrang
                                          .map((e) => e.displayName)
                                          .toList(),
                                  needReInitData: true,
                                  onChange: (value) {
                                    final vlSelect = dataTinhTrang[value];
                                    state.reportStatusId = vlSelect.id ?? '';
                                    state.validateTinhTrang.sink.add(false);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),

                      /// chon mau bien ban
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 20),
                        child: Text(
                          S.current.chon_mau_bien_ban,
                          style: textNormal(titleItemEdit, 14),
                        ),
                      ),
                      StreamBuilder<ChonBienBanCuocHopModel>(
                        stream: widget.cubit.dataMauBienBan,
                        builder: (context, snapshot) {
                            final data = snapshot.data?.items ?? [];
                            return CoolDropDown(
                              useCustomHintColors: true,
                              placeHoder: S.current.chon_mau_bien_ban,
                              initData: widget.cubit.getValueMauBienBanWithId(
                                state.reportTemplateId,
                              ),
                              needReInitData: true,
                              listData: data.map((e) => e.name).toList(),
                              onChange: (value) {
                                widget.cubit.getValueMauBienBan(value);

                                state.reportTemplateId = data[value].id ?? '';
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 20),
                          child: Text(
                            S.current.just_noi_dung,
                            style: textNormal(titleItemEdit, 14),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditKetLuanHopScreen(
                                  htmlText: widget.cubit.noiDung.value,
                                ),
                              ),
                            ).then((value) {
                              if (value != null) {
                                widget.cubit.getTextAfterEdit(value);
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              top: 10,
                              left: 8,
                              right: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: SingleChildScrollView(
                              child: StreamBuilder<String>(
                                stream: widget.cubit.noiDung.stream,
                                builder: (context, snapshot) {
                                  return Html(
                                    style: {
                                      'html': Style(textAlign: TextAlign.center)
                                    },
                                    data: state.valueEdit != snapshot.data
                                        ? (snapshot.data ?? '')
                                        : state.valueEdit,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        /// them tai lieu cuoc hop
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child:  ButtonSelectFileLichLamViec(
                            isShowFile: false,
                            hasMultipleFile: true,
                            maxSize: MaxSizeFile.MAX_SIZE_30MB.toDouble(),
                            title: S.current.tai_lieu_dinh_kem,
                            allowedExtensions: const [
                              FileExtensions.DOC,
                              FileExtensions.DOCX,
                              FileExtensions.JPEG,
                              FileExtensions.JPG,
                              FileExtensions.PDF,
                              FileExtensions.PNG,
                              FileExtensions.PPTX,
                              FileExtensions.XLSX,
                            ],
                            onChange: (List<File> files, bool validate) {
                              if(validate){
                                return;
                              }
                              for (final element in files) {
                                if (state.listFiles
                                    .where((e) => e.path == element.path)
                                    .isEmpty) {
                                  state.listFiles.add(element);
                                }
                              }
                              state.listFileSelect.sink.add(state.listFiles);
                            },
                          ),
                        ),

                        /// list file
                        StreamBuilder<List<FileDetailMeetModel>>(
                            initialData: state.filesApi,
                            stream: state.listFileDefault.stream,
                            builder: (context, _) => ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.filesApi.length,
                                  itemBuilder: (context, index) {
                                    final dataIndex = state.filesApi[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: FileFromAPIWidget(
                                        data: dataIndex.Name ?? '',
                                        onTapDelete: () {
                                          widget.cubit.fileDeleteKetLuanHop
                                      .add(dataIndex.Id ?? '');
                                  state.filesApi.remove(dataIndex);
                                  state.fileDelete.add(dataIndex.Id ?? '');
                                  state.listFileDefault.sink
                                      .add(state.filesApi);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      StreamBuilder<List<File>>(
                        initialData: [],
                        stream: state.listFileSelect.stream,
                        builder: (context, _) => ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.listFiles.length,
                          itemBuilder: (context, index) {
                            final dataIndex = state.listFiles[index];
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: FileFromAPIWidget(
                                  data: dataIndex.path.convertNameFile(),
                                  onTapDelete: () {
                                    state.listFiles.remove(dataIndex);
                                    state.listFileSelect.sink
                                        .add(state.listFiles);
                                  },
                                  lengthFile:
                                      dataIndex.lengthSync().getFileSize(2),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )

                  /// chỉ xem biên bản họp
                  : Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 400,
                              child: SingleChildScrollView(
                                child: StreamBuilder<String>(
                                  stream: widget.cubit.noiDung.stream,
                                  builder: (context, snapshot) {
                                    return Html(
                                      style: {
                                        'html':
                                            Style(textAlign: TextAlign.center)
                                      },
                                      data: state.valueEdit != snapshot.data
                                          ? (snapshot.data ?? '')
                                          : state.valueEdit,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.listFile.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = widget.listFile;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          ImageAssets.icShareFile,
                                          color: AppTheme.getInstance()
                                              .colorField(),
                                        ),
                                        const SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () {
                                            saveFile(
                                              fileName: data[index].Name ?? '',
                                              url: data[index].Path ?? '',
                                            );
                                          },
                                          child: Text(
                                            data[index].Name ?? '',
                                            style: textDetailHDSD(
                                              fontSize: 14.0.textScale(),
                                              color: color5A8DEE,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void showToast(String title) {
    final toast = FToast();
    toast.init(context);
    toast.showToast(
      child: ShowToast(
        text: title,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  void btnThem() {
    if (!widget.cubit.checkLenghtFile()) {
      showToast(S.current.dung_luong_toi_da_30);
      return;
    }
    if (widget.isCreate) {
      showDiaLog(
        context,
        textContent: S.current.ban_co_chac_chan_muon_gui_mai_nay,
        btnLeftTxt: S.current.khong,
        funcBtnRight: () {
          widget.cubit.createKetLuanHop();
          widget.cubit.sendMailKetLuatHop(widget.cubit.idCuocHop);
        },
        funcBtnLeft: () {
          widget.cubit.createKetLuanHop();
        },
        title: S.current.gui_email,
        btnRightTxt: S.current.dong_y,
        icon: SvgPicture.asset(ImageAssets.IcEmail),
      );
    } else {
      widget.cubit.suaKetLuan();
    }
  }
}

class TitleWithRedStartWidget extends StatelessWidget {
  final String title;

  const TitleWithRedStartWidget({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textNormal(titleItemEdit, 14),
        ),
        Text(
          ' *',
          style: textNormalCustom(color: canceledColor),
        ),
      ],
    );
  }
}

class ShowRequiedWithStream extends StatelessWidget {
  final Widget child;
  final BehaviorSubject<bool> isShow;
  final String textShow;

  const ShowRequiedWithStream({
    Key? key,
    required this.child,
    required this.isShow,
    this.textShow = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        StreamBuilder<bool>(
          stream: isShow,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  textShow.isEmpty ? S.current.khong_duoc_de_trong : textShow,
                  style: textDetailHDSD(color: canceledColor, fontSize: 12),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class ShowRequied extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final String textShow;

  const ShowRequied({
    Key? key,
    required this.child,
    this.isShow = false,
    this.textShow = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        if (isShow)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              textShow.isEmpty ? S.current.khong_duoc_de_trong : textShow,
              style: textDetailHDSD(color: canceledColor, fontSize: 12),
            ),
          )
        else
          const SizedBox()
      ],
    );
  }
}
