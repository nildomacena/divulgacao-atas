import 'package:awesome_select/awesome_select.dart';
import 'package:divulgacao_atas/login/login_repository.dart';
import 'package:divulgacao_atas/login/widgets/escolher_campus_page.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:divulgacao_atas/services/util_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:divulgacao_atas/routes/app_routes.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final LoginRepository repository;
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Campus> campi = [];
  Campus? campusSelecionado;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode nomeFocus = FocusNode();
  FocusNode senhaFocus = FocusNode();
  FocusNode confirmaSenhaFocus = FocusNode();

  bool criandoUsuario = true;
  bool erroCampus = false;

  LoginController(this.repository);

  @override
  void onInit() {
    repository.getCampi().then((value) {
      campi = value;
      print('Campis: $value');
      update();
    });
    super.onInit();
  }

  irParaHome() {
    Get.offAndToNamed(Routes.home);
  }

  String? validatorEmail(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return 'Digite o seu email';
    }
    if (!value.contains(RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"))) {
      return 'Digite um email válido';
    }
    if (!value.contains('@ifal.edu.br')) {
      return 'Digite o seu email institucional';
    }
  }

  String? validatorNome(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Digite seu nome completo';
    }
  }

  String? validatorSenha(String? value) {
    if (value == null || value.isEmpty) return 'Digite a senha';
    if (value.length < 6) return 'Senha muito curta';
  }

  String? validatorConfirmaSenha(String? value) {
    if (value == null || value.isEmpty) return 'Repita a senha';
    if (value.length < 6) return 'Senha muito curta';
    if (value != senhaController.text) {
      return 'As senhas digitadas não são iguais';
    }
  }

  validatorCampus() async {
    if (campusSelecionado == null) {
      erroCampus = true;
      update();
    }
  }

  void onSubmitEmail(String email) {
    if (criandoUsuario) {
      nomeFocus.requestFocus();
    } else {
      senhaFocus.requestFocus();
    }
  }

  escolherCampus(Campus campus) {
    campusSelecionado = campus;
    erroCampus = false;
    update();
  }

  submitNovoUsuario() async {
    formKey.currentState!.validate();
    validatorCampus();
    if (campusSelecionado == null) return;
    try {
      await repository.criarUsuario(emailController.text, nomeController.text,
          senhaController.text, campusSelecionado!);
      Get.snackbar('Sucesso!', 'Usuário criado com sucesso');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          utilService.snackBarErro(
              mensagem: 'Email já utilizado. Tente fazer o login');
          break;
        default:
          utilService.snackBarErro(mensagem: 'Ocorreu um erro: ${e.code}');
      }
    } catch (e) {
      print('Erro: $e');
      utilService.snackBarErro(mensagem: 'Ocorreu um erro: $e');
    }
  }

  submitLogin() {
    formLoginKey.currentState!.validate();
  }

  toggleModo() {
    criandoUsuario = !criandoUsuario;
    formKey.currentState!.reset();
    formLoginKey.currentState!.reset();
    erroCampus = false;
    update();
  }
}
