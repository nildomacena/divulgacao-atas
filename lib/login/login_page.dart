import 'dart:html';

import 'package:awesome_select/awesome_select.dart';
import 'package:divulgacao_atas/login/login_controller.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flip_card/flip_card.dart';

class LoginPage extends GetWidget<LoginController> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      document.addEventListener('keydown',
          (event) => {if (event.type == 'tab') event.preventDefault()});
    }

    Widget escolherCampus() {
      return Container(
          margin: const EdgeInsets.only(top: 5),
          width: Get.width * .3,
          child: GetBuilder<LoginController>(
            builder: (_) {
              return SmartSelect<Campus?>.single(
                selectedValue: controller.campusSelecionado,
                title: _.campusSelecionado != null
                    ? 'Campus ${_.campusSelecionado!.nome}'
                    : 'Selecione o Campus',
                modalTitle: _.campusSelecionado != null
                    ? 'Campus ${_.campusSelecionado!.nome}'
                    : 'Selecione o Campus',
                choiceItems: controller.campi
                    .map((c) => S2Choice(value: c, title: c.nome))
                    .toList(),
                choiceType: S2ChoiceType.radios,
                modalConfig: const S2ModalConfig(
                  type: S2ModalType.popupDialog,
                  style: S2ModalStyle(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                onChange: (selectedCampus) {
                  if (selectedCampus.value != null) {
                    controller.escolherCampus(selectedCampus.value!);
                  }
                },
                tileBuilder: (context, state) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: controller.erroCampus ? 3 : 1,
                            color: controller.erroCampus
                                ? Colors.red
                                : Colors.grey),
                      ),
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            /* vertical: 7,
                          horizontal: 15, */
                            ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: S2Tile.fromState(
                          state,
                          hideValue: true,
                        ),
                      ),
                    ),
                  );
                },
                modalHeaderBuilder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: state.modalTitle,
                  );
                },
              );
            },
          ));
      //Get.to(() => EscolherCampusPage(campi), fullscreenDialog: true);
    }

    Widget inputEmail = Container(
      margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
      width: Get.width * .3,
      child: TextFormField(
          controller: controller.emailController,
          focusNode: controller.emailFocus,
          validator: controller.validatorEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            label: Text('Email'),
            border: OutlineInputBorder(),
          )),
    );

    Widget inputNome = Container(
      margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
      width: Get.width * .3,
      child: TextFormField(
          controller: controller.nomeController,
          focusNode: controller.nomeFocus,
          validator: controller.validatorNome,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            label: Text('Nome'),
            border: OutlineInputBorder(),
          )),
    );

    Widget inputSenha = Container(
      margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
      width: Get.width * .3,
      child: TextFormField(
          controller: controller.senhaController,
          focusNode: controller.senhaFocus,
          validator: controller.validatorSenha,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
            label: Text('Senha'),
            border: OutlineInputBorder(),
          )),
    );

    Widget inputConfirmaSenha = Container(
      margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
      width: Get.width * .3,
      child: TextFormField(
          controller: controller.confirmaSenhaController,
          focusNode: controller.confirmaSenhaFocus,
          validator: controller.validatorConfirmaSenha,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
            label: Text('Repita a senha'),
            border: OutlineInputBorder(),
          )),
    );

    Widget botaoToggleModo = GetBuilder<LoginController>(builder: (_) {
      print(_.criandoUsuario);
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextButton(
              onPressed: () {
                cardKey.currentState!.toggleCard();
                controller.toggleModo();
              },
              child: Text(
                _.criandoUsuario
                    ? 'Já possui usuário?'
                    : 'Deseja criar usuário?',
                style: const TextStyle(fontSize: 18),
              )));
    });

    Widget botaoFazerLogin = Container(
        width: Get.width * .3,
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            onPressed: () {
              controller.submitLogin();
            },
            child: const Text(
              'Fazer Login',
              style: TextStyle(fontSize: 18),
            )));

    Widget botaoCampi = Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: Get.width * .3,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1, color: Colors.grey)),
        child: const Text(
          'Escolher Campus',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          //controller.escolherCampus();
        },
      ),
    );

    Widget cardLogin = Container(
      width: Get.width * .6,
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 10,
        child: Form(
          key: controller.formLoginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )),
              inputEmail,
              inputSenha,
              botaoToggleModo,
              botaoFazerLogin
            ],
          ),
        ),
      ),
    );

    Widget botaoSubmitFormUsuario = Container(
        width: Get.width * .3,
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            onPressed: () {
              controller.submitNovoUsuario();
            },
            child: const Text(
              'Criar Usuário',
              style: TextStyle(fontSize: 18),
            )));

    Widget cardCriarUsuario = Container(
      width: Get.width * .6,
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 10,
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )),
              inputEmail,
              inputNome,
              inputSenha,
              inputConfirmaSenha,
              //botaoCampi,
              escolherCampus(),
              botaoToggleModo,
              botaoSubmitFormUsuario
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Instituto_Federal_Marca_2015.svg/1200px-Instituto_Federal_Marca_2015.svg.png',
                      fit: BoxFit.fitHeight),
                ),
                onTap: () {
                  controller.irParaHome();
                },
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Text('Divulgação de Atas'),
                onTap: () {
                  controller.irParaHome();
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: FlipCard(
            key: cardKey,
            onFlip: () {},
            fill: Fill.fillBack,
            direction: FlipDirection.HORIZONTAL,
            speed: 200,
            back: cardLogin,
            front: cardCriarUsuario),
      ),
    );
  }
}
