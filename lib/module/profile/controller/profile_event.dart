abstract class ProfileEvent {}

class ProfileEventSearch extends ProfileEvent {
  final String username;

  ProfileEventSearch({
    required this.username,
  });
}
