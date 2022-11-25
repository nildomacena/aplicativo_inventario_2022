import 'dart:io';

import 'package:flutter/material.dart';

class VisualizarImagemPage extends StatelessWidget {
  final File imagem;
  const VisualizarImagemPage(this.imagem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
                tag: imagem.path, child: Image.file(imagem, fit: BoxFit.cover)),
            Positioned(
              bottom: 10,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'EXCLUIR IMAGEM',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    bool excluir = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Excluir imagem'),
                              content: const Text(
                                  'Deseja realmente excluir essa imagem?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Excluir'),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                )
                              ],
                            ));
                    Navigator.of(context).pop(excluir);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
