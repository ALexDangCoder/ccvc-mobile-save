import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ThiepBackgroundWidget extends StatefulWidget {
  const ThiepBackgroundWidget({
    this.isTablet = false,
    required this.pathImage,
    Key? key,
  }) : super(key: key);
  final bool isTablet;
  final String pathImage;

  @override
  _ThiepBackgroundWidgetState createState() => _ThiepBackgroundWidgetState();
}

class _ThiepBackgroundWidgetState extends State<ThiepBackgroundWidget> {
  final appConstants = Get.find<AppConstants>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CurvePainter(),
          child: Container(
            height: 500.0.textScale(space: 300),
          ),
        ),
        ClipPath(
          clipper: Myclipper(),
          child: Container(
            height: 500.0.textScale(space: 300),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              border: widget.isTablet
                  ? Border.all(
                      width: 6,
                      color: backgroundColorApp,
                    )
                  : null,
            ),
            child: ClipRRect(

              borderRadius: widget.isTablet ? BorderRadius.circular(4) :  BorderRadius.zero,
              child: Image.network(
                '${appConstants.baseUrlCCVC}/${widget.pathImage}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, size.height - 150.0.textScale(space: 150));
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 0.0.textScale(space: 120),
      size.width,
      size.height - 150.0.textScale(space: 150),
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final Path path = Path();
    path.moveTo(0, size.height - 150.0.textScale(space: 150));
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 0.0.textScale(space: 120),
      size.width,
      size.height - 150.0.textScale(space: 150),
    );
    canvas.drawShadow(path, shadowContainerColor.withOpacity(0.2), 10.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
