import 'package:festivia/pages/registerSelectTypeUser/select_type_user_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SelectTypeUser extends StatefulWidget {
  const SelectTypeUser({Key key}) : super(key: key);

  @override
  State<SelectTypeUser> createState() => _SelectTypeUserState();
}

class _SelectTypeUserState extends State<SelectTypeUser> {
  final SelectTypeUserController _controller = SelectTypeUserController();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      body: SingleChildScrollView(
          child: Column(
        children: [
          _textRegister(),
          _userOption(),
          Container(
              margin: const EdgeInsets.only(top: 50), child: _clubOption()),
        ],
      )),
    );
  }

  Widget _textRegister() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Text(
        'Seleccione un tipo de usuario',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
    );
  }

  Widget _userOption() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20), // Border width
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100)),
          child: GestureDetector(
            onTap: _controller.toRegisterUser,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: Size.fromRadius(50), // Image radius
                child: Image.asset('assets/personas.png', fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Text(
          "Persona",
          style: TextStyle(
              fontFamily: "Ubuntu", fontSize: 22, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _clubOption() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20), // Border width
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100)),
          child: GestureDetector(
            onTap: _controller.toRegisterClub,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: Size.fromRadius(50), // Image radius
                child: Image.asset('assets/night-club.png', fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Text(
          "Club",
          style: TextStyle(
              fontFamily: "Ubuntu", fontSize: 22, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
