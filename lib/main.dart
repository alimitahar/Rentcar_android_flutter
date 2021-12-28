import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_page.dart';

// Nous utiliserons cette couleur dans toute notre application, que nous définissons ici en utilisant un code hexadécimal
const d_green = Color(0xFF54D3C2);

// La focntion main() lancera le code de notre application, grâce à la fonction runApp() qui chargera la classe MyApp
void main() {
  runApp(MyApp());
}

// La classe MyApp va contenir la méthode build() qui permettra de dessiner l’interface utilisateur avec le widget MaterialApp() (application utilisant le material design)
// Nous donnons un titre à notre application avec le champ title
// Nous mettons également l’attribut debugShowCheckedModeBanner à false pour supprimer la bannière de débogage
// Enfin nous avons le champ Home qui va nous permettre de définir le Widget qui sera la page d’accueil de l’application

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tunisia Rent a Car',
      home: HomePage(),
    );
  }
}

// Ici nous appelons le widget HomePage() qui représentera notre page d’accueil que nous allons créer dans la prochaine partie

// Créer le design de notre page d’accueil

// Nous alors diviser notre page en plusieurs widgets qui seront créés indépendamment avant d’être appelé dans notre HomePage()
// Pour commencer, nous déclarons notre classe HomePage() comme un StatelessWidget qui va contenir la page d’accueil de notre application

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchSection(),
            VoitureSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

// La méthode build retourne un Scaffold() qui est le widget qui implémente la structure de base d’une page en utilisant le material design
// Il nous permettra de définir notre appBar, notre Body et ainsi qu’une bottomNavigationBar

// Création de la barre de navigation (appBar)

// Notre appBar est constitué de trois icônes que nous allons insérer en utilisant ici le widget IconButton et d’un texte que nous allons ajouter en utilisant le widget Text
// Dans la déclaration de notre appBar, nous allons aussi renseigner les propriétés nécessaires à notre widget AppBar:
// * La propriété backgroundColor avec pour valeur une couleur blanche
//* La propriété centerTitle pour centrer notre titre
// Pour le reste, on place notre première icône dans le champ leading grâce au widget IconButton
// Ensuite, on utilise le widget Text pour le champ title et pour la deux autres icônes, nous les définissons dans le champ actions

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: Text(
        'Explore',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: Colors.grey[800],
            size: 20,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.place,
            color: Colors.grey[800],
            size: 20,
          ),
          onPressed: null,
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

// Création de la SearchSection de notre page d’accueil

// La première section (SearchSection) sera constituée de deux rows :
//* La première contiendra un champ de texte et un bouton pour lancer la recherche
// * La deuxième contiendra les dates et voitures choisies pour la réservation
//La deuxième section de notre page (VoitureSection) quant à elle est constituée du résultat de la recherche, notamment une image de la voiture et ses informations complémentaire

// Le corps de notre page d’accueil est contenu dans le widget principal SingleChildScrollView et dans une Column pour permettre de scroller à la verticale
// Le premier enfant de notre SearchSection est donc une Row qui elle va contenir le champ de texte et le bouton de recherche
// Nous mettons le champ texte dans le widget Expanded afin qu’il remplisse l’espace disponible le long de l’axe principal du widget, ceci pour gérer le responsive de notre page
// Pour le deuxième enfant de notre SearchSection, nous avons une autre Row comportant des widgets Text classiques

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'London',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CalendarPage();
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: CircleBorder(),
                    shadowColor: Colors.white,
                    primary: d_green,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose date',
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '22 Dec - 31 Dec',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of days',
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 Car - 1 Adult respensible',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Vous devrez bien sûr déclarer votre page calendar_page.dart pour faire fonctionner votre code et ainsi activer la navigation

// Création de la VoitureSection de notre page d’accueil
// Comme deuxième enfant de la colonne de notre body, nous avons le widget VoitureSection que nous allons créer
// Ce dernier nous permet d’afficher les informations des différentes voitures trouvées lors de la recherche

class VoitureSection extends StatelessWidget {
  final List VoitureList = [
    {
      'title': 'Best Car',
      'place': 'Monastir - Ksar Hellal, Tunisia',
      'distance': 1,
      'review': 36,
      'picture': 'images/voiture_1.png',
      'price': '60',
    },
    {
      'title': 'Rent Last Model',
      'place': 'Monastir - Lamta, Tunisia',
      'distance': 3,
      'review': 13,
      'picture': 'images/voiture_2.png',
      'price': '80',
    },
    {
      'title': 'Comfortable cars',
      'place': 'Monastir - Sayada, Tunisia',
      'distance': 3,
      'review': 88,
      'picture': 'images/voiture_3.png',
      'price': '70',
    },
    {
      'title': 'Prima Rent a Car',
      'place': 'Monastir - Moknine, Tunisia',
      'distance': 2,
      'review': 34,
      'picture': 'images/voiture_4.png',
      'price': '100',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '112 Companies for renting cars founds',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: d_green,
                        size: 25,
                      ),
                      onPressed: null,
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: VoitureList.map((voiture) {
              return VoitureCard(voiture);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// On crée ensuite le widget HotelCard de manière séparée pour créer le design de notre carte d’hôtel de manière précise
// Ce widget prend en paramètre un objet Map pour remplir son contenu, avec une image et différentes informations comme le nom et le prix de l’hôtel

class VoitureCard extends StatelessWidget {
  final Map VoitureData;
  VoitureCard(this.VoitureData);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                image: AssetImage(
                  VoitureData['picture'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: -15,
                  child: MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite_outline_rounded,
                      color: d_green,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  VoitureData['title'],
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  VoitureData['price'] + '\ DNT',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  VoitureData['place'],
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: d_green,
                      size: 14.0,
                    ),
                    Text(
                      VoitureData['distance'].toString() + ' km away',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  'per day',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star_rate,
                      color: d_green,
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star_border,
                      color: d_green,
                      size: 14.0,
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Text(
                  VoitureData['review'].toString() + ' reviews',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Création de notre bottomNavigationBar
// Pour créer notre barre de navigation, nous utilisons le widget classique BottomNavigationBar()
// Notre barre de navigation est constitué de trois icônes et labels

class BottomNavBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: d_green,
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: d_green,
          ),
          label: 'Tips',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: d_green,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
