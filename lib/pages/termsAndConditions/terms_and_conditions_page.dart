import 'package:festivia/models/TermsAndConditionsTexts.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 70),
          child: Column(
            children: [
              _title("Términos y Condiciones", 25),
              Text(
                TermsAndConditionsTexts.p1,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("TÉRMINOS Y CONDICIONES DE VENTA", 20),
              Text(
                TermsAndConditionsTexts.p2,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p3,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("1. DESCRIPCIÓN DE LOS SERVICIOS", 20),
              Text(
                TermsAndConditionsTexts.p4,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p5,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p6,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p7,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p8,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("2. NECESIDAD DE REGISTRO", 20),
              Text(
                TermsAndConditionsTexts.p9,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  TermsAndConditionsTexts.p10,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("3. COMPRA DE ENTRADAS", 20),
              Text(
                TermsAndConditionsTexts.p11,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  TermsAndConditionsTexts.p12,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p13,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("4. MODO DE UTILIZACIÓN DE ENTRADAS", 20),
              Text(
                TermsAndConditionsTexts.p14,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("5. POLÍTICA DE DEVOLUCIÓN", 20),
              Text(
                TermsAndConditionsTexts.p15,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p16,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p17,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p18,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("6. PRIVACIDAD DE LA INFORMACIÓN", 20),
              Text(
                TermsAndConditionsTexts.p19,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p20,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p21,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("7. CONTENIDOS Y SITIOS ENLAZADOS", 20),
              Text(
                TermsAndConditionsTexts.p22,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p23,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p24,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  TermsAndConditionsTexts.p25,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              _title("9. JURISDICCIÓN Y LEY APLICABLE", 20),
              Text(
                TermsAndConditionsTexts.p26,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("10. INDEMNIDAD", 20),
              Text(
                TermsAndConditionsTexts.p27,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("11. DOMICILIO", 20),
              Text(
                TermsAndConditionsTexts.p28,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title(
                  "12. VIGENCIA Y CAMBIOS EN LOS TERMINOS y CONDICIONES", 20),
              Text(
                TermsAndConditionsTexts.p29,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "Fecha de última actualización: 01/10/2022",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String text, double size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
            fontSize: size),
      ),
    );
  }
}
