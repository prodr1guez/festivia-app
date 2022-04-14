import 'package:festivia/pages/ArtistHighlights/artist_highlights_page.dart';
import 'package:festivia/pages/addArtist/add_artist_page.dart';
import 'package:festivia/pages/artistDetailPage/artist_page.dart';
import 'package:festivia/pages/detailClub/detail_club_page.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:festivia/pages/home/home_page.dart';
import 'package:festivia/pages/login/login_page.dart';
import 'package:festivia/pages/myEvents/my_events_page.dart';
import 'package:festivia/pages/navigation/navigation_page.dart';
import 'package:festivia/pages/order/order_page.dart';
import 'package:festivia/pages/register/register_page.dart';
import 'package:festivia/pages/reserveTicket/reserve_ticket_page.dart';
import 'package:festivia/pages/start_page.dart';
import 'package:festivia/pages/ticketPage/ticket_page.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthProvider _authProvider = AuthProvider();
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Festivia',
      initialRoute: 'start',
      routes: {
        'start': (BuildContext context) => StartPage(),
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'home': (BuildContext context) => HomePage(),
        'navigation': (BuildContext context) => NavigationPage(),
        'add': (BuildContext context) => NavigationPage(),
        'favourite': (BuildContext context) => NavigationPage(),
        'profile': (BuildContext context) => NavigationPage(),
        'detail_club': (BuildContext context) => DetailClubPage(),
        'my_events': (BuildContext context) => MyEvents(),
        'detail_event': (BuildContext context) => DetailEvent(),
        'reserve_tickets': (BuildContext context) => ReserveTickets(),
        'order': (BuildContext context) => OrderPage(),
        'artist_page': (BuildContext context) => ArtistPage(),
        'artis_highlights_page': (BuildContext context) => ArtistHighlights(),
        'ticket_page': (BuildContext context) => TicketPage(),
        'add_artist_page': (BuildContext context) => AddArtist()
      },
    );
  }
}
