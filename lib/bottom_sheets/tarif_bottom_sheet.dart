// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tarif_provider.dart';

class TarifChooseBottomSheet extends StatefulWidget {
  const TarifChooseBottomSheet({super.key});

  @override
  State<TarifChooseBottomSheet> createState() => _TarifChooseBottomSheetState();
}

class _TarifChooseBottomSheetState extends State<TarifChooseBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            // const SizedBox(
            //   height: 50,
            // ),
            const Padding(
                padding: EdgeInsets.only(left: 40, top: 10),
                child: ListTile(
                    // titleAlignment: ListTileTitleAlignment.center,
                    title: Text("Aşakdaky tarifleriň birini saýlaň"))),
            const Divider(),
            Consumer<TarifProvider>(builder: (context, prov, _) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 0, right: 15),
                    decoration: BoxDecoration(
                        color: prov.tarif == 1
                            ? const Color(0xFFE5E7FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: prov.tarif == 1
                          ? const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                      title: Container(
                          margin: prov.tarif == 1
                              ? null
                              : const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Image.asset('assets/icon/clock.png'),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text("Sagatlaýyn"),
                            ],
                          )),
                      onTap: () {
                        prov.setTarif(1);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                    decoration: BoxDecoration(
                        color: prov.tarif == 2
                            ? const Color(0xFFE5E7FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: prov.tarif == 2
                          ? const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                      title: Container(
                          margin: prov.tarif == 2
                              ? null
                              : const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/car1.png',
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text("Adaty"),
                            ],
                          )),
                      onTap: () {
                        prov.setTarif(2);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                    decoration: BoxDecoration(
                        color: prov.tarif == 3
                            ? const Color(0xFFE5E7FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: prov.tarif == 3
                          ? const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                      title: Container(
                          margin: prov.tarif == 3
                              ? null
                              : const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/driving.png',
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text("Ýol ugruna"),
                            ],
                          )),
                      onTap: () {
                        // tarif.value = 2;
                        Provider.of<TarifProvider>(context, listen: false)
                            .setTarif(3);
                      },
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C5BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 45),
                      maximumSize:
                          Size(MediaQuery.of(context).size.width / 1.2, 45)),
                  onPressed: () {
                    Provider.of<TarifProvider>(context, listen: false)
                        .gotoTarif();
                    print(Provider.of<TarifProvider>(context, listen: false)
                        .tarif);
                  },
                  child: const Text(
                    "Tassyklamak",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            )
          ],
        ));
  }
}
