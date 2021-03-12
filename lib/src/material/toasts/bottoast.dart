import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class OwToast {

  static loading() {
    return BotToast.showLoading();
  }

  static text(String message) {
    return BotToast.showText(text: message);
  }

  static close() {
    return BotToast.closeAllLoading();
  }

  static notification(
    {
      String title = "Ops... não conseguimos chegar no servidor",
      String subtitle = "Tente novamente em instantes",
      Function onTap,
      IconData icon = Icons.info_outline
    }) {
    return BotToast.showNotification(
      backgroundColor: Color(0xff12aa4b),
      leading: (cancel) => SizedBox.fromSize(
        size: const Size(40, 40),
        child: IconButton(
          icon: Icon(icon, color: Colors.white,),
          onPressed: cancel,
        )
      ),
      trailing: (cancel) => SizedBox(),
      onTap: onTap ?? () {BotToast.cleanAll();},
      title: (cancelFunc) => Text(title, style: TextStyle(color: Colors.white),),
      subtitle: (cancelFunc) => Text(subtitle, style: TextStyle(color: Colors.white),),
      enableSlideOff: true,
      backButtonBehavior: BackButtonBehavior.none,
      crossPage: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      borderRadius: 8,
      onlyOne: true,
      animationDuration: Duration(milliseconds: 0),
      animationReverseDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 7),
      align: Alignment.bottomCenter
    );
  }
}