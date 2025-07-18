// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hydrated_bloc/hydrated_bloc.dart' as _i67;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/timer/data/datasources/timer_local_data_source.dart'
    as _i172;
import '../../features/timer/data/datasources/timer_local_data_source_impl.dart'
    as _i875;
import '../../features/timer/data/repository/timer_repository_impl.dart'
    as _i729;
import '../../features/timer/domain/repository/timer_repository.dart' as _i303;
import '../../features/timer/domain/usecases/timer_usecases.dart' as _i958;
import '../../features/timer/presentation/bloc/timer_bloc.dart' as _i203;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i67.HydratedStorage>(
      () => registerModule.hydratedStorage,
      preResolve: true,
    );
    gh.lazySingleton<_i172.TimerLocalDataSource>(
      () => _i875.TimerLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i303.TimerRepository>(
      () => _i729.TimerRepositoryImpl(
        localDataSource: gh<_i172.TimerLocalDataSource>(),
      ),
    );
    gh.factory<_i958.GetProjectsUseCase>(
      () => _i958.GetProjectsUseCase(gh<_i303.TimerRepository>()),
    );
    gh.factory<_i958.GetTasksUseCase>(
      () => _i958.GetTasksUseCase(gh<_i303.TimerRepository>()),
    );
    gh.factory<_i203.TimersBloc>(
      () => _i203.TimersBloc(
        getProjects: gh<_i958.GetProjectsUseCase>(),
        getTasks: gh<_i958.GetTasksUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
