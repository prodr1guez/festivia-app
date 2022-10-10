import 'package:festivia/models/PrivacyPolicyTexts.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 70),
          child: Column(
            children: [
              _title("Política de privacidad", 25),
              _title("1. POLÍTICA DE PRIVACIDAD Y SU ACEPTACIÓN", 20),
              Text(
                PrivacyPolicyTexts.p1,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("2. LOS SERVICIOS", 20),
              Text(
                PrivacyPolicyTexts.p2,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title(
                  "3. RECOLECCIÓN DE INFORMACIÓN DE LOS USUARIOS. FINES.", 20),
              Text(
                PrivacyPolicyTexts.p3,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title(
                  "4. USO DE LA INFORMACIÓN DE LOS USUARIOS RECOLECTADA.", 20),
              Text(
                PrivacyPolicyTexts.p4,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("5. NO VENTA DE INFORMACIÓN.", 20),
              Text(
                PrivacyPolicyTexts.p5,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("6. MENORES DE EDAD.", 20),
              Text(
                PrivacyPolicyTexts.p6,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("7. CONFIDENCIALIDAD Y SEGURIDAD DE LA INFORMACIÓN.", 20),
              Text(
                PrivacyPolicyTexts.p7,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("8. CAMBIOS EN LA ESTRUCTURA CORPORATIVA.", 20),
              Text(
                PrivacyPolicyTexts.p8,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("9. DERECHOS DE LOS USUARIOS SOBRE LA INFORMACIÓN.", 20),
              Text(
                PrivacyPolicyTexts.p9,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  PrivacyPolicyTexts.p10,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Ubuntu",
                      color: Colors.grey[700]),
                ),
              ),
              Text(
                PrivacyPolicyTexts.p11,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("10. EXCEPCIONES", 20),
              Text(
                PrivacyPolicyTexts.p12,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("11. SERVICIOS DE TERCEROS", 20),
              Text(
                PrivacyPolicyTexts.p13,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("12. CAMBIOS EN LA POLÍTICA DE PRIVACIDAD", 20),
              Text(
                PrivacyPolicyTexts.p14,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("13. CONTACTO", 20),
              Text(
                PrivacyPolicyTexts.p15,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              _title("14. USO DE LA CÁMARA EN LAS APLICACIONES", 20),
              Text(
                PrivacyPolicyTexts.p16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[700]),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
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
      margin: EdgeInsets.only(bottom: 10, top: 20),
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
