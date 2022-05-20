import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
class ThiepChucMungScreen extends StatefulWidget {
  const ThiepChucMungScreen({Key? key}) : super(key: key);

  @override
  _ThiepChucMungScreenState createState() => _ThiepChucMungScreenState();
}

class _ThiepChucMungScreenState extends State<ThiepChucMungScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack('989'),
    );
  }
}
