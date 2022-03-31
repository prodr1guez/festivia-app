import 'package:festivia/pages/ticketPage/ticket_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TicketPageController _controller = new TicketPageController();

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
      key: _controller.key,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10, left: 15),
              child: Text(
                "Anana party 2.0",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10, left: 15),
              child: Text(
                "San Martin 300, Tunuyan-Mendoza",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 10, left: 15),
              child: Text(
                "Sabado 2 de Abril de 2022 a las 00:00",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            QrImage(
              data: _controller.ticketId,
              size: 300,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                "Codigo: 123ABC",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
