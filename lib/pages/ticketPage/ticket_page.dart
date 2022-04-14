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
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 45,
                  width: 150,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Image.asset("assets/festivia-cut.png")),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                _controller.nameEvent,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "San Martin 300, Tunuyan-Mendoza",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                _controller.date,
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
                _controller.ticketId,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
