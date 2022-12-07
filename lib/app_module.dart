import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/module/home/home_module.dart';
import 'package:search_devs/module/profile/profile_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/profile', module: ProfileModule()),
      ];
}
