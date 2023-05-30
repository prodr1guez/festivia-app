import 'package:cached_network_image/cached_network_image.dart';

import 'package:festivia/pages/profile/profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _controller = new ProfileController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        key: _controller.key,
        endDrawer: drawer(context),
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _controller.client.image.isNotEmpty
                          ? CachedNetworkImageProvider(_controller.client.image)
                          : AssetImage("assets/holder_profile.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 30),
                  child: Text(
                    _controller.client.username,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    _controller.client.genders.isNotEmpty
                        ? _controller.client.genders.toString()
                        : "-",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14, fontFamily: "Ubuntu", color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    _controller.client.location,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Ubuntu",
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            myEventsButton(),
            configButton(),
            editButton()
          ],
        ));
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/festivia_slogan_blanco.png'))),
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Contáctanos'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () => {_controller.logout()},
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Eliminar cuenta'),
              onTap: () => {_controller.openDialog()},
            ),
          ],
        ),
      ),
    );
  }

  Positioned myEventsButton() {
    return Positioned(
      top: 430,
      child: Container(
        margin: EdgeInsets.only(right: 130),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(100)),
        child: GestureDetector(
          onTap: () {
            _controller.goToMyEvents();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Mis eventos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned editButton() {
    return Positioned(
      top: 425,
      right: 60,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(100)),
        child: GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, 'edit_profile',
                    arguments: _controller.client)
                .then((_) => setState(() {
                      _controller.init(context, refresh);
                    }))
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.fromSize(
              size: Size.fromRadius(25), // Image radius
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned configButton() {
    return Positioned(
      top: 425,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(100)),
        child: GestureDetector(
          onTap: () {
            _controller.key.currentState.openEndDrawer();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.fromSize(
              size: Size.fromRadius(25), // Image radius
              child: Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _controller.client.username,
            style: TextStyle(
              fontFamily: "Ubuntu",
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
