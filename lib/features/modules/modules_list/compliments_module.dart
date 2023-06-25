import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';

import '../../../core/modules_post.dart';
import '../../../core/widgets.dart';
import '../modules_settings/modules_map.dart';

class ComplimentsModule extends StatefulWidget {
  const ComplimentsModule({super.key});

  @override
  State<ComplimentsModule> createState() => _ComplimentsModuleState();
}

class _ComplimentsModuleState extends State<ComplimentsModule> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String message = await postModules(complimentsModuleMap, 3);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      appBar: AppBar(
        title: const Text('Compliments Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(context, complimentsImage['dark'],
                    complimentsImage['light']),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: !complimentsModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        complimentsModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.favorite),
                  title: const Text('Enable Module'),
                )),
            const Divider(
              height: 20,
              indent: 20,
              endIndent: 20,
            ),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed: () {
                      complimentsModulePositionMBS(
                          context, positions, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(
                        getPositionName(complimentsModuleMap['position'])),
                  ),
                  leading: const Icon(Icons.flip_to_front),
                  title: const Text('Position'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  subtitle: const Text('Long Press to customize'),
                  trailing: FilledButton.icon(
                    onLongPress: () {
                      complimentsDialog(
                          context,
                          'morning',
                          complimentsModuleMap['config']['compliments']
                              ['morningAdditional'],
                          localSetState);
                      debugPrint('Long Pressed');
                    },
                    onPressed: () {
                      complimentsListMBS(
                          context,
                          morningCompliments,
                          'morning',
                          complimentsModuleMap['config']['compliments']
                              ['morningAdditional']);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Select'),
                  ),
                  leading: const Icon(Icons.sunny),
                  title: const Text('Morning'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  subtitle: const Text('Long Press to customize'),
                  trailing: FilledButton.icon(
                    onLongPress: () {
                      complimentsDialog(
                          context,
                          'afternoon',
                          complimentsModuleMap['config']['compliments']
                              ['afternoonAdditional'],
                          localSetState);
                      debugPrint('Long Pressed');
                    },
                    onPressed: () {
                      complimentsListMBS(
                          context,
                          afternoonCompliments,
                          'afternoon',
                          complimentsModuleMap['config']['compliments']
                              ['afternoonAdditional']);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Select'),
                  ),
                  leading: const Icon(Icons.lunch_dining),
                  title: const Text('Afternoon'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  subtitle: const Text('Long Press to customize'),
                  trailing: FilledButton.icon(
                    onLongPress: () {
                      complimentsDialog(
                          context,
                          'evening',
                          complimentsModuleMap['config']['compliments']
                              ['eveningAdditional'],
                          localSetState);
                      debugPrint('Long Pressed');
                    },
                    onPressed: () {
                      complimentsListMBS(
                          context,
                          eveningCompliments,
                          'evening',
                          complimentsModuleMap['config']['compliments']
                              ['eveningAdditional']);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Select'),
                  ),
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Evening'),
                )),
                const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Dialog for Compliments
  Future<dynamic> complimentsDialog(BuildContext context, String time,
      List complimentsList, StateSetter localSetState) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
                height: 165,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Type it here!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Compliment',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: () {
                          localSetState(
                            () {
                              complimentsList.add(controller.text.toString());
                              complimentsModuleMap['config']['compliments']
                                      [time]
                                  .add(controller.text.toString());
                              controller.clear();
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Add Compliment'),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

// Modal Bottom Sheet for Position
  Future<dynamic> complimentsModulePositionMBS(
      BuildContext context, List positions, StateSetter localSetState) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              for (var position in positions)
                ListTile(
                  title: Text(position.position),
                  trailing: Radio(
                    value: position.id,
                    groupValue: complimentsModuleMap['position'],
                    onChanged: (value) {
                      localSetState(() {
                        complimentsModuleMap['position'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for compliments
  Future<dynamic> complimentsListMBS(
      BuildContext context, List complimentsList, String time, List addional) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModaleState) {
          return ListView(
            padding:const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              // Compliments
              for (var compliment in complimentsList)
                ListTile(
                  title: Text(compliment),
                  trailing: Checkbox(
                    value: complimentsModuleMap['config']
                            ['compliments'][time]
                        .contains(compliment),
                    onChanged: (value) {
                      setModaleState(() {
                        if (value!) {
                          complimentsModuleMap['config']
                                  ['compliments'][time]
                              .add(compliment);
                        } else {
                          complimentsModuleMap['config']
                                  ['compliments'][time]
                              .remove(compliment);
                        }
                      });
                      debugPrint(complimentsModuleMap['config']
                              ['compliments'][time]
                          .toString());
                    },
                  ),
                ),

              // Divider
              if (addional.isNotEmpty) const Divider(),

              // Addional Compliments
              for (var compliment in addional)
                ListTile(
                  title: Text(compliment),
                  trailing: Checkbox(
                    value: complimentsModuleMap['config']
                            ['compliments'][time]
                        .contains(compliment),
                    onChanged: (value) {
                      setModaleState(() {
                        if (value!) {
                          complimentsModuleMap['config']
                                  ['compliments'][time]
                              .add(compliment);
                        } else {
                          complimentsModuleMap['config']
                                  ['compliments'][time]
                              .remove(compliment);
                          addional.remove(compliment);
                        }
                      });
                      debugPrint(complimentsModuleMap['config']
                              ['compliments'][time]
                          .toString());
                    },
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
