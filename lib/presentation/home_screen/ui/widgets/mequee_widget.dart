import 'dart:async';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class MarqueeWidget extends StatelessWidget {
  const MarqueeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ImageAssets.gifKhanCap,
          width: 24,
          height: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: StreamBuilder<List<TinhHuongKhanCapModel>>(
            stream: HomeProvider.of(context).homeCubit.tinhHuongKhanCap,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              if (data.isNotEmpty) {
                return _MarqueeCell(
                  spacing: 16.0.textScale(space: 8).toInt(),
                  child: List.generate(data.length, (index) {
                    final result = data[index];
                    return GestureDetector(
                      onTap: () {
                        if (result.isLink) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => WebViewScreen(
                                title: '',
                                url: result.linkOrContent ?? '',
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 6.0.textScale(),
                            width: 6.0.textScale(),
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? specialPriceColor
                                  : textTitle,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 8.0.textScale(),
                          ),
                          Text(
                            result.title,
                            style: textNormalCustom(
                              color: index % 2 == 0
                                  ? specialPriceColor
                                  : textTitle,
                              fontSize: 14.0.textScale(),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                );
              }
              return Container(
                color: Colors.transparent,
              );
            },
          ),
        )
      ],
    );
  }
}

class _MarqueeCell extends StatefulWidget {
  final List<Widget> child;
  final int spacing;
  const _MarqueeCell({Key? key, required this.child, this.spacing = 0})
      : super(key: key);

  @override
  _MequeeWidgetState createState() => _MequeeWidgetState();
}

class _MequeeWidgetState extends State<_MarqueeCell> {
  double offset = 0;
  double offset1 = 0;
  double widthWidget = 0;
  double sizeScreen = 0;
  GlobalKey key = GlobalKey();
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widthWidget = key.currentContext?.size?.width ?? 0;
      sizeScreen = MediaQuery.of(context).size.width;
      offset = sizeScreen;
      offset1 = offset + widthWidget + widget.spacing;

      timer = getAnimationRun();
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        timer.cancel();
      },
      onLongPressEnd: (_) {
        timer = getAnimationRun();
      },
      child: Container(
        height: 60,
        color: Colors.transparent,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 20,
              left: offset == 0 ? MediaQuery.of(context).size.width : offset,
              child: Row(
                key: key,
                children: List.generate(
                  widget.child.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: widget.spacing + 0.0),
                    child: widget.child[index],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: offset == 0 ? MediaQuery.of(context).size.width : offset1,
              child: Row(
                children: List.generate(
                  widget.child.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: widget.spacing + 0.0),
                    child: widget.child[index],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Timer getAnimationRun() {
    return Timer.periodic(const Duration(milliseconds: 40), (timer) {
      offset = offset - 1;
      offset1 = offset1 - 1;
      if (offset1 < 0 && offset1 > -2) {
        offset = widthWidget + widget.spacing;
      }
      if (offset < 0 && offset > -2) {
        offset1 = widthWidget + widget.spacing;
      }

     if(mounted) setState(() {});
    });
  }
}
