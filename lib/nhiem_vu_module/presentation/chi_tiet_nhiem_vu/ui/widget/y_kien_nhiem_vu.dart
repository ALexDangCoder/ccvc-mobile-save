import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/y_kien_su_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/pick_file.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

enum PickImage {
  PICK_MAIN,
  PICK_Y_KIEN,
}

class YKienNhiemVuWidget extends StatefulWidget {
  final ChiTietNVCubit cubit;

  const YKienNhiemVuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  State<YKienNhiemVuWidget> createState() => _YKienNhiemVuWidgetState();
}

class _YKienNhiemVuWidgetState extends State<YKienNhiemVuWidget> {
  late TextEditingController _nhapYMainController;

  @override
  void initState() {
    super.initState();
    _nhapYMainController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.cubit.getYKienXuLyNhiemVu(widget.cubit.idNhiemVu);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemSend(true),
            StreamBuilder<List<YKienSuLyNhiemVuModel>>(
              stream: widget.cubit.yKienXuLyNhiemVuStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return YKienSuLyNhiemVuWidget(
                        object: data[index],
                      );
                    },
                  );
                } else {
                  return const NodataWidget();
                }
              },
            ),
          ],
        ),
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
        Row(
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
                        },
                        maxLines: 999,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        onTap: () {
                          // if (isMain) {
                          //   for (final ChiTietYKienXuLyModel value in _list){
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
                                              child: const Text('Camera'),
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
                                              child: const Text('Albums'),
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
                                    final status = await Permission.storage.request();
                                    if (!(status.isGranted ||
                                        status.isLimited)) {
                                      await MessageConfig.showDialogSetting();
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
                                                    await pickFile();
                                                addDataListPick(
                                                  mediaMapImage,
                                                  isMain
                                                      ? PickImage.PICK_MAIN
                                                      : PickImage.PICK_Y_KIEN,
                                                );
                                              },
                                              child: const Text('Files'),
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
                                      final Map<String, dynamic> mediaMapImage =
                                      await pickFile();
                                      addDataListPick(
                                        mediaMapImage,
                                        isMain
                                            ? PickImage.PICK_MAIN
                                            : PickImage.PICK_Y_KIEN,
                                      );
                                    }
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
                  await widget.cubit.postYKienXuLy(
                    noiDung: _nhapYMainController.text,
                    nhiemvuId: widget.cubit.idNhiemVu,
                    fileId: widget.cubit.listFileId,
                  );
                  _nhapYMainController.text = '';
                  widget.cubit.listFileId.clear();
                  widget.cubit.listPickFileMain.clear();
                  setState(() {});
                } else {
                  if (widget.cubit.listPickFileMain.isNotEmpty) {
                    await widget.cubit.postYKienXuLy(
                      noiDung: _nhapYMainController.text,
                      nhiemvuId: widget.cubit.idNhiemVu,
                      fileId: widget.cubit.listFileId,
                    );
                    _nhapYMainController.text = '';
                    widget.cubit.listFileId.clear();
                    widget.cubit.listPickFileMain.clear();
                    setState(() {});
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
                        widget.cubit.listFileId.removeAt(
                          widget.cubit.listPickFileMain
                              .indexWhere((element) => element == objPick),
                        );
                        widget.cubit.listPickFileMain.remove(objPick);
                      } else {
                        
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

  void addDataListPick(Map<String, dynamic> mediaMap, PickImage pickImage) {
    final FToast toast = FToast();
    if (mediaMap.getStringValue(NAME_OF_FILE).isNotEmpty) {
      final _path = mediaMap.getStringValue(PATH_OF_FILE);
      final _name = mediaMap.getStringValue(NAME_OF_FILE);
      final _size = mediaMap.intValue(SIZE_OF_FILE);
      final _extensionName = mediaMap.getStringValue(EXTENSION_OF_FILE);
      final fileMy = mediaMap.getFileValue(FILE_RESULT);
      if (widget.cubit.checkFile(_size)) {
        widget.cubit.uploadFile(path: fileMy);
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

        }
      } else {
        toast.init(context);
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da_30,
          ),
          gravity: ToastGravity.BOTTOM,
        );
      }
      setState(() {});
    }
  }
}
