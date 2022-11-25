import 'package:aplicativo_inventario_2022/model/usuario.dart';
import 'package:aplicativo_inventario_2022/pages/login/login_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class LoginController extends GetxController {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController siapeController = TextEditingController();
  TextEditingController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode siapeFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode nomeFocus = FocusNode();
  FocusNode cpfFocus = FocusNode();

  bool signUp = false;
  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  final LoginRepository repository;

  LoginController(this.repository);

  String get labelBotaoSignUp => signUp
      ? 'Já fez o cadastro? Clique aqui.'
      : 'Não possui cadastro? Clique aqui';

  String get labelBotaoSubmit => loading
      ? 'AGUARDE...'
      : !signUp
          ? 'FAZER LOGIN'
          : 'CRIAR USUÁRIO';

  @override
  onInit() {
    super.onInit();
    Map<String, String> credentials = repository.getStoredCredentials();
    emailController.text = credentials['email'] ?? '';
    passwordController.text = credentials['password'] ?? '';
  }

  onSubmit() {
    signUp ? onSignup() : onLogin();
  }

  onSignup() async {
    try {
      loading = true;
      update();
      await repository.onSignup(
          nome: nomeController.text,
          email: emailController.text,
          cpf: cpfController.text,
          siape: siapeController.text,
          password: passwordController.text);
    } catch (e) {
      if (e == 'user-already-exists') {
        UtilService.snackBarErro(
            mensagem: 'Email já registrado. Tente fazer o login');
      } else if (e == 'pre-registration-not-exists') {
        UtilService.snackBarErro(
            mensagem:
                'O Pré-cadastro não foi realizado. Verifique com a comissão de inventário');
      } else {
        UtilService.snackBarErro(
            mensagem:
                'Ocorreu um erro durante o cadastro. Verifique as informações e tente novamente');
      }
    } finally {
      loading = false;
      update();
    }
  }

  toggleSignUp() {
    signUp = !signUp;
    update();
  }

  onSubmitEmail(String? nome) {
    signUp ? nomeFocus.requestFocus() : passwordFocus.requestFocus();
  }

  onSubmitNome(String? nome) {
    cpfFocus.requestFocus();
  }

  onSubmitCpf(String? nome) {
    cpfFocus.requestFocus();
  }

  onSubmitSenha(String? senha) {
    signUp ? confirmPasswordFocus.requestFocus() : onSubmit();
  }

  onSubmitConfirmPassword(String? senha) {
    onSubmit();
  }

  String? validatorNome(String? nome) {
    if (nome == null || nome.length < 6) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      return 'Digite um nome válido!';
    }
    return null;
  }

  String? validatorPassword(String? nome) {
    if (nome == null || nome.length < 6) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      return 'Digite uma senha válida!';
    }
    return null;
  }

  String? validatorConfirmPassword(String? senha) {
    if (senha == null || senha.length < 6) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      return 'Digite uma senha válida!';
    } else if (senha != passwordController.text) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      return 'As senhas não conferem';
    }
    return null;
  }

  String? validatorEmail(String? email) {
    if (email == null || !email.isEmail) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      return 'Digite um email válido!';
    }
    return null;
  }

  onLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      loading = true;
      update();
      Usuario usuario = await repository.onLogin(
          emailController.text, passwordController.text);
      print('usuario: ${usuario.nome}');
      Get.offAllNamed(Routes.localidades);
    } on FirebaseException catch (e) {
      UtilService.snackBarErro(mensagem: UtilService.tratarErroFirebase(e));
    } catch (e) {
      UtilService.snackBarErro(
          mensagem:
              'Erro durante o login. Verifique as informações e tente novamente.');
    } finally {
      loading = false;
      update();
    }
  }
  // onSubmit() async {
  //   Usuario usuario;
  //   late List<Localidade> localidades;
  //   try {
  //     if (signUp) {
  //       String cpf = cpfController.text.replaceAll('-', '').replaceAll('.', '');
  //       usuario = await controller.onSignupCompleto(
  //           nomeController.text,
  //           emailController.text,
  //           cpf,
  //           siapeController.text,
  //           passwordController.text);
  //     } else
  //       usuario = await controller.login(
  //           email: emailController.text, senha: passwordController.text);
  //   } catch (e) {
  //     print('ocorreu um erro durante o login: $e');
  //     utilService.showSnackBarErro(
  //         mensagem: 'Ocorreu um erro durante o login. Código: $e');
  //   }
  //   if (usuario != null) {
  //     print('usuario: $usuario');
  //     try {
  //       localidades = await fireService.getLocalidadesPorUsuario(usuario);
  //       //return Get.offAll(TesteCamera());
  //       // remover o comentário dessa linha quando terminar o teste com as streams return Get.offAll(HomePage(localidades));
  //       return Get.offAll(HomePage());
  //     } catch (e) {
  //       print('ocorreu um erro durante a busca das localidades: $e');
  //     }
  //   }
  // }
}
