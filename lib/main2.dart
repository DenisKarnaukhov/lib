import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Общежитие 21 СФУ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '660000, Россия, г. Красноярск, пр. Свободный, 76Н ',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        'Студенческий жилой комплекс №21.'
            ' Общежитие было открыто в 2017 году. '
            'Имеется два вида комнат, оборудованных техникой  '
            'Удалено от дороги. Отличные виды из окна.'
            ' Комнаты оборудованы стиральной машиной, душем, унитазом, холодильником и эл. плитой на 2 конфорки. ',
        softWrap: true,
      ),
    );


    Widget textSectionTwo = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        'Большим плюсом является наличие спортивного зала, '
            'расположенного в здании общежития, который дает возможность проживающим '
            'поддерживать свою физическую форму. Помимо спортивного зала '
            'имеются и две комнаты отдыха, в которых проживающие могут провести свой досуг.',
        softWrap: true,
      ),
    );

    Widget textSectionThree = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        'Стоимость за проживание в общежитии начинается от 1021 рублей за стандартные комнаты 21 кв.м.,'
            'до 1643 рублей за расширенные комнаты 36 кв.м ',
        softWrap: true,
      ),
    );


    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Телефон'),
          _buildButtonColumn(color, Icons.near_me, 'Message'),
          _buildButtonColumn(color, Icons.share, 'Поделиться'),
        ],
      ),
    );

    Widget buttonSectionTwo = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.home_sharp, 'Оборудованные комнаты'),
          _buildButtonColumn(color, Icons.fitness_center, 'Спортивный зал'),
          _buildButtonColumn(color, Icons.spa, 'Комнаты отдыха'),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Общежития СФУ',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Общежития СФУ'),
          backgroundColor: Color(0xFFAD5C0C),
        ),
        body: ListView(
          children: [
            Image.asset(
              'lib/images/hotel.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            Image.asset(
              'lib/images/building.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            textSectionTwo,
            buttonSectionTwo,
            textSectionThree,
          ],
        ),
      ),
    );

  }
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color(0xFF0A0A8D)),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF0A0A8D),
            ),
          ),
        ),
      ],
    );
  }
}
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 88;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      }

      else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}