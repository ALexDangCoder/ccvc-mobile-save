import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/pick_media_file.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class PickImageFileModel {
  String? path;
  String? name;
  String? extension;
  int? size;

  PickImageFileModel({
    this.path,
    this.name,
    this.extension,
    this.size,
  });
}

class WidgetComments extends StatefulWidget {
  final void Function()? onTab;
  final bool focus;

  final void Function(String, List<PickImageFileModel>)? onSend;
  final int maxSizeMB;
  final String? errorMaxSize;

  const WidgetComments({
    Key? key,
    this.onTab,
    this.onSend,
    this.focus = false,
    this.errorMaxSize,
    this.maxSizeMB = 20,
  }) : super(key: key);

  @override
  _WidgetCommentsState createState() => _WidgetCommentsState();
}

class _WidgetCommentsState extends State<WidgetComments> {
  late FocusNode _focusNode;
  late TextEditingController controller;
  final toast = FToast();
  final Set<PickImageFileModel> listFile = {};
  String comment = '';

  @override
  void initState() {
    _focusNode = FocusNode();
    controller = TextEditingController();
    toast.init(context);
    if (widget.focus) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
    super.initState();
  }

  void removeData() {
    setState(() {
      comment = '';
      controller.text = '';
      listFile.clear();
      _focusNode.unfocus();
    });
  }

  PickImageFileModel? addDataListPick(Map<String, dynamic> mediaMap) {
    if (mediaMap.stringValueOrEmpty(NAME_OF_FILE).isNotEmpty) {
      final _path = mediaMap.stringValueOrEmpty(PATH_OF_FILE);
      final _name = mediaMap.stringValueOrEmpty(NAME_OF_FILE);
      final _size = mediaMap.intValue(SIZE_OF_FILE);
      final _extensionName = mediaMap.stringValueOrEmpty(EXTENSION_OF_FILE);
      return PickImageFileModel(
        path: _path,
        name: _name,
        extension: _extensionName,
        size: _size,
      );
    }
  }

  @override
  void dispose() {
    listFile.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 303,
          child: Container(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            decoration: BoxDecoration(
              color: backgroundColorApp,
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
                    focusNode: _focusNode,
                    controller: controller,
                    maxLines: 999,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    onTap: widget.onTab,
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final Map<String, dynamic> mediaMap =
                                  await pickImageFunc(
                                tittle: '',
                                source: ImageSource.camera,
                              );
                              final newImage = addDataListPick(mediaMap);
                              if (newImage != null) {
                                setState(() {
                                  listFile.add(newImage);
                                });
                              }
                            },
                            child: SvgPicture.asset(
                              ImageAssets.ic_take_photo,
                              width: 20,
                              height: 20,
                              color: iconColorDown,
                            ),
                          ),
                          spaceW4,
                          GestureDetector(
                            onTap: () async {
                              final Map<String, dynamic> mediaMap =
                                  await pickMediaFile(
                                type: PickerType.ALL,
                              );
                              final newFile = addDataListPick(mediaMap);
                              if (newFile != null) {
                                setState(() {
                                  listFile.add(newFile);
                                });
                              }
                            },
                            child: SvgPicture.asset(
                              ImageAssets.ic_attach,
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
                    onChanged: (text) {
                      comment = text;
                    },
                  ),
                ),
                if (listFile.isNotEmpty)
                  Wrap(
                    children: listFile
                        .map(
                          (item) => _itemPick(item, () {
                            setState(() {
                              listFile.remove(item);
                            });
                          }),
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
          onTap: () {
            int totalSize = 0;
            for (final PickImageFileModel item in listFile) {
              totalSize += item.size ?? 0;
            }
            if (totalSize / BYTE_TO_MB > widget.maxSizeMB) {
              toast.removeQueuedCustomToasts();
              toast.showToast(
                child: ShowToast(
                  text: widget.errorMaxSize ??  S.current.dung_luong_toi_da_20,
                  withOpacity: 0.4,
                ),
                gravity: ToastGravity.TOP_RIGHT,
              );
            } else {
              if (widget.onSend != null) {
                widget.onSend!(comment, listFile.toList());
                removeData();
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
    );
  }

  Widget _itemPick(
    PickImageFileModel objPick,
    void Function() onDelete,
  ) {
    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  objPick.name.toString(),
                  style: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  objPick.size?.getFileSize(2) ?? '',
                  style: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          spaceW4,
          Expanded(
            child: InkWell(
              onTap: onDelete,
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
    );
  }
}
