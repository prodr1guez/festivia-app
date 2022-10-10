import 'package:festivia/pages/reserveTicket/reserve_ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

class ReserveTickets extends StatefulWidget {
  @override
  _ReserveTicketsState createState() => _ReserveTicketsState();
}

class _ReserveTicketsState extends State<ReserveTickets> {
  final ReserveTicketController _controller = ReserveTicketController();

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
      backgroundColor: utils.Colors.BackgroundGrey,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [freeTicket(), paidTicket(), vipTicket()],
          ),
        ),
      ),
    );
  }

  Visibility freeTicket() {
    return Visibility(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 350,
      child: InkWell(
        onTap: _controller.freeToOrderPage,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Entrada Free",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 2),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Info",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 3, bottom: 2),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _controller.infoFree,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 2),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Entrada valida hasta: ",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_controller.dateParsed == null
                            ? "2 de febrero"
                            : _controller.dateParsed)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                            color: utils.Colors.sky,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          _controller.availableTicketsFreeText,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: const Text(
                        "Free",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Visibility paidTicket() {
    return Visibility(
        visible: _controller.isGeneral,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 350,
          child: InkWell(
            onTap: _controller.generalToOrderPage,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Entrada general",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 2),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Info",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          width: 210,
                          margin: const EdgeInsets.only(top: 3, bottom: 2),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _controller.infoGeneral,
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                color: utils.Colors.sky,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              _controller.availableTicketsGeneralText,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            _controller.priceParced + " \$",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Container(
                            width: 90,
                            child: const Text(
                              "* IVA + costo de servicio incluido",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Visibility vipTicket() {
    return Visibility(
        visible: false,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 350,
          child: InkWell(
            onTap: _controller.vipToOrderPage,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Entrada VIP",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 2),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Info",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 3, bottom: 2),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Entrada individual, no reembolsable. El crédito es en consumo (comida y bebida) ",
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                color: utils.Colors.sky,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: const Text(
                              "¡Quedan 12 Lugares!",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "\$3500",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
