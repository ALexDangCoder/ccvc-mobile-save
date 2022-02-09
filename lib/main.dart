
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/strings.dart';
import 'package:ccvc_mobile/config/routes/router.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/di/module.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

MethodChannel trustWalletChannel = const MethodChannel('flutter/trust_wallet');

Future<void> mainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefsService.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkDeviceType();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.app_name,
          theme: ThemeData(
            primaryColor: AppTheme.getInstance().primaryColor(),
            cardColor: Colors.white,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            dividerColor: dividerColor,
            scaffoldBackgroundColor: Colors.white,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppTheme.getInstance().primaryColor(),
              selectionColor: AppTheme.getInstance().primaryColor(),
              selectionHandleColor: AppTheme.getInstance().primaryColor(),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppTheme.getInstance().accentColor(),
            ),
          ),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            // if (supportedLocales.contains(
            //   Locale(deviceLocale?.languageCode ?? EN_CODE),
            // )) {
            //   return deviceLocale;
            // } else {
            //   return const Locale.fromSubtags(languageCode: EN_CODE);
            // }
            return const Locale.fromSubtags(languageCode: VI_CODE);
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splash,
        ),
      ),
    );
  }
  void checkDeviceType() {
    final shortestSide = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.shortestSide;
    APP_DEVICE = shortestSide < 700 ? DeviceType.MOBILE : DeviceType.TABLET;
  }
}
