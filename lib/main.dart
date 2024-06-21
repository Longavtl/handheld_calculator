import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:handheld_calculator/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Component/Utils/DeviceUtils.dart';
import 'Component/core/routes.dart';
import 'component/Constant/PrefKey.dart';
import 'config/helper/global_var.dart';
import 'config/routes/router_name.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'config/utils/service_locator.dart';
import 'config/utils/shared_preferences.dart';
import 'core/local/cache_helper.dart';
import 'di.dart' as di;
import 'di.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  // get it
  await di.init();
  await CacheHelper.init();

  // get storage
  await GetStorage.init();

  serviceLocatorInit();

  await getIt<SharedPreferencesService>().initialize();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 5));
  runApp( MyApp());
  //FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
   String _language ='vi';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initialization();
    _load();
  }
   Future<void> _load() async {
     try {
       final prefs = await SharedPreferences.getInstance();
       _language = prefs.getString(PrefsKey.LANGUAGES) ?? 'vi';
     } catch (e) {
       print(e.toString());
     }
     setState(() {});
   }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
    _load();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToDetailPage();
    });
  }

  void _navigateToDetailPage() {
    final BuildContext? context = CoreRoutes.navigatorKey.currentContext;
    if (context != null) {
      CoreRoutes.instance.navigateToRouteString(RouteName.SPLASH);
    } else {
      print('Lỗi: currentContext bị null');
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceUtils.init(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          navigatorKey: CoreRoutes.navigatorKey,
          locale: Locale(_language ?? 'en'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: RouteName.SPLASH,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
        ),
      ),
    );
  }
}
