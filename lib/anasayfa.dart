import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// En üst düzeyde fonksiyon tanımı


class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var androidAyari = const AndroidInitializationSettings("@mipmap/ic_launcher"); // uygulama ikonu-android için
    var iosAyari = const DarwinInitializationSettings();

    var kurulumAyari = InitializationSettings(android:  androidAyari, iOS: iosAyari);

    await flp.initialize(kurulumAyari, onDidReceiveBackgroundNotificationResponse: bildirimSecilme);
  }

  Future<void> bildirimGoster() async {

    var androidBildirimDetay = const AndroidNotificationDetails(
      "id",
       "name",
     channelDescription: "channelDescription",
      priority: Priority.high,  //eski kodlama
       importance: Importance.high); //güncel kodlama

       var iosBildirimDetay = const DarwinNotificationDetails();

       var bildirimDetay = NotificationDetails(android: androidBildirimDetay, iOS: iosBildirimDetay);

       await flp.show(0, "Başlık", "İçerik", bildirimDetay, payload: "Payload İçerik");
  }
  Future<void> bildirimSecilme(NotificationResponse notificationResponse) async {
  var payload = notificationResponse.payload;
}

  @override
  void initState() {
    super.initState();
    kurulum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              bildirimGoster();
            }, child: const Text("Bildirim Oluştur"))
          ],
        ),
      ),
    );
  }
}
