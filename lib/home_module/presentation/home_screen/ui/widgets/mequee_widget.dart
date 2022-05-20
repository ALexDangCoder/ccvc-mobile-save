import 'dart:async';

import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/tinh_huong_khan_cap_model.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/presentation/webview/web_view_screen.dart';

class MarqueeWidget extends StatelessWidget {
  const MarqueeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TinBuonModel>>(
      stream: HomeProvider.of(context).homeCubit.tinhHuongKhanCap,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        if (data.isNotEmpty) {
          return SizedBox(
            height: 30,
            child: MarqueeContinuous(


              child: Row(
                children: List.generate(data.length, (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
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
              ),
            ),
          );
        }
        return Container(
          color: Colors.transparent,
        );
      },
    );
  }
}

class MarqueeContinuous extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double stepOffset;

 const MarqueeContinuous(
      {Key? key,
       required this.child,
        this.duration = const Duration(seconds: 3),
        this.stepOffset = 50.0})
      : super(key: key);

  @override
  _MarqueeContinuousState createState() => _MarqueeContinuousState();
}

class _MarqueeContinuousState extends State<MarqueeContinuous> {
  late ScrollController _controller;
  late Timer _timer;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration, (timer) {
      double newOffset = _controller.offset + widget.stepOffset;

      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration, curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return widget.child;
        });
  }
}