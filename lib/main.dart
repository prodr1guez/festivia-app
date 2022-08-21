import 'package:festivia/pages/ArtistHighlights/artist_highlights_page.dart';
import 'package:festivia/pages/ContactClub/contact_club_page.dart';
import 'package:festivia/pages/addArtist/add_artist_page.dart';
import 'package:festivia/pages/artistDetailPage/artist_page.dart';
import 'package:festivia/pages/clubHighlights/club_highlights_page.dart';
import 'package:festivia/pages/detailClub/detail_club_page.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:festivia/pages/detailEventHost/detail_event_host_page.dart';
import 'package:festivia/pages/editClub/edit_club_page.dart';
import 'package:festivia/pages/eventHighlights/event_highlights_page.dart';
import 'package:festivia/pages/eventStats/event_stats_page.dart';
import 'package:festivia/pages/home/home_page.dart';
import 'package:festivia/pages/imageFullScreen/image_full_screen_page.dart';
import 'package:festivia/pages/liquidateRevenue/liquidate_revenue_page.dart';
import 'package:festivia/pages/login/login_page.dart';
import 'package:festivia/pages/map/map_page.dart';
import 'package:festivia/pages/myEvents/my_events_page.dart';
import 'package:festivia/pages/myTickets/my_tickets_page.dart';
import 'package:festivia/pages/navigation/navigation_page.dart';
import 'package:festivia/pages/navigationClub/navigation_club_controller.dart';
import 'package:festivia/pages/navigationClub/navigation_club_page.dart';
import 'package:festivia/pages/order/order_page.dart';
import 'package:festivia/pages/register/register_page.dart';
import 'package:festivia/pages/registerClub/register_club_page.dart';
import 'package:festivia/pages/registerSelectTypeUser/select_type_user_page.dart';
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
        'navigation_club': (BuildContext context) => NavigationClubPage(),
        'add': (BuildContext context) => NavigationPage(),
        'my_tickets': (BuildContext context) => MyTickets(),
        'profile': (BuildContext context) => NavigationPage(),
        'detail_club': (BuildContext context) => DetailClubPage(),
        'my_events': (BuildContext context) => MyEvents(),
        'detail_event': (BuildContext context) => DetailEvent(),
        'reserve_tickets': (BuildContext context) => ReserveTickets(),
        'order': (BuildContext context) => OrderPage(),
        'artist_page': (BuildContext context) => ArtistPage(),
        'artis_highlights_page': (BuildContext context) => ArtistHighlights(),
        'ticket_page': (BuildContext context) => TicketPage(),
        'add_artist_page': (BuildContext context) => AddArtist(),
        'detail_event_host': (BuildContext context) => DetailEventHost(),
        'event_stats': (BuildContext context) => EventStatsPage(),
        'map_page': (BuildContext context) => MapPage(),
        'contact_club_page': (BuildContext context) => ContactClubPage(),
        'edit_club_page': (BuildContext context) => EditClubPage(),
        'select_type_user': (BuildContext context) => SelectTypeUser(),
        'register_club': (BuildContext context) => RegisterClubPage(),
        'liquidate_revenue': (BuildContext context) => LiquidateRevenuePage(),
        'event_highlights_page': (BuildContext context) =>
            EventHighlightsPage(),
        'club_highlights_page': (BuildContext context) => ClubHighlightsPage(),
        'image_full_screen': (BuildContext context) => ImageFullScreen(),
      },
    );
  }
}
