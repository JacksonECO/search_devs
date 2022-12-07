import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:search_devs/module/profile/controller/profile_bloc.dart';
import 'package:search_devs/module/profile/profile_page.dart';
import 'package:search_devs/module/profile/services/github_service.dart';
import 'package:search_devs/module/profile/services/github_service_impl.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => GitHubServiceImpl(client: Client())),
        Bind((i) => ProfileBloc(postService: i<GitHubService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => ProfilePage(
                  username: args.data as String,
                  bloc: Modular.get<ProfileBloc>(),
                )),
      ];
}
