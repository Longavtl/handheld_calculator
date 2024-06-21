
import 'package:get_it/get_it.dart';
import 'package:handheld_calculator/config/utils/shared_preferences.dart';

final getIt = GetIt.instance;
void serviceLocatorInit() async {
  getIt.registerLazySingleton<SharedPreferencesService>(
          () => SharedPreferencesService());
  /*getIt.registerLazySingleton<RouteCubit>(() => RouteCubit());*/
}
