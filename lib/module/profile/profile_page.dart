import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_devs/core/custom/color_app.dart';
import 'package:search_devs/core/custom/style_app.dart';
import 'package:search_devs/module/profile/controller/profile_bloc.dart';
import 'package:search_devs/module/profile/controller/profile_event.dart';
import 'package:search_devs/module/profile/controller/profile_state.dart';
import 'package:search_devs/module/profile/widgets/repository_widget.dart';
import 'package:search_devs/module/profile/widgets/user_widget.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final ProfileBloc bloc;

  const ProfilePage({
    required this.username,
    required this.bloc,
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(ProfileEventSearch(username: widget.username));
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is ProfileStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProfileStateFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: context.styles.body.copyWith(color: Colors.red),
                ),
              );
            }

            //? state is ProfileStateSuccess
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      UserWidget(user: state.user!),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                state.repositories!.isEmpty
                    ? SliverToBoxAdapter(
                        child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Center(
                            child: Text(
                              'Nenhum repositório encontrado!',
                              style: context.styles.body,
                            ),
                          ),
                        ],
                      ))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          //? state.repositories!.length > 0
                          childCount: state.repositories!.length * 2 - 1,
                          (context, index) {
                            final int itemIndex = index ~/ 2;
                            if (index.isEven) {
                              return RepositoryWidget(
                                repository: state.repositories![itemIndex],
                              );
                            }
                            return Divider(
                              height: 32,
                              color: context.colors.azureishWhite,
                              thickness: 1.5,
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
