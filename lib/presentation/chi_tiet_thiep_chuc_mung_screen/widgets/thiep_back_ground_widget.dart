import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ThiepBackgroundWidget extends StatefulWidget {
  const ThiepBackgroundWidget({
    Key? key,
    this.isTablet = false,
  }) : super(key: key);
  final bool isTablet;

  @override
  _ThiepBackgroundWidgetState createState() => _ThiepBackgroundWidgetState();
}

class _ThiepBackgroundWidgetState extends State<ThiepBackgroundWidget> {
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
              border: widget.isTablet ? Border.all(
                width: 4,
                color: Colors.white,
              ) : null ,
              color: Colors.tealAccent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://hinhnen123.com/wp-content/uploads/2021/09/Dot-mat-999-anh-Ngoc-Trinh-bikini-sexy-nong-bong-khong-the-roi-mat-12.jpg',
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
    Path path = Path();

    path.moveTo(0, size.height - 150.0.textScale(space: 150));
    path.quadraticBezierTo(
        size.width / 2,
        size.height + 0.0.textScale(space: 120),
        size.width,
        size.height - 150.0.textScale(space: 150));
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

    Path path = Path();
    path.moveTo(0, size.height - 150.0.textScale(space: 150));
    path.quadraticBezierTo(
        size.width / 2,
        size.height + 0.0.textScale(space: 120),
        size.width,
        size.height - 150.0.textScale(space: 150));
    canvas.drawShadow(path, shadowContainerColor.withOpacity(0.2), 10.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
