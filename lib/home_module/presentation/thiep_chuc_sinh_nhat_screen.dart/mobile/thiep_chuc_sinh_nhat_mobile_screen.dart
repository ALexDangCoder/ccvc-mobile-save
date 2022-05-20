import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/thiep_chuc_sinh_nhat_screen.dart/widgets/page_view_transition.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
class ThiepChucMungMobileScreen extends StatefulWidget {
  const ThiepChucMungMobileScreen({Key? key}) : super(key: key);

  @override
  _ThiepChucMungScreenState createState() => _ThiepChucMungScreenState();
}

class _ThiepChucMungScreenState extends State<ThiepChucMungMobileScreen> {
  final controller = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.thiep_va_loi_chuc),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200,child: PageViewWidget(pageController: controller,))
          ],
        ),
      ),
    );
  }
}
