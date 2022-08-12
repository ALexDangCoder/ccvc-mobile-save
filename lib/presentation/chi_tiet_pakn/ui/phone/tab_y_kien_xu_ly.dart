import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/pick_file.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class TabYKienXuLy extends StatefulWidget {
  const TabYKienXuLy({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;

  @override
  State<TabYKienXuLy> createState() => _TabYKienXuLyState();
}

class _TabYKienXuLyState extends State<TabYKienXuLy>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _nhapYMainController;
  late ScrollController controller;

  Future<void> _getApi() => widget.cubit.getDanhSachYKienXuLyPAKN();

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    widget.cubit.idYkienParam = widget.id;
    _nhapYMainController = TextEditingController();
  }

  void addDataListPick(Map<String, dynamic> mediaMap) {
    if (mediaMap.getStringValue(NAME_OF_FILE).isNotEmpty) {
      final _extensionName = mediaMap.getStringValue(EXTENSION_OF_FILE);
      if (_extensionName == MEDIA_VIDEO ||
          _extensionName == MP3 ||
          _extensionName == MP4 ||
          _extensionName == APK ||
          _extensionName == IPA ||
          _extensionName == DEB ||
          _extensionName == GIF) {
        MessageConfig.show(
          title: S.current.file_khong_hop_le,
          messState: MessState.error,
        );
      } else {
        final _path = mediaMap.getStringValue(PATH_OF_FILE);
        final _name = mediaMap.getStringValue(NAME_OF_FILE);
        final _size = mediaMap.intValue(SIZE_OF_FILE);
        final fileMy = mediaMap.getFileValue(FILE_RESULT);
        if(widget.cubit.sizeFileList.length + fileMy.length > 15){
          MessageConfig.show(
            title: S.current.limit_file_y_kien_pakn,
            messState: MessState.error,
          );
          return;
        }
        widget.cubit.listFileMain.addAll(fileMy);
        widget.cubit.listPickFileMain.add(
          PickImageFileModel(
            path: _path,
            name: _name,
            extension: _extensionName,
            size: _size,
          ),
        );
        widget.cubit.sizeFileList.add(_size);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = widget.cubit;
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          _getApi();
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: ComplexLoadMore(
          scrollController: controller,
          isLoadMore: false,
          physics: const AlwaysScrollableScrollPhysics(),
          titleNoData: S.current.khong_co_du_lieu,
          isTitle: false,
          viewItem: (value, index) => _itemViewDetail(
            sizeImage: 32,
            avatar: value.anhDaiDienNguoiCho ?? '',
            time: value.ngayTao,
            name: value.tenNguoiChoYKien ?? '',
            file: value.dSFile ?? [],
            isViewData: value.dSFile?.isNotEmpty ?? false,
            noiDung: value.noiDung ?? '',
            isMarginBottom: index == widget.cubit.loadMoreList.length - 1,
          ),
          cubit: cubit,
          callApi: (int page) => _getApi(),
          isListView: true,
          childrenView: [
            _itemSend(),
          ],
        ),
      ),
    );
  }

  Widget _itemViewDetail({
    required double sizeImage,
    bool isViewData = false,
    required String name,
    required String avatar,
    required String noiDung,
    required List<FileModel> file,
    required String time,
    required bool isMarginBottom,
  }) {
    return Container(
      margin: EdgeInsets.only(
        right: 16,
        left: 16,
        top: 8,
        bottom: isMarginBottom ? 16 : 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorNumberCellQLVB,
        border: Border.all(
          color: borderColor,
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
                          await saveFile(
                            fileName: dataSnb.ten.toString(),
                            url: dataSnb.duongDan.toString(),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemSend() {
    final Set<PickImageFileModel> list = {};
    list.addAll(widget.cubit.listPickFileMain);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 16.0,
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
                          controller: _nhapYMainController,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              widget.cubit.validateNhapYkien.add('');
                            } else {
                              if (widget.cubit.listPickFileMain.isNotEmpty) {
                                widget.cubit.validateNhapYkien.add('');
                              }
                            }
                          },
                          maxLines: 999,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
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
                                                      await pickImageIos(
                                                    fromCamera: true,
                                                  );
                                                  addDataListPick(
                                                    mediaMapImage,
                                                  );
                                                },
                                                child: Text(
                                                  S.current.may_anh,
                                                ),
                                              ),
                                              CupertinoActionSheetAction(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final Map<String, dynamic>
                                                      mediaMapImage =
                                                      await pickImageIos();
                                                  addDataListPick(
                                                    mediaMapImage,
                                                  );
                                                },
                                                child: Text(
                                                  S.current.thu_vien,
                                                ),
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
                                      const permission = Permission.storage;
                                      final status = await permission.status;
                                      if (!(status.isGranted ||
                                          status.isLimited)) {
                                        await MessageConfig.showDialogSetting();
                                      } else {
                                        final Map<String, dynamic>
                                            mediaMapImage =
                                            await pickImageAndroid();
                                        addDataListPick(
                                          mediaMapImage,
                                        );
                                      }
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
                                    const permission = Permission.storage;
                                    final status = await permission.status;
                                    if (!(status.isGranted ||
                                        status.isLimited)) {
                                      await MessageConfig.showDialogSetting();
                                    } else {
                                      final Map<String, dynamic> mediaMap =
                                          await pickFile();
                                      addDataListPick(
                                        mediaMap,
                                      );
                                    }
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
                    if (widget.cubit.checkMaxSize()) {
                      MessageConfig.show(
                        title: S.current.file_dinh_kem_mb,
                        messState: MessState.error,
                      );
                    } else {
                      await postYKienXuLy();
                    }
                  } else {
                    if (widget.cubit.listPickFileMain.isNotEmpty) {
                      if (widget.cubit.checkMaxSize()) {
                        MessageConfig.show(
                          title: S.current.file_dinh_kem_mb,
                          messState: MessState.error,
                        );
                      } else {
                        await postYKienXuLy();
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
                  color: AppTheme.getInstance().colorField(),
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
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      snapshot.data.toString(),
                      style: textNormalCustom(
                        color: statusCalenderRed,
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

  Future<void> postYKienXuLy() async {
    final bool result = await widget.cubit.postYKienXuLy(
      noiDung: _nhapYMainController.text,
      kienNghiId: widget.cubit.idYkienParam,
      file: widget.cubit.listFileMain,
    );
    if (result) {
      await widget.cubit.getDanhSachYKienXuLyPAKN();
      _nhapYMainController.text = '';
      widget.cubit.listFileMain.clear();
      widget.cubit.listPickFileMain.clear();
      widget.cubit.sizeFileList.clear();
      setState(() {});
      if (controller.hasClients) {
        Future.delayed(const Duration(milliseconds: 50), () {
          controller.jumpTo(controller.position.maxScrollExtent);
        });
      }
    } else {
      MessageConfig.show(
        title: S.current.that_bai,
        messState: MessState.error,
      );
    }
  }

  Widget _itemPick(
    PickImageFileModel objPick,
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
                      widget.cubit.deleteFile(objPick);
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

  @override
  bool get wantKeepAlive => true;
}
