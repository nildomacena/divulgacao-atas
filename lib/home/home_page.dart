import 'package:divulgacao_atas/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    controller.irParaLogin();
                  },
                  icon: const Icon(Icons.lock))
            ],
            title: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Instituto_Federal_Marca_2015.svg/1200px-Instituto_Federal_Marca_2015.svg.png',
                      fit: BoxFit.fitHeight),
                ),
                Text('Divulgação de Atas'),
              ],
            )),
        body: SafeArea(child: Text('HomeController')));
  }
}
