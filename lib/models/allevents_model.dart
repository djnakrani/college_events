class Event {
  String imageUrl;
  String title;
  DateTime startDate;
  DateTime endDate;
  DateTime lastDate;
  String time;
  String place;
  String description;

  Event({
    required this.imageUrl,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.lastDate,
    required this.time,
    required this.place,
    required this.description,
  });
}

final List<Event> events = [
  Event(
    imageUrl: 'images/carromcomp.jpg',
    title: 'Carrom',
    startDate: DateTime.parse("2021-11-23"),
    endDate: DateTime.parse("2021-10-13"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'Our friendly neighborhood Super Hero decides to join his best friends Ned, MJ, and the rest of the gang on a European vacation. However, Peter\'s plan to leave super heroics behind for a few weeks are quickly scrapped when he begrudgingly agrees to help Nick Fury uncover the mystery of several elemental creature attacks, creating havoc across the continent.',
  ),
  Event(
    imageUrl: 'images/chesscomp.jpg',
    title: 'Chess',
    startDate: DateTime.parse("2021-11-23"),
    endDate: DateTime.parse("2021-09-14"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'All Clara wants is a key - a one-of-a-kind key that will unlock a box that holds a priceless gift from her late mother. A golden thread, presented to her at godfather Drosselmeyer\'s annual holiday party, leads her to the coveted key-which promptly disappears into a strange and mysterious parallel world. It\'s there that Clara encounters a soldier named Phillip, a gang of mice and the regents who preside over three Realms: Land of Snowflakes, Land of Flowers, and Land of Sweets. Clara and Phillip must brave the ominous Fourth Realm, home to the tyrant Mother Ginger, to retrieve Clara\'s key and hopefully return harmony to the unstable world.',
  ),
  Event(
    imageUrl: 'images/matkicomp.jpg',
    title: 'Matki',
    startDate: DateTime.parse("2021-12-20"),
    endDate: DateTime.parse("2021-12-20"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'Our friendly neighborhood Super Hero decides to join his best friends Ned, MJ, and the rest of the gang on a European vacation. However, Peter\'s plan to leave super heroics behind for a few weeks are quickly scrapped when he begrudgingly agrees to help Nick Fury uncover the mystery of several elemental creature attacks, creating havoc across the continent.',
  ),
  Event(
    imageUrl: 'images/poetrycomp.jpg',
    title: 'Poetry',
    startDate: DateTime.parse("2021-06-20"),
    endDate: DateTime.parse("2021-06-20"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'All Clara wants is a key - a one-of-a-kind key that will unlock a box that holds a priceless gift from her late mother. A golden thread, presented to her at godfather Drosselmeyer\'s annual holiday party, leads her to the coveted key-which promptly disappears into a strange and mysterious parallel world. It\'s there that Clara encounters a soldier named Phillip, a gang of mice and the regents who preside over three Realms: Land of Snowflakes, Land of Flowers, and Land of Sweets. Clara and Phillip must brave the ominous Fourth Realm, home to the tyrant Mother Ginger, to retrieve Clara\'s key and hopefully return harmony to the unstable world.',
  ),
  Event(
    imageUrl: 'images/tugofwar.jpg',
    title: 'Tug Of War',
    startDate: DateTime.parse("2021-09-16"),
    endDate: DateTime.parse("2021-09-16"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'Our friendly neighborhood Super Hero decides to join his best friends Ned, MJ, and the rest of the gang on a European vacation. However, Peter\'s plan to leave super heroics behind for a few weeks are quickly scrapped when he begrudgingly agrees to help Nick Fury uncover the mystery of several elemental creature attacks, creating havoc across the continent.',
  ),
  Event(
    imageUrl: 'images/storywriting.jpg',
    title: 'Story Writing',
    startDate: DateTime.parse("2021-11-22"),
    endDate: DateTime.parse("2021-11-24"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'All Clara wants is a key - a one-of-a-kind key that will unlock a box that holds a priceless gift from her late mother. A golden thread, presented to her at godfather Drosselmeyer\'s annual holiday party, leads her to the coveted key-which promptly disappears into a strange and mysterious parallel world. It\'s there that Clara encounters a soldier named Phillip, a gang of mice and the regents who preside over three Realms: Land of Snowflakes, Land of Flowers, and Land of Sweets. Clara and Phillip must brave the ominous Fourth Realm, home to the tyrant Mother Ginger, to retrieve Clara\'s key and hopefully return harmony to the unstable world.',
  ),
  Event(
    imageUrl: 'images/quizcomp.jpg',
    title: 'Quiz',
    startDate: DateTime.parse("2021-12-20"),
    endDate: DateTime.parse("2021-12-22"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'Our friendly neighborhood Super Hero decides to join his best friends Ned, MJ, and the rest of the gang on a European vacation. However, Peter\'s plan to leave super heroics behind for a few weeks are quickly scrapped when he begrudgingly agrees to help Nick Fury uncover the mystery of several elemental creature attacks, creating havoc across the continent.',
  ),
  Event(
    imageUrl: 'images/thalidecoration.jpg',
    title: "Thali Decoration",
    startDate: DateTime.parse("2021-11-20"),
    endDate: DateTime.parse("2021-11-20"),
    lastDate: DateTime.parse("2021-10-13"),
    time: "10:30 AM",
    place: "Surat",
    description:
    'All Clara wants is a key - a one-of-a-kind key that will unlock a box that holds a priceless gift from her late mother. A golden thread, presented to her at godfather Drosselmeyer\'s annual holiday party, leads her to the coveted key-which promptly disappears into a strange and mysterious parallel world. It\'s there that Clara encounters a soldier named Phillip, a gang of mice and the regents who preside over three Realms: Land of Snowflakes, Land of Flowers, and Land of Sweets. Clara and Phillip must brave the ominous Fourth Realm, home to the tyrant Mother Ginger, to retrieve Clara\'s key and hopefully return harmony to the unstable world.',
  ),
];