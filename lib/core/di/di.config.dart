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

import '../../data/data_source/contract/chat_data_source.dart' as _i1064;
import '../../data/data_source/contract/firebase_data_source.dart' as _i417;
import '../../data/data_source/impl/chat_data_source_impl.dart' as _i980;
import '../../data/data_source/impl/firebase_data_source_impl.dart' as _i997;
import '../../data/firebase/chats_service.dart' as _i668;
import '../../data/firebase/firebase_service.dart' as _i73;
import '../../data/repo/auth_repo_impl.dart' as _i0;
import '../../data/repo/chat_repo_impl.dart' as _i149;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/repo/chat_repo.dart' as _i949;
import '../../presentation/auth/cubit/auth_cubit.dart' as _i1063;
import '../../presentation/chat/chat_cubit/chat_cubit.dart' as _i870;
import '../../presentation/chat/messages_cubit/messages_cubit.dart' as _i505;
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
    gh.factory<_i1063.AuthCubit>(() => _i1063.AuthCubit());
    gh.factory<_i870.ChatCubit>(() => _i870.ChatCubit());
    gh.factory<_i505.MessagesCubit>(() => _i505.MessagesCubit());
    gh.singleton<_i668.ChatsService>(() => _i668.ChatsService());
    gh.singleton<_i73.FirebaseService>(() => _i73.FirebaseService());
    gh.factory<_i949.ChatRepo>(() => _i149.ChatRepoImpl());
    gh.factory<_i417.FirebaseDataSource>(() => _i997.FirebaseDataSourceImpl());
    gh.factory<_i716.AuthRepo>(() => _i0.AuthRepoImpl());
    gh.factory<_i1064.ChatDataSource>(() => _i980.ChatDataSourceImpl());
    return this;
  }
}

class _$SharedPreferenceModule extends _i890.SharedPreferenceModule {}
