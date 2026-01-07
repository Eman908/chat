// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../theme/theme_provider.dart' as _i416;
import 'modules/shared_preference_module.dart' as _i890;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferenceModule = _$SharedPreferenceModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferenceModule.preference(),
      preResolve: true,
    );
    gh.factory<_i416.ThemeProvider>(() => _i416.ThemeProvider());
    return this;
  }
}

class _$SharedPreferenceModule extends _i890.SharedPreferenceModule {}
