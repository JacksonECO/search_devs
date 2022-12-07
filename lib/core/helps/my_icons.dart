enum MyIcons {
  email('email'),
  heart('heart'),
  link('link'),
  office('office'),
  personGroup('person_group'),
  pin('pin'),
  search('search'),
  star('star'),
  twitter('twitter');

  final String name;
  const MyIcons(this.name);

  String get path => 'assets/icons/$name.svg';
}
