import 'package:aplicativo_inventario_2022/pages/login/login_controller.dart';
import 'package:aplicativo_inventario_2022/widgets/custom_button.dart';
import 'package:aplicativo_inventario_2022/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_mask/easy_mask.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(child: GetBuilder<LoginController>(builder: (_) {
          return Form(
            key: _.formKey,
            child: ListView(
              controller: _.scrollController,
              shrinkWrap: true,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Instituto_Federal_de_Alagoas_-_Marca_Vertical_2015.svg/1200px-Instituto_Federal_de_Alagoas_-_Marca_Vertical_2015.svg.png'),
                ),
                CustomTextField(
                  label: 'Email',
                  controller: _.emailController,
                  onSubmitted: _.onSubmitEmail,
                  validator: _.validatorEmail,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  focusNode: _.emailFocus,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_.signUp) ...{
                  CustomTextField(
                      label: 'Nome',
                      controller: _.nomeController,
                      onSubmitted: _.onSubmitNome,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      validator: _.validatorNome,
                      focusNode: _.nomeFocus),
                  const SizedBox(
                    height: 20,
                  ),
                },
                if (_.signUp) ...{
                  CustomTextField(
                    label: 'CPF',
                    controller: _.cpfController,
                    onSubmitted: _.onSubmitCpf,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    inputFormatter: TextInputMask(mask: '999.999.999-99'),
                    focusNode: _.cpfFocus,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: 'SIAPE',
                    controller: _.siapeController,
                    onSubmitted: _.onSubmitCpf,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    focusNode: _.siapeFocus,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                },
                CustomTextField(
                    label: 'Senha',
                    obscure: true,
                    onSubmitted: _.onSubmitSenha,
                    controller: _.passwordController,
                    validator: _.validatorPassword,
                    textInputAction:
                        _.signUp ? TextInputAction.next : TextInputAction.send,
                    focusNode: _.passwordFocus),
                const SizedBox(
                  height: 20,
                ),
                if (_.signUp)
                  CustomTextField(
                    label: 'Repetir a senha',
                    obscure: true,
                    controller: _.confirmPasswordController,
                    onSubmitted: _.onSubmitConfirmPassword,
                    focusNode: _.confirmPasswordFocus,
                    validator: _.validatorConfirmPassword,
                    textInputAction: TextInputAction.send,
                  ),
                const SizedBox(
                  height: 20,
                ),
                CustomButtton(
                    text: _.labelBotaoSubmit,
                    onPressed: _.loading
                        ? null
                        : () {
                            _.onSubmit();
                          }),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _.toggleSignUp();
                    },
                    child: Text(_.labelBotaoSignUp)),
                if (_.signUp)
                  const SizedBox(
                    height: 60,
                  )
              ],
            ),
          );
        })),
      ),
    ));
  }
}
// class LoginPage extends GetWidget<AuthController> {
//   Widget build(BuildContext context) {
//     Future<String> _authLogin(LoginData data) async {
//       try {
//         dynamic result =
//             await controller.login(email: data.name, senha: data.password);
//         print('RESULT $result');
//         if (result.runtimeType == User) return null;
//       } catch (e) {
//         print('Erro: $e');
//         if (e.code != null) {
//           if (e.code == 'email-nao-institucional')
//             return 'Utilize seu email institucional';
//           if (e.code == 'ERROR_USER_NOT_FOUND') return 'Email não encontrado';
//           if (e.code == 'ERROR_WRONG_PASSWORD')
//             return 'Senha incorreta';
//           else
//             return 'Ocorreu o seguinte erro: ${e.code}';
//         }
//         return 'Ocorreu o seguinte erro: $e';
//       }
//       /*  try {
//         dynamic result = await fireService
//             .login(email: data.name, senha: data.password)
//             .catchError((onError) {
//           if (onError == 'email-nao-institucional') {
//             return 'Utilize seu email institucional';
//           }
//         });
//         print('result.runtimeType ${result.runtimeType == FirebaseUser}');
//         if (result.runtimeType == FirebaseUser) return null;

//         if (result.code != null) {
//           if (result.code == 'ERROR_WRONG_PASSWORD') return 'Senha incorreta';
//           if (result.code == 'ERROR_USER_NOT_FOUND')
//             return 'Email não cadastrado';
//           return result.code;
//         }
//       } catch (error) {
//         if (error == 'email-nao-institucional') {
//           return 'Utilize seu email institucional';
//         }
//       } */
//     }

//     Future<String> _authCreateUser(LoginData data) async {
//       Campus campusSelecionado = await Get.to(SelectCampusPage());
//       print('login data: $data');
//       await controller.onSignUp(data.name, data.password, campusSelecionado);
//       return Future.value('');
//       /* try {
//         dynamic result = await authService
//             .createUserWithEmail(data.name, data.password)
//             .catchError((onError) {
//           print('onError $onError');
//         });
//         if (result.runtimeType == FirebaseUser) {
//           /* Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => DadosPessoaisPage(),
//           )); */
//           return null;
//         }
//         if (result.code != null) {
//           if (result.code == 'ERROR_EMAIL_ALREADY_IN_USE')
//             return 'Email já utilizado. Tente fazer o login';
//           return result.code;
//         }
//         return null;
//       } catch (error) {
//         print('Error $error');
//         return 'error';
//       } */
//     }

//     Future<String> _resetPassword(String email) async {
//       try {
//         await fireService.resetSenha(email);
// /*         if (result.runtimeType == FirebaseUser) {
//           /* Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => DadosPessoaisPage(),
//           )); */
//           return null;
//         }
//         if (result.code != null) {
//           if (result.code == 'ERROR_EMAIL_ALREADY_IN_USE')
//             return 'Email já utilizado. Tente fazer o login';
//           return result.code;
//         }
//         return null; */
//       } on PlatformException catch (error) {
//         List<String> errors = error.toString().split(',');
//         print("Error: " + errors[1]);
//         if (error.code == 'ERROR_USER_NOT_FOUND') return 'Email não encontrado';
//         return error.code;
//       } catch (error) {
//         print('Error $error');
//         return 'error';
//       }
//       return null;
//     }

//     final List<Shadow> _shadows = [
//       Shadow(
//         offset: Offset(2, 2),
//         blurRadius: 3.0,
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(2, 2),
//         blurRadius: 3.0,
//         color: Colors.black,
//       )
//     ];

//     Widget containerLogin() {
//       return Container(
//         child: Stack(
//           children: <Widget>[
//             Container(
//               child: Image.asset('assets/logo.png', fit: BoxFit.cover),
//               color: Colors.black.withOpacity(.5),
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height,
//             ),
//             FlutterLogin(
//               theme: LoginTheme(
//                 primaryColor: Colors.green.withOpacity(.5),
//                 accentColor: Colors.purple,
//                 inputTheme: InputDecorationTheme(
//                   focusColor: Colors.purple,
//                   filled: true,
//                 ),
//                 buttonTheme: LoginButtonTheme(backgroundColor: Colors.purple),
//               ),
//               emailValidator: (String value) {
//                 if (value.isEmpty ||
//                     !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
//                   return 'Email inválido!';
//                 }
//               },
//               passwordValidator: (String value) {
//                 if (value.isEmpty || value.length <= 5) {
//                   return 'A senha precisa ter mais de 5 dígitos';
//                 }
//               },
//               messages: LoginMessages(
//                   usernameHint: 'Email Institucional',
//                   passwordHint: 'Senha',
//                   confirmPasswordError: 'As senhas digitadas são diferentes',
//                   confirmPasswordHint: 'Confirmar senha',
//                   signupButton: 'CRIAR USUÁRIO',
//                   forgotPasswordButton: 'Esqueceu a senha?',
//                   recoverPasswordButton: 'RECUPERAR SENHA',
//                   goBackButton: 'VOLTAR',
//                   recoverPasswordIntro: 'Resete sua senha aqui',
//                   recoverPasswordDescription:
//                       'Nós mandaremos um email pra você para recuperar sua senha. Cheque sua caixa de email.',
//                   recoverPasswordSuccess:
//                       'Email enviado. Acesse sua caixa de entrada e resete seu email'),
//               logo: 'assets/logo.png',
//               logoTag: 'IFAL - Inventário',
//               title: '',
//               onLogin: _authLogin,
//               onSignup: _authCreateUser,
//               onRecoverPassword: _resetPassword,
//               onSubmitAnimationCompleted: () async {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => Root(),
//                 ));
//                 /* print('onSubmitAnimationCompleted');
//                 bool perfilPreenchido =
//                     await firestoreService.getPerfilPreenchido();
//                 if (perfilPreenchido) {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => HomePage(),
//                   ));
//                 } else {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => DadosPessoaisPage(),
//                   ));
//                 } */
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     Widget containerLoginPersonal() {
//       return Container(
//         height: 400,
//         width: 400,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Column(
//           children: [],
//         ),
//       );
//     }

//     return Scaffold(
//       body: Container(
//           color: Colors.green[100],
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child:
//               containerLogin() /* Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(left: 30, right: 30),
//             child: containerLoginPersonal()), */
//           ),
//     );
//   }
// }
