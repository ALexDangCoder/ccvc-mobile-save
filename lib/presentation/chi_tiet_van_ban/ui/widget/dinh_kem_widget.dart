import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttackButtonWidget extends StatefulWidget {
  AttackButtonWidget(
      {Key? key,
      required this.onAddPresss,
      required this.onRemovePress,
      this.onSignNumberPress})
      : super(key: key);
  List<PlatformFile> listFile = [];

  // onAddPresss: parameter: (Tong file da upload , danh sach file vua them)
  void Function(List<PlatformFile>, List<PlatformFile>) onAddPresss;
  VoidCallback? onSignNumberPress;
  ValueSetter<int> onRemovePress;
  ValueNotifier<List<PlatformFile>> listFileNotifier = ValueNotifier([]);

  @override
  _AttackButtonWidgetState createState() => _AttackButtonWidgetState();
}

class _AttackButtonWidgetState extends State<AttackButtonWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff88A5B6),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              height: 35,
              width: 100,
              child: TextButton(
                onPressed: () async {
                  // if (await Permission.storage.isDenied) {
                  //   DialogUtils.showDialogSetting(context);
                  //   return;
                  // }
                  final FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                  );
                  final List<PlatformFile> listFileToSv = [];
                  // if (result != null) {
                  //   for (var file in result.files) {
                  //     final value = widget.listFile.indexWhere((element) {
                  //       return element.path == file.path;
                  //     });
                  //     if (value == -1 || widget.listFile.isEmpty) {
                  //       widget.listFile.add(file);
                  //       listFileToSv.add(file);
                  //       widget.listFileNotifier.value =
                  //           List.from(widget.listFile);
                  //     } else {
                  //       CoolAlert.show(
                  //           context: context,
                  //           type: CoolAlertType.warning,
                  //           text: 'File đã tồn tại');
                  //     }
                  //   }
                  // }
                  if (listFileToSv.isNotEmpty) {
                    widget.onAddPresss([...widget.listFile], listFileToSv);
                  }
                },
                child: Text(
                  'Đính kèm',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontSize: 14.0.textScale(space: 2.0)),
                ),
              ),
            ),
            Visibility(
              visible: widget.onSignNumberPress != null,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffDB353A),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                height: 35,
                width: 100,
                child: TextButton.icon(
                  onPressed: () {
                    widget.onSignNumberPress;
                  },
                  icon: SvgPicture.asset(
                    'assets/images/ic_sign_number.svg',
                  ),
                  label: Text(
                    'Ký số',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        ValueListenableBuilder<List<PlatformFile>>(
          valueListenable: widget.listFileNotifier,
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final int indexDuoi = value[index].name.lastIndexOf('.');
                return SizedBox(
                  height: 38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 160,
                              ),
                              child: Text(
                                value[index].name.substring(0, indexDuoi),
                                style: Theme.of(context).textTheme.headline1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              value[index].name.substring(indexDuoi),
                              style: Theme.of(context).textTheme.headline1,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            child: GestureDetector(
                              onTap: () {
                                widget.listFile.removeAt(index);
                                widget.listFileNotifier.value =
                                    List.from(widget.listFile);
                                widget.onRemovePress(index);
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                            // icon: Icon(Icons.delete),
                            // color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
