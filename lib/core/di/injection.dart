import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:odoo/core/di/injection.config.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @preResolve // Mark as pre-resolved because HydratedStorage.build is async
  Future<HydratedStorage> get hydratedStorage async => HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
}

@InjectableInit(
  initializerName: 'init', // Default, but good to be explicit
  preferRelativeImports: true, // Default, but good to be explicit
  asExtension: true, // Use sl.init()
)
Future<void> configureDependencies() async => getIt.init();
