import 'package:festivia/pages/ArtistHighlights/artist_highlights_page.dart';
import 'package:festivia/pages/ContactClub/contact_club_page.dart';
import 'package:festivia/pages/addArtist/add_artist_page.dart';
import 'package:festivia/pages/addGuest/add_guest.dart';
import 'package:festivia/pages/artistDetailPage/artist_page.dart';
import 'package:festivia/pages/clubHighlights/club_highlights_page.dart';
import 'package:festivia/pages/congratsEvent/congrats_events_page.dart';
import 'package:festivia/pages/congratsEventClub/congrats_events_club_page.dart';
import 'package:festivia/pages/congratsLiquidate/congrats_liquidate_page.dart';
import 'package:festivia/pages/contactUs/contact_us_page.dart';
import 'package:festivia/pages/detailClub/detail_club_page.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:festivia/pages/detailEventHost/detail_event_host_page.dart';
import 'package:festivia/pages/editClub/edit_club_page.dart';
import 'package:festivia/pages/editEvent/edit_event_page.dart';
import 'package:festivia/pages/editProfile/edit_profile_page.dart';
import 'package:festivia/pages/eventHighlights/event_highlights_page.dart';
import 'package:festivia/pages/eventStats/event_stats_page.dart';
import 'package:festivia/pages/forgotPassword/forgot_pass_page.dart';
import 'package:festivia/pages/games/games_page.dart';
import 'package:festivia/pages/guests/guests_page.dart';
import 'package:festivia/pages/home/home_page.dart';
import 'package:festivia/pages/imageFullScreen/image_full_screen_page.dart';
import 'package:festivia/pages/liquidateRevenue/liquidate_revenue_page.dart';
import 'package:festivia/pages/login/login_page.dart';
import 'package:festivia/pages/map/map_page.dart';
import 'package:festivia/pages/myEvents/my_events_page.dart';
import 'package:festivia/pages/myTickets/my_tickets_page.dart';
import 'package:festivia/pages/navigation/navigation_page.dart';
import 'package:festivia/pages/navigationClub/navigation_club_page.dart';
import 'package:festivia/pages/newsHighlights/new_highlights_page.dart';
import 'package:festivia/pages/order/order_page.dart';
import 'package:festivia/pages/pointGame/point_game_page.dart';
import 'package:festivia/pages/privacyPolicy/privacy_policy.dart';
import 'package:festivia/pages/register/register_page.dart';
import 'package:festivia/pages/registerClub/register_club_page.dart';
import 'package:festivia/pages/registerSelectTypeUser/select_type_user_page.dart';
import 'package:festivia/pages/reserveTicket/reserve_ticket_page.dart';
import 'package:festivia/pages/start_page.dart';
import 'package:festivia/pages/termsAndConditions/terms_and_conditions_page.dart';
import 'package:festivia/pages/ticketPage/ticket_page.dart';
import 'package:festivia/pages/verdadoreto/verdadoreto_page.dart';
import 'package:festivia/pages/yonunca/yonunca_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        'forgot_pass': (BuildContext context) => ForgotPassPage(),
        'congrats_liquidate': (BuildContext context) => CongratsLiquidate(),
        'contact_us': (BuildContext context) => ContactUsPage(),
        'congrats_event': (BuildContext context) => CongratsEvent(),
        'congrats_event_club': (BuildContext context) => CongratsEventClub(),
        'guests': (BuildContext context) => GuestsPage(),
        'add_guest': (BuildContext context) => AddGuest(),
        'terms_and_conditions': (BuildContext context) => TermsAndConditions(),
        'privacy_policy': (BuildContext context) => PrivacyPolicy(),
        'games_page': (BuildContext context) => GamesPage(),
        "yonunca_page": (BuildContext context) => YonuncaPage(),
        "point_game_page": (BuildContext context) => PointGamePage(),
        "verdad_o_reto_page": (BuildContext context) => VerdadoretoPage(),
        "edit_event": (BuildContext context) => EditEventPage(),
        "new_highlights": (BuildContext context) => NewHighlightsPage(),
        "edit_profile": (BuildContext context) => EditProfilePage(),
      },
    );
  }
}
