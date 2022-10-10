import 'package:festivia/models/Club.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/GlobalData.dart';
import 'package:festivia/models/Invoice.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/global_data_provider.dart';
import 'package:festivia/providers/liquidate_provider.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

import '../../providers/user_provider.dart';

class LiquidateRevenueController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController cuilController = new TextEditingController();
  TextEditingController cbuController = new TextEditingController();

  AuthProvider _authProvider;
  UserProvider _userProvider;
  LiquidateProvider _liquidateProvider;
  ClubProvider _clubProvider;
  GlobalDataProvider _globalDataProvider;
  EventProvider _eventProvider;
  ProgressDialog _progressDialog;
  double revenue = 0;
  String idHolder;
  GlobalData globalData;
  double costService = 0;
  double totalCommission = 0;
  double totalRevenue = 0;

  String totalCommissionFixed = "0";
  double totalCommissionDoubleFixed = 0;
  User user;

  var arguments;
  String idEvent;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    _authProvider = AuthProvider();
    _liquidateProvider = LiquidateProvider();
    _userProvider = UserProvider();
    _eventProvider = EventProvider();
    _globalDataProvider = GlobalDataProvider();
    arguments = ModalRoute.of(context).settings.arguments as Map;
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    await _progressDialog.show();

    if (arguments != null) {
      idEvent = arguments["idEvent"];
    }

    idHolder = await _authProvider.getUser().uid;
    revenue = await getRevenue(idHolder);
    globalData = await _globalDataProvider.getDataCommissions();
    costService = globalData.liquidateRevenue;
    totalCommission = revenue * (costService / 100);
    totalCommissionFixed = totalCommission.toStringAsFixed(2);
    totalCommissionDoubleFixed = double.parse(totalCommissionFixed);
    totalRevenue = revenue - totalCommissionDoubleFixed;

    await _progressDialog.hide();
    refresh();
  }

  void liquidate() async {
    DateTime dateNow = DateTime.now();
    String username = usernameController.text;
    String cuil = cuilController.text.trim();
    String phone = phoneController.text.trim();
    String cbu = cbuController.text.trim();
    String date = dateNow.toString();
    String id = MinId.getId();
    String state = "waiting";

    if (username.isNotEmpty &&
        cuil.isNotEmpty &&
        phone.isNotEmpty &&
        cbu.isNotEmpty) {
      await _progressDialog.show();

      Invoice invoice = Invoice(
          holderId: idHolder,
          id: id,
          holder: username,
          cuil: cuil,
          phone: phone,
          cbu: cbu,
          date: date,
          state: state,
          amount: totalRevenue);

      if (totalRevenue == null) {
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'No tienes saldo');
      } else if (totalRevenue <= 0) {
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'No tienes saldo');
      } else {
        try {
          await _liquidateProvider.create(invoice);

          if (user.type == "club") {
            await _clubProvider.liquidateRevenue(idHolder, revenue);
          } else if (user.type == "client") {
            await _eventProvider.liquidateRevenue(idEvent, revenue);
          }

          await _progressDialog.hide();
          utils.Snackbar.showSnackbar(
              context, key, 'Petición solicitada correctamente');

          navigateToCongrats(context, user.type);
        } catch (error) {
          await _progressDialog.hide();
          utils.Snackbar.showSnackbar(context, key, 'Error: $error');
        }
      }
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
    }
  }

  Future<double> getRevenue(String id) async {
    user = await _userProvider.getById(id);
    if (user.type == "club") {
      _clubProvider = ClubProvider();

      Club club = await _clubProvider.getById(id);

      return club.currentRevenue;
    } else if (user.type == "client") {
      Event event = await _eventProvider.getById(idEvent);
      return event.revenue;
    }
  }

  navigateToCongrats(BuildContext context, String type) {
    Navigator.pushNamed(context, 'congrats_liquidate',
        arguments: {"type": type});
  }
}
