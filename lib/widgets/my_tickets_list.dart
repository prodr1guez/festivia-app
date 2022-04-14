import 'package:festivia/models/HostEvent.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

import '../models/Ticket.dart';

class MyTicketsList extends StatelessWidget {
  AsyncSnapshot<List<Ticket>> snapshot;

  MyTicketsList({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Ticket ticket = snapshot.data[index];
              return InkWell(
                onTap: () {
                  navigateToDetail(context, ticket);
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Container(
                            height: 130,
                            width: 400,
                            child: ParallaxImage(
                                extent: 150,
                                image: NetworkImage(ticket.image))),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ticket.nameEvent,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10)),
              );
            }));
  }

  navigateToDetail(BuildContext context, Ticket ticket) {
    Navigator.pushNamed(context, 'ticket_page', arguments: {
      "type": ticket.type,
      "date": ticket.date,
      "location": ticket.location,
      "nameEvent": ticket.nameEvent,
      "image": ticket.image,
      "code": ticket.ticketId
    });
  }
}
