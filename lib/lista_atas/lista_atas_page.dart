import 'package:awesome_select/awesome_select.dart';
import 'package:divulgacao_atas/lista_atas/lista_atas_controller.dart';
import 'package:divulgacao_atas/lista_atas/widgets/card_ata.dart';
import 'package:divulgacao_atas/model/campus_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ListaAtasPage extends StatelessWidget {
  final ListaAtasController controller = Get.find();
  ListaAtasPage({Key? key}) : super(key: key);

  Widget linhaFiltros() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        width: Get.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 30),
                child: const Text(
                  'Filtros:',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(left: 10),
              child: GetBuilder<ListaAtasController>(
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
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(
                                /* vertical: 7,
                                horizontal: 15, */
                                ),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 400,
              child: TextField(
                  controller: controller.objetoInputController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Objeto')),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(left: 30),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('FILTRAR'))),
            Container(
                height: 50,
                margin: const EdgeInsets.only(left: 30),
                child: TextButton(
                    onPressed: () {
                      controller.limparFiltros();
                    },
                    child: const Text('LIMPAR FILTROS'))),
            Expanded(child: Container())
          ],
        ));
    //Get.to(() => EscolherCampusPage(campi), fullscreenDialog: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetX<ListaAtasController>(
        builder: (_) {
          if (_.autenticado) {
            return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  _.novaAta();
                });
          }
          return Container();
        },
      ),
      appBar: AppBar(
          actions: [
            GetX<ListaAtasController>(
              builder: (_) {
                if (_.autenticado) {
                  return IconButton(
                      onPressed: () {
                        _.logout();
                      },
                      icon: const Icon(Icons.logout));
                }
                return IconButton(
                    onPressed: () {
                      _.irParaLogin();
                    },
                    icon: const Icon(Icons.lock));
              },
            ),
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
              const Text('Divulgação de Atas'),
            ],
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: linhaFiltros(),
          ),
          const Divider(),
          GetBuilder<ListaAtasController>(builder: (_) {
            print('carregando... ${_.carregando}');
            if (_.carregando) {
              return const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return GetX<ListaAtasController>(builder: (_) {
              if (_.atas.isEmpty) {
                if (_.filtroSelecionado) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Text(
                            'Não foram encontradas atas para os filtros selecionados'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _.limparFiltros();
                          },
                          child: const Text('LIMPAR FILTROS'))
                    ],
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: const Text(
                      'Nenhuma ata encontrada',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: _.atas.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 1000 ? 4 : 3,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    return CardAta(_.atas[index]);
                  });
            });

            /* StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: CardAta(_.atas[index]),
                ),
              ],
            ); */
          })
        ],
      ),
    );
  }
}
