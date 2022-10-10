import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:festivia/pages/guests/guests_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import '../../widgets/button_app.dart';

class GuestsPage extends StatefulWidget {
  final String idEvent;

  GuestsPage({Key key, @required this.idEvent})
      : assert(idEvent != null),
        super(key: key);
  @override
  State<GuestsPage> createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  String name = "";
  GuestsController _controller = GuestsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 70, right: 70, bottom: 20),
          child: _buttonReserve()),
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefix: Icon(Icons.search_rounded), hintText: "Buscar"),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      key: _controller.key,
      body: SingleChildScrollView(
          child: Column(
        children: [
          _textTittle(),
          StreamBuilder<QuerySnapshot>(
            stream: _controller.getGuestSnapshot(widget.idEvent),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: snapshots.data.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data.docs[index].data()
                                as Map<String, dynamic>;

                            if (name.isEmpty) {
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, 'ticket_page',
                                      arguments: {
                                        "type": data["type"],
                                        "date": data["date"],
                                        "location": data["location"],
                                        "nameEvent": data["nameEvent"],
                                        "code": data["ticketId"],
                                      });
                                },
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey, width: 0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                trailing: Wrap(
                                  spacing: 12,
                                  children: <Widget>[
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                                title: Text(
                                  data['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            if (data['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(name.toLowerCase())) {
                              return ListTile(
                                  title: Text(
                                    data['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Wrap(
                                    spacing: 12,
                                    children: <Widget>[
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey, width: 0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ));
                            }
                            return Container();
                          }),
                    );
            },
          )
        ],
      )),
    );
  }

  Widget _textTittle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Text(
        'Invitados',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _buttonReserve() {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(
        child: ButtonApp(
          onPressed: () =>
              _controller.navigateToAddGuest(context, widget.idEvent),
          text: 'Agregar invitado',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
