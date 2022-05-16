import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/pick_file.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PickImage {
  PICK_MAIN,
  PICK_Y_KIEN,
}

class TabYKienXuLy extends StatefulWidget {
  const TabYKienXuLy({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;

  @override
  State<TabYKienXuLy> createState() => _TabYKienXuLyState();
}

class _TabYKienXuLyState extends State<TabYKienXuLy> {
  // late TextEditingController _nhapYkienController;
  late TextEditingController _nhapYMainController;

  // final FocusNode _nodeYMain = FocusNode();
  // final FocusNode _nodeYkien = FocusNode();
  int byteToMb = 1048576;
  int size = 0;
  final List<PickImageFileModel> _listMain = [];

  //final Set<PickImageFileModel> _listYkien = {};
  List<File> listFileMain = [];
  final List<ChiTietYKienXuLyModel> _list = [
    ChiTietYKienXuLyModel(
      urlAvatar:
          'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
      name: '1',
      time: '1',
      listYKien: [],
    ),
    ChiTietYKienXuLyModel(
      urlAvatar:
          'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
      name: '2',
      time: '2',
      listYKien: [
        YKienModel(
          time: '123',
          avatar:
              'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
          name: '2',
        ),
      ],
    ),
    ChiTietYKienXuLyModel(
      urlAvatar:
          'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
      name: '3',
      time: '3',
      listYKien: [
        YKienModel(
          time: '123',
          avatar:
              'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
          name: '3',
        ),
        YKienModel(
          time: '123',
          avatar:
              'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
          name: '3',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    widget.cubit
        .getDanhSachYKienXuLyPAKN('0bf3b2c3-76d7-4e05-a587-9165c3624d70');
    //_nhapYkienController = TextEditingController();
    _nhapYMainController = TextEditingController();
  }

  void addDataListPick(Map<String, dynamic> mediaMap, PickImage pickImage) {
    if (mediaMap.getStringValue(NAME_OF_FILE).isNotEmpty) {
      final _path = mediaMap.getStringValue(PATH_OF_FILE);
      final _name = mediaMap.getStringValue(NAME_OF_FILE);
      final _size = mediaMap.intValue(SIZE_OF_FILE);
      final _extensionName = mediaMap.getStringValue(EXTENSION_OF_FILE);
      final fileMy = mediaMap.getFileValue(FILE_RESULT);
      listFileMain.addAll(fileMy);
      if (pickImage == PickImage.PICK_MAIN) {
        _listMain.add(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _itemSend(true),
              spaceH16,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return _itemViewDetail(
                    sizeImage: 32,
                    list: _list[index].listYKien,
                    index: index,
                    avatar: _list[index].urlAvatar ?? '',
                    time: _list[index].time ?? '',
                    name: _list[index].name ?? '',
                    indexMain: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearData(int indexMain) {
    for (final ChiTietYKienXuLyModel value in _list) {
      value.isInput = false;
    }
    _nhapYMainController.text = '';
    //_nhapYkienController.text = '';
    _listMain.clear();
    //_listYkien.clear();
    _list[indexMain].isInput = true;
    //FocusScope.of(context).requestFocus(_nodeYkien);
    setState(() {});
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      avatar,
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
                  Text(
                    name,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.getInstance().titleColor(),
                    ), //infoColor
                  ),
                ],
              ),
              Text(
                time,
                style: textNormalCustom(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: infoColor,
                ),
              ),
            ],
          ),
          spaceH12,
          Text(
            S.current.thong_tin_bo_sung,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceH10,
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
                GestureDetector(
                  onTap: () {
                    //todo
                  },
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      'dat saa.asdfasdf sadfas'
                      'dfasdfasdfasdfsadfasdfasdfdsafasdfasdfsadfasdfads.sadf',
                      style: textNormalCustom(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: textColorMangXaHoi,
                      ), //infoColor
                    ),
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
                  avatar: list?[index].avatar ?? '',
                  time: list?[index].time ?? '',
                  name: list?[index].name ?? '',
                  indexMain: indexMain,
                );
              },
            ),
          if (isBorder)
            if (_list[indexMain].isInput) _itemSend(false),
        ],
      ),
    );
  }

  Widget _itemSend(bool isMain) {
    final Set<PickImageFileModel> list = {};
    if (isMain) {
      list.addAll(_listMain);
    } else {
      // list.addAll(_listYkien);
    }
    return Column(
      children: [
        if (isMain) const SizedBox.shrink() else spaceH16,
        Padding(
          padding: EdgeInsets.all(isMain ? 16.0 : 0),
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
                              _nhapYMainController
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
                                    final Map<String, dynamic> mediaMap =
                                        await pickImage(fromCamera: true);
                                    addDataListPick(
                                      mediaMap,
                                      isMain
                                          ? PickImage.PICK_MAIN
                                          : PickImage.PICK_Y_KIEN,
                                    );
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
                  for (final PickImageFileModel value in _listMain) {
                    size += value.size ?? 0;
                  }
                  if (size / byteToMb > 30) {
                    MessageConfig.show(
                      title: S.current.file_dinh_kem_mb,
                      messState: MessState.error,
                    );
                  } else {
                    final String result = await widget.cubit.postYKienXuLy(
                      nguoiChoYKien: HiveLocal.getDataUser()?.userId ?? '',
                      noiDung: _nhapYMainController.text,
                      kienNghiId: '08545b49-3c83-4e5d-bf62-98f218b6070a',
                      //TODO DATA
                      file: listFileMain,
                    );

                    if (result.isNotEmpty) {
                      MessageConfig.show(
                        title: S.current.tao_thanh_cong,
                      );
                      _nhapYMainController.text = '';
                      listFileMain.clear();
                      _listMain.clear();
                      setState(() {});
                    } else {
                      MessageConfig.show(
                        title: S.current.tao_that_bai,
                        messState: MessState.error,
                      );
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
      ],
    );
  }

  Widget _itemPick(
    PickImageFileModel objPick,
    PickImage pickImage,
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
                    for (int i = 0; i < _listMain.length; i++) {
                      if (objPick == _listMain[i]) {
                        listFileMain.removeAt(i);
                      }
                    }
                    _listMain.remove(objPick);
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
    );
  }
}
