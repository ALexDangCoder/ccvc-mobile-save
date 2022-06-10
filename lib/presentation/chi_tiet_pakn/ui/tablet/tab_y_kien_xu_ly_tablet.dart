import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/pick_file.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

enum PickImage {
  PICK_MAIN,
  PICK_Y_KIEN,
}

class TabYKienXuLyTablet extends StatefulWidget {
  const TabYKienXuLyTablet({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;

  @override
  State<TabYKienXuLyTablet> createState() => _TabYKienXuLyTabletState();
}

class _TabYKienXuLyTabletState extends State<TabYKienXuLyTablet> {
  // late TextEditingController _nhapYkienController;
  late TextEditingController _nhapYMainController;

  // final FocusNode _nodeYMain = FocusNode();
  // final FocusNode _nodeYkien = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.cubit.idYkien = widget.id;
    widget.cubit.refreshPosts();
    //_nhapYkienController = TextEditingController();
    _nhapYMainController = TextEditingController();
  }

  void addDataListPick(Map<String, dynamic> mediaMap, PickImage pickImage) {
    if (mediaMap.getStringValue(NAME_OF_FILE).isNotEmpty) {
      final _extensionName = mediaMap.getStringValue(EXTENSION_OF_FILE);
      if (_extensionName == 'VIDEO' ||
          _extensionName == 'MP3' ||
          _extensionName == 'MP4' ||
          _extensionName == 'APK' ||
          _extensionName == 'IPA' ||
          _extensionName == 'DEB' ||
          _extensionName == 'GIF') {
        MessageConfig.show(
          title: S.current.file_khong_hop_le,
          messState: MessState.error,
        );
      } else {
        final _path = mediaMap.getStringValue(PATH_OF_FILE);
        final _name = mediaMap.getStringValue(NAME_OF_FILE);
        final _size = mediaMap.intValue(SIZE_OF_FILE);
        final fileMy = mediaMap.getFileValue(FILE_RESULT);
        widget.cubit.listFileMain.addAll(fileMy);
        if (pickImage == PickImage.PICK_MAIN) {
          widget.cubit.listPickFileMain.add(
            PickImageFileModel(
              path: _path,
              name: _name,
              extension: _extensionName,
              size: _size,
            ),
          );
        } else {
          // _listYkien.add(
          //   PickImageFileModel(
          //     path: _path,
          //     name: _name,
          //     extension: _extensionName,
          //     size: _size,
          //   ),
          // );
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;
    return BlocConsumer<ChiTietPaknCubit, ChiTietPaknState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is ChiTietPaknSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.loadMoreRefresh) {}
            cubit.showContent();
          } else {
            cubit.mess = state.message ?? '';
            cubit.showError();
          }
          cubit.loadMoreLoading = false;
          if (cubit.isRefresh) {
            cubit.listYKienXuLy.clear();
          }
          cubit.listYKienXuLy.addAll(state.list ?? []);
          cubit.canLoadMoreMy =
              cubit.listYKienXuLy.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {
              widget.cubit.refreshPosts();
            },
            error: AppException('', S.current.something_went_wrong),
            stream: widget.cubit.stateStream,
            child: Column(
              children: [
                _itemSend(true),
                spaceH8,
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (cubit.canLoadMore &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        cubit.loadMorePosts();
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.isLoading = false;
                        await widget.cubit.refreshPosts();
                      },
                      child: state is ChiTietPaknSuccess
                          ? cubit.listYKienXuLy.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit.listYKienXuLy.length,
                                  itemBuilder: (context, index) {
                                    return _itemViewDetail(
                                      sizeImage: 32,
                                      list: [],
                                      //todo list
                                      index: index,
                                      avatar: cubit.listYKienXuLy[index]
                                              .anhDaiDienNguoiCho ??
                                          '',
                                      time: cubit.listYKienXuLy[index].ngayTao,
                                      name: cubit.listYKienXuLy[index]
                                              .tenNguoiChoYKien ??
                                          '',
                                      indexMain: index,
                                      file: cubit.listYKienXuLy[index].dSFile ??
                                          [],
                                      isViewData: cubit.listYKienXuLy[index]
                                              .dSFile?.isNotEmpty ??
                                          false,
                                      noiDung:
                                          cubit.listYKienXuLy[index].noiDung ??
                                              '',
                                    );
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: NodataWidget(),
                                )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearData(int indexMain) {
    // for (final YKienXuLyYKNDModel value in widget.cubit.listYKienXuLy) {
    //   value.isInput = false;
    // }
    // _nhapYMainController.text = '';
    // //_nhapYkienController.text = '';
    // _listMain.clear();
    // //_listYkien.clear();
    // _list[indexMain].isInput = true;
    // //FocusScope.of(context).requestFocus(_nodeYkien);//todo
    //setState(() {});
  }

  Widget _itemViewDetail({
    required double sizeImage,
    List<YKienModel>? list,
    bool isBorder = true,
    bool isViewData = false,
    required int index,
    required int indexMain,
    required String name,
    required String avatar,
    required String noiDung,
    required List<FileModel> file,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: isBorder ? 16 : 0,
        right: isBorder ? 16 : 0,
        bottom: isBorder ? 16 : 0,
      ),
      padding: EdgeInsets.only(
        top: isBorder
            ? 16
            : index == 0
                ? 16
                : 8,
        left: 16,
        right: isBorder ? 16 : 0,
        bottom: isBorder ? 16 : 8,
      ),
      decoration: BoxDecoration(
        color: colorNumberCellQLVB,
        border: Border.all(
          color: isBorder ? borderColor : colorNumberCellQLVB,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  avatar.isNotEmpty ? avatar : AVATAR_DEFAULT,
                  width: sizeImage,
                  height: sizeImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: sizeImage,
                      height: sizeImage,
                      color: grayChart,
                    );
                  },
                ),
              ),
              spaceW13,
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.getInstance().titleColor(),
                    ), //infoColor
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    time,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          spaceH12,
          Text(
            noiDung,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          if (isViewData) spaceH10,
          if (isViewData)
            Text(
              S.current.van_ban_dinh_kem,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppTheme.getInstance().titleColor(),
              ), //infoColor
            ),
          spaceH6,
          Row(
            children: [
              if (isViewData)
                SizedBox(
                  width: 90,
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: List.generate(file.length, (index) {
                      final dataSnb = file[index];
                      return GestureDetector(
                        onTap: () async {
                          final status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                            await Permission.manageExternalStorage.request();
                          }
                          await saveFile(
                            dataSnb.ten.toString(),
                            dataSnb.duongDan.toString(),
                            http: true,
                          )
                              .then(
                                (value) => MessageConfig.show(
                                    title: S.current.tai_file_thanh_cong),
                              )
                              .onError(
                                (error, stackTrace) => MessageConfig.show(
                                  title: S.current.tai_file_that_bai,
                                  messState: MessState.error,
                                ),
                              );
                        },
                        child: Text(
                          dataSnb.ten ?? '',
                          style: textNormalCustom(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: textColorMangXaHoi,
                          ), //infoColor
                        ),
                      );
                    }),
                  ),
                ),
              // if (isViewData) spaceW16,
              // GestureDetector(
              //   onTap: () {
              //     clearData(indexMain);
              //   },
              //   child: Text(
              //     S.current.phan_hoi,
              //     style: textNormalCustom(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 12,
              //       color: textColorMangXaHoi,
              //     ), //infoColor
              //   ),
              // ),
            ],
          ),
          if (list?.isNotEmpty ?? false)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _itemViewDetail(
                  sizeImage: 28,
                  isBorder: false,
                  index: index,
                  avatar: '',
                  //todo
                  time: list?[index].time ?? '',
                  name: list?[index].name ?? '',
                  indexMain: indexMain,
                  file: [],
                  noiDung: '',
                );
              },
            ),
          // if (isBorder)
          //   if (_list[indexMain].isInput) _itemSend(false),//todo
        ],
      ),
    );
  }

  Widget _itemSend(bool isMain) {
    final Set<PickImageFileModel> list = {};
    if (isMain) {
      list.addAll(widget.cubit.listPickFileMain);
    } else {
      // list.addAll(_listYkien);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMain) const SizedBox.shrink() else spaceH16,
        Padding(
          padding: EdgeInsets.only(
            left: isMain ? 16.0 : 0,
            right: isMain ? 16.0 : 0,
            top: isMain ? 16.0 : 0,
            bottom: isMain ? 4.0 : 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 303,
                child: Container(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: TextFormField(
                          controller:
                              //isMain
                              //?
                              _nhapYMainController,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              widget.cubit.validateNhapYkien.add('');
                            } else {
                              if (widget.cubit.listPickFileMain.isNotEmpty) {
                                widget.cubit.validateNhapYkien.add('');
                              }
                            }
                          }
                          // : _nhapYkienController
                          ,
                          //focusNode:
                          //isMain ?
                          //_nodeYMain
                          //: _nodeYkien
                          //,
                          maxLines: 999,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          onTap: () {
                            // if (isMain) {
                            //   for (final ChiTietYKienXuLyModel value in _list) {
                            //     value.isInput = false;

                            //   }
                            //_nhapYkienController.text = '';
                            //_listYkien.clear();
                            // setState(() {});
                            //  }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (Platform.isIOS) {
                                      unawaited(
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => CupertinoActionSheet(
                                            actions: [
                                              CupertinoActionSheetAction(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final Map<String, dynamic>
                                                      mediaMapImage =
                                                      await pickImage(
                                                    fromCamera: true,
                                                  );
                                                  addDataListPick(
                                                    mediaMapImage,
                                                    isMain
                                                        ? PickImage.PICK_MAIN
                                                        : PickImage.PICK_Y_KIEN,
                                                  );
                                                },
                                                child: Text(S.current.may_anh),
                                              ),
                                              CupertinoActionSheetAction(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final Map<String, dynamic>
                                                      mediaMapImage =
                                                      await pickImage();
                                                  addDataListPick(
                                                    mediaMapImage,
                                                    isMain
                                                        ? PickImage.PICK_MAIN
                                                        : PickImage.PICK_Y_KIEN,
                                                  );
                                                },
                                                child: Text(S.current.thu_vien),
                                              ),
                                            ],
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(S.current.cancel),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final Map<String, dynamic> mediaMapImage =
                                          await pickImage(fromCamera: true);
                                      addDataListPick(
                                        mediaMapImage,
                                        isMain
                                            ? PickImage.PICK_MAIN
                                            : PickImage.PICK_Y_KIEN,
                                      );
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    ImageAssets.ic_cam,
                                    width: 20,
                                    height: 20,
                                    color: iconColorDown,
                                  ),
                                ),
                                spaceW4,
                                GestureDetector(
                                  onTap: () async {
                                    final Map<String, dynamic> mediaMap =
                                        await pickFile();
                                    addDataListPick(
                                      mediaMap,
                                      isMain
                                          ? PickImage.PICK_MAIN
                                          : PickImage.PICK_Y_KIEN,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    ImageAssets.ic_file,
                                    width: 20,
                                    height: 20,
                                    color: iconColorDown,
                                  ),
                                ),
                              ],
                            ),
                            hintText: S.current.nhap_y_kien_cua_ban,
                            hintStyle: textNormalCustom(color: iconColorDown),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (list.isNotEmpty)
                        Wrap(
                          children: list
                              .map(
                                (i) => _itemPick(
                                  i,
                                  isMain
                                      ? PickImage.PICK_MAIN
                                      : PickImage.PICK_Y_KIEN,
                                ),
                              )
                              .toList(),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              spaceW16,
              GestureDetector(
                onTap: () async {
                  final FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (_nhapYMainController.text.trim().isNotEmpty) {
                    for (final PickImageFileModel value
                        in widget.cubit.listPickFileMain) {
                      widget.cubit.size += value.size ?? 0;
                    }
                    if (widget.cubit.size / widget.cubit.byteToMb > 30) {
                      MessageConfig.show(
                        title: S.current.file_dinh_kem_mb,
                        messState: MessState.error,
                      );
                    } else {
                      final String result = await widget.cubit.postYKienXuLy(
                        //  nguoiChoYKien: HiveLocal.getDataUser()?.userId ?? '',
                        noiDung: _nhapYMainController.text,
                        kienNghiId: widget.cubit.idYkien,
                        file: widget.cubit.listFileMain,
                      );

                      if (result.isNotEmpty) {
                        // MessageConfig.show(
                        //   title: S.current.tao_y_kien_xu_ly_thanh_cong,
                        // );
                        _nhapYMainController.text = '';
                        widget.cubit.listFileMain.clear();
                        widget.cubit.listPickFileMain.clear();
                        setState(() {});
                      } else {
                        // MessageConfig.show(
                        //   title: S.current.tao_y_kien_xu_ly_that_bai,
                        //   messState: MessState.error,
                        // );
                      }
                    }
                  } else {
                    if (widget.cubit.listPickFileMain.isNotEmpty) {
                      for (final PickImageFileModel value
                          in widget.cubit.listPickFileMain) {
                        widget.cubit.size += value.size ?? 0;
                      }
                      if (widget.cubit.size / widget.cubit.byteToMb > 30) {
                        MessageConfig.show(
                          title: S.current.file_dinh_kem_mb,
                          messState: MessState.error,
                        );
                      } else {
                        final String result = await widget.cubit.postYKienXuLy(
                          //nguoiChoYKien: HiveLocal.getDataUser()?.userId ?? '',
                          noiDung: _nhapYMainController.text,
                          kienNghiId: widget.cubit.idYkien,
                          file: widget.cubit.listFileMain,
                        );
                        if (result.isNotEmpty) {
                          // MessageConfig.show(
                          //   title: S.current.tao_y_kien_xu_ly_thanh_cong,
                          // );
                          _nhapYMainController.text = '';
                          widget.cubit.listFileMain.clear();
                          widget.cubit.listPickFileMain.clear();
                          setState(() {});
                        } else {
                          // MessageConfig.show(
                          //   title: S.current.tao_y_kien_xu_ly_that_bai,
                          //   messState: MessState.error,
                          // );
                        }
                      }
                    } else {
                      widget.cubit.validateNhapYkien
                          .add(S.current.ban_chua_nhap_y_kien);
                    }
                  }
                },
                child: SvgPicture.asset(
                  ImageAssets.ic_send,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<String>(
          stream: widget.cubit.validateNhapYkien,
          builder: (context, snapshot) {
            return snapshot.data?.isNotEmpty ?? false
                ? Padding(
                    padding: EdgeInsets.only(
                      left: isMain ? 16.0 : 0,
                      bottom: isMain ? 12.0 : 0,
                    ),
                    child: Text(
                      snapshot.data.toString(),
                      style: textNormalCustom(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 12,
                  );
          },
        ),
      ],
    );
  }

  Widget _itemPick(
    PickImageFileModel objPick,
    PickImage pickImage,
  ) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 8,
            bottom: 6,
          ),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: grayChart,
            border: Border.all(
              color: blueberryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 9,
                child: Text(
                  objPick.name.toString(),
                  style: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              spaceW4,
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (pickImage == PickImage.PICK_MAIN) {
                        for (int i = 0;
                            i < widget.cubit.listPickFileMain.length;
                            i++) {
                          if (objPick == widget.cubit.listPickFileMain[i]) {
                            widget.cubit.listFileMain.removeAt(i);
                          }
                        }
                        widget.cubit.listPickFileMain.remove(objPick);
                      } else {
                        //_listYkien.remove(objPick);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImageAssets.icClose,
                      width: 12,
                      height: 12,
                      color: fontColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
