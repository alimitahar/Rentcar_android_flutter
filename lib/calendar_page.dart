// Importation des packages
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime kNow = DateTime.now();
DateTime kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
DateTime kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

// ignore: unnecessary_const
const d_green = const Color(0xFF54D3C2);

// La méthode build de notre classe BottomNavBarSection renvoie donc le widget BottomNavigationBar
// Le seul attribut que nous mentionnons est celui de selectedItemColor pour nous permettre de définir la couleur lors de la sélection de l’item de notre barre
// Les différents items de notre barre de navigation sont créés avec le widget BottomNavigationBarItem et contient donc chacun une icône et un label

// Création du fichier de la page calendrier
// Nous allons mettre le contenu de la page de réservation dans un fichier différent, ceci afin de bien organiser notre code et le rendre plus lisible
// Pour créer notre page de réservation, nous allons nous rendre dans le dossier lib et faire un clic droit, puis créer un nouveau fichier que nous allons appeler “calendar_page.dart”
// Cette page doit aussi être importée dans notre fichier main.dart afin de permettre la navigation entre les deux pages (dans l'entête)
// Une fois notre page créée, nous commençons par importer le package principal que nous utiliserons, notamment le Material comme le montre le code suivant (dans l'entête)

// Installation du package table_calendar
// À la deuxième ligne de notre fichier calendar_page.dart, nous allons importer le package table_calendar qui nous donne accès au Widget de calendrier hautement personnalisable et riche en fonctionnalités

// Nous déclarons notre classe principale dans laquelle se trouvera tout notre code de la page de réservation, la classe CalendarPage()
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          PeriodSection(),
          CalendarRange(),
          ValidateBookingSection(),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}

class PeriodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Début',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Wednesday 22 Dec',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              width: 1,
              color: Colors.grey[350],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Friday 31 Dec',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }
}

class CalendarRange extends StatefulWidget {
  @override
  _CalendarRangeState createState() => _CalendarRangeState();
}

class _CalendarRangeState extends State<CalendarRange> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.grey[10],
      child: TableCalendar(
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 18),
        ),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          rangeHighlightColor: d_green,
          rangeStartDecoration: BoxDecoration(
            color: d_green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
          withinRangeTextStyle: TextStyle(
            color: Colors.white,
          ),
          rangeEndDecoration: BoxDecoration(
            color: d_green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        firstDay: kFirstDay,
        rangeSelectionMode: _rangeSelectionMode,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null;
              _rangeEnd = null;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class ValidateBookingSection extends StatelessWidget {
  final selectedRadio = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: selectedRadio,
          activeColor: d_green,
          groupValue: selectedRadio,
          selected: true,
          title: Text(
            "Flexible with dates",
            style: new TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          onChanged: null,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'Apply',
              style: TextStyle(fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              primary: d_green,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              print('Apply Demand');
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
