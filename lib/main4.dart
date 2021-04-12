import 'package:flutter/material.dart';

void main() {
  runApp(FilmsApp());
}

class Film {
  String title;
  String author;
  String description;

  Film(this.title, this.author, this.description);
}

class FilmsApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilmsAppState();
}

class _FilmsAppState extends State<FilmsApp> {
  FilmRouterDelegate _routerDelegate = FilmRouterDelegate();
  FilmRouteInformationParser _routeInformationParser = FilmRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Фильмы',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class FilmRouteInformationParser extends RouteInformationParser<FilmRoutePath> {
  @override
  Future<FilmRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return FilmRoutePath.details(int.tryParse(remaining));
    } else {
      return FilmRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(FilmRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/film/${path.id}');
    }
    return null;
  }
}

class FilmRouterDelegate extends RouterDelegate<FilmRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FilmRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Film _selectedFilm;

  List<Film> films = [
    Film('Прочь, 2017', 'Джордан Пила', '«Прочь» вошёл в историю кинематографа, произведя настоящий кассовый фурор. При скромном бюджете в 4,5 млн долларов, хоррор собрал впечатляющие 255 млн долларов. Кроме того, картина о фотографе, который едет знакомиться с родителями девушки, получила премию «Оскар» за лучший оригинальный сценарий. Фильм увлекательный, страшный и виртуозный.',
    ),
    Film('Реинкарнация, 2018', 'Ари Астер', 'Мистический хоррор, ставший сенсацией на фестивале Sundance, собрал многочисленные восторженные отзывы. Успех картины объясним — она объединила в себе большинство самых эффектных жанровых механизмов: одержимость, ритуалы, зловещее проклятие, видения и многое другое. Но в то же время под оболочкой классического фильма ужасов о призраках скрывается волнующая история о распаде семьи. «Реинкарнация» обманывает ожидания зрителя, и в этом её главное достоинство.',
    ),
    Film('Оно, 2017', 'Андрес Мускетти', 'В тройке лидеров — экранизация Стивена Кинга, ставшая настоящей сенсацией. Хоррор Андреса Мускетти вошёл в историю кинематографа как самый кассовый фильм ужасов. История о подростках, вынужденных вступить в схватку с ужасающим клоуном-убийцей, собрала в мировом прокате рекордные 700 млн долларов. Это редкий хоррор, который был отлично принят как критиками, так и аудиторией. Страх здесь живёт в каждом кадре. Даже исполнитель роли клоуна Пеннивайза Билл Скарсгард, по его словам, долго не мог прийти в себя после съёмок.',
    ),
    Film('Ведьма, 2015', 'Роберт Эггерс', 'О режиссёре Роберте Эггерсе всё чаще говорят, как о самом одарённом мастере ужасов в современном кино. Его дебютный фильм «Ведьма» получил приз за режиссуру на фестивале Sundance. После этой картины стало окончательно понятно, что хоррор способен иметь художественную ценность. Вдохновившись мистической атмосферой средневековой Англии и смешав легенды, фольклор и сказки, Эггерс создал по-настоящему пугающую, леденящую кровь историю о возникновении ведьм. При этом хрупкость человеческих отношений занимает его куда больше, чем колдовство и демонические обряды.',
    ),
    Film('Заклятие, 2013', 'Джеймс Ван', 'На пятом месте фильм признанного мастера современного хоррора, автора «Пилы» и «Астрала» Джеймса Вана. В 2013 году картина была отмечена престижной премией «Сатурн» как лучшая в своём жанре. «Заклятие» оценили и зрители: при бюджете в 20 млн долларов, хоррор собрал 319 млн долларов и положил начало целой киновселенной «Заклятия», в центре которой – семейная пара Эда и Лоррейн Уорренов, парапсихологов и охотников за призраками. На сегодняшний день эта киновселенная насчитывает 8 фильмов, общие сборы которых составили 2 млрд долларов.',
    ),
    Film('Бабадук, 2014', 'Дженнифер Кент', 'В рейтинг лучших хорроров десятилетия вошёл «Бабадук» Дженнифер Кент. Единственный фильм ужасов из Абсолютного топа «НСТ», который был снят женщиной-режиссёром. Мрачный австралийский хоррор с элементами социально-психологической драмы, по мнению критиков, стал лучшим фильмом ужасов 2014 года. «Бабадук» — яркое высказывание на тему материнского страха и изящная игра на зрительских эмоциях. Картина вызывает ужас у зрителей не криками и кровью, а тем, что исследует худшие качества людей.',
    ),

  ];

  FilmRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  FilmRoutePath get currentConfiguration => _selectedFilm == null
      ? FilmRoutePath.home()
      : FilmRoutePath.details(films.indexOf(_selectedFilm));

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('FilmsListPage'),
          child: FilmsListScreen(
            films: films,
            onTapped: _handleFilmTapped,
          ),
        ),
        if (_selectedFilm != null) FilmDetailsPage(film: _selectedFilm)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedFilm to null
        _selectedFilm = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(FilmRoutePath path) async {
    if (path.isDetailsPage) {
      _selectedFilm = films[path.id];
    }
  }

  void _handleFilmTapped(Film film) {
    _selectedFilm = film;
    notifyListeners();
  }
}

class FilmDetailsPage extends Page {
  final Film film;

  FilmDetailsPage({
    this.film,
  }) : super(key: ValueKey(film));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return FilmDetailsScreen(film: film);
      },
    );
  }
}

class FilmRoutePath {
  final int id;

  FilmRoutePath.home() : id = null;

  FilmRoutePath.details(this.id);

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}

class FilmsListScreen extends StatelessWidget {
  final List<Film> films;
  final ValueChanged<Film> onTapped;

  FilmsListScreen({
    @required this.films,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Топ 6 фильмов ужасов'),
      ),
      body: ListView(
        children: [
          for (var film in films)
            ListTile(
              title: Text(film.title),
              subtitle: Text(film.author),
              onTap: () => onTapped(film),
            )
        ],
      ),
    );
  }
}

class FilmDetailsScreen extends StatelessWidget {
  final Film film;

  FilmDetailsScreen({
    @required this.film,
  });

  @override
  Widget build(BuildContext context) {
    final _sizeTextTitle = const TextStyle(fontSize: 30.0, color: Color(
        0xFF950808), fontWeight: FontWeight.bold, fontFamily: 'Hind',);
    final _sizeTextDescription = const TextStyle(fontSize: 15.0, fontFamily: 'Hind',);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (film != null) ...[

              Text(film.title, style:  _sizeTextTitle),
              Text(film.author, style: Theme.of(context).textTheme.subtitle1),
              Container(margin: const EdgeInsets.only(top: 10),),
              Text(film.description, style: _sizeTextDescription,),

            ],
          ],
        ),
      ),
    );
  }
}
