import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
class ChiTietThiepChucMobileScreen extends StatefulWidget {
  const ChiTietThiepChucMobileScreen({Key? key}) : super(key: key);

  @override
  _ChiTietThiepChucMobileScreenState createState() => _ChiTietThiepChucMobileScreenState();
}

class _ChiTietThiepChucMobileScreenState extends State<ChiTietThiepChucMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.thiep_danh_toi_ban),
      body: Container(
        clipBehavior: Clip.hardEdge,
        margin:  const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child:  Column(
          children: [
            CustomPaint(
              painter: MyClipper(),
              child: Container(
                height: 400,
              ),
            ),
          ],
        )
      ),
    );
  }
}
class MyClipper extends CustomPainter{



  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
