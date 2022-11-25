import 'package:aplicativo_inventario_2022/data/auth_provider.dart';
import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginRepository {
  final FirestoreProvider firestoreProvider = Get.find();
  final AuthProvider authProvider = Get.find();
  GetStorage box = GetStorage();

  Map<String, String> getStoredCredentials() {
    String email = box.read('email') ?? '';
    String password = box.read('password') ?? '';
    return {'email': email, 'password': password};
  }

  Future<dynamic> onSignup(
      {required String nome,
      required String email,
      required String cpf,
      required String siape,
      required String password}) async {
    cpf = cpf.replaceAll('-', '').replaceAll('.', '');
    siape = siape.replaceAll('-', '').replaceAll('.', '');
    try {
      bool userExists =
          await firestoreProvider.checkIfUserExists(cpf: cpf, siape: siape);
      if (userExists) {
        return throw 'user-already-exists';
      }

      bool hasRegistration =
          await firestoreProvider.checkPreRegistration(cpf: cpf, siape: siape);
      if (!hasRegistration) {
        return throw 'pre-registration-not-exists';
      }

      UserCredential userCredential =
          await authProvider.createUser(email: email, password: password);
      if (userCredential.user != null) {
        storeEmailAndPassword(email, password);
      }
    } catch (e) {
      print('Erro: $e');
      rethrow;
    }
  }

  Future<Usuario> onLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await authProvider.login(email: email, password: password);
      if (userCredential.user == null) {
        throw 'user-null';
      }
      storeEmailAndPassword(email, password);
      return firestoreProvider.getUsuarioByUid(userCredential.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  storeEmailAndPassword(String email, String password) {
    box.write('email', email);
    box.write('password', password);
  }

  Future<dynamic> onSignup2(
      String nome, String email, String cpf, String siape, String senha) async {
    //   cpf = cpf.replaceAll('-', '').replaceAll('.', '');
    //   siape = siape.replaceAll('-', '').replaceAll('.', '');
    //   QuerySnapshot snapshot = await _firestore
    //       .collection('usuarios')
    //       .where('cpf', isEqualTo: cpf)
    //       .where('siape', isEqualTo: siape)
    //       .get();

    //   //Se não achar nenhum pré-cadastro exibir um alerta
    //   if (snapshot.docs.isEmpty) {
    //     print('PASSO 02');
    //     Get.back();
    //     Get.dialog(AlertDialog(
    //       title: const Text('Dados não encontrados'),
    //       content: const Text(
    //           'Seus dados (SIAPE ou CPF) não foram encontrados no pré-cadastro.\nEntre em contato com o administrador do seu campus para realizar seu pré-cadastro'),
    //       actions: [
    //         TextButton(
    //           child: const Text('OK'),
    //           onPressed: () {
    //             Get.back();
    //           },
    //         )
    //       ],
    //     ));
    //     throw 'usuario-nao-encontrado';
    //   }

    //   DocumentSnapshot documentSnapshot = snapshot.docs[0];

    //   if (documentSnapshot.data()['confirmado'] != null &&
    //       documentSnapshot.data()['confirmado']) {
    //     Get.back();
    //     Get.snackbar('Usuário já cadastrado', 'Realizando login...',
    //         snackPosition: SnackPosition.BOTTOM,
    //         margin: const EdgeInsets.only(bottom: 20),
    //         duration: const Duration(seconds: 2));
    //     print('PASSO 03');
    //     return login(
    //         email: email,
    //         senha:
    //             senha); //Se o usuário já está cadastrado, realiza o login e retorna o objeto usuário

    //   } else {
    //     try {
    //       print('PASSO 04');
    //       UserCredential userCredential = await _auth
    //           .createUserWithEmailAndPassword(email: email, password: senha);
    //       /*
    //           .catchError((FirebaseAuthException onError) {
    //         print('Entrou no catchError');
    //         if (onError.code == 'invalid-email')
    //           utilService.showSnackBarErro(
    //               titulo: 'Erro!', mensagem: 'Email incorreto');
    //         else if (onError.code == 'weak-password')
    //           utilService.showSnackBarErro(
    //               titulo: 'Erro!',
    //               mensagem: 'Digite uma senha com mais de 5 dígitos');
    //         else
    //           utilService.showSnackBarErro(
    //               titulo: 'Erro',
    //               mensagem:
    //                   'Ocorreu um durante o login. Verifique os dados e tente novamente');
    //       }); */
    //       User? user = userCredential.user;
    //       print('PASSO 05');
    //       if (user != null) {
    //         await _firestore.doc('usuarios/${documentSnapshot.id}').update({
    //           'confirmado': true,
    //           'nome': nome,
    //           'dataSignup': FieldValue.serverTimestamp(),
    //           'uid': user.uid
    //         });
    //         return Usuario.fromFirestore(
    //             await _firestore.doc('usuarios/${documentSnapshot.id}').get());
    //       } else {
    //         throw 'usuario-nao-encontrado';
    //       }
    //     } catch (e) {
    //       Get.back();
    //       if (e != 'usuario-nao-encontrado') {
    //         //Se ocorreu algum problema durante o cadastro, exclui o usuário do authentication
    //         await user.delete();
    //         return null;
    //       }
    //       return Future.error('error');
    //     }
    //   }
    // }
  }
}
