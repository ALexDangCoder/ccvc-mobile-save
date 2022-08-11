import 'package:ccvc_mobile/firebase_config.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/login/ui/mobile/login_screen.dart';
import 'package:ccvc_mobile/presentation/login/ui/tablet/login_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/main_screen.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      AppStateCt.of(context).appState.refreshToken.listen((value) {
        globalKey = GlobalKey();
        if (isMobile()) {
          keyHomeMobile = GlobalKey<HomeScreenMobileState>();
        } else {
          keyHomeTablet = GlobalKey<HomeScreenTabletState>();
        }
        setState(() {});
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SizeConfig.init(context);
    MessageConfig.init(context);
    FirebaseConfig.getInitialMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      initialData: AppStateCt.of(context).appState.token,
      stream: AppStateCt.of(context).appState.getToken,
      builder: (context, snapshot) {
        final data = snapshot.data ?? '';
        return screen(data);
      },
    );
  }

  Widget screen(String token) {
    if (token.isNotEmpty) {
      return MainTabBarView(
        key: globalKey,
      );
    } else {
      return screenDevice(
        mobileScreen: const LoginScreen(),
        tabletScreen: const LoginTabletScreen(),
      );
    }
  }
}
