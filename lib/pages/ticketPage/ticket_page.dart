import 'package:festivia/pages/ticketPage/ticket_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TicketPageController _controller = TicketPageController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backu.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 100,
                    width: 230,
                    margin: const EdgeInsets.only(left: 10),
                    child: Image.asset("assets/festivia_slogan_blanco.png")),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  _controller.nameEvent,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              Container(
                width: 300,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _controller.location,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _controller.date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              QrImage(
                data: _controller.ticketId,
                size: 300,
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  _controller.ticketId,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  _controller.type.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
