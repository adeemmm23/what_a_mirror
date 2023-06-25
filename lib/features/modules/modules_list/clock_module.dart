import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';
import 'package:the_mirror/core/modules_post.dart';
import 'package:the_mirror/core/widgets.dart';

import '../modules_settings/modules_map.dart';

class ClockModule extends StatefulWidget {
  const ClockModule({super.key});

  @override
  State<ClockModule> createState() => _ClockModuleState();
}

class _ClockModuleState extends State<ClockModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String message = await postModules(clockModuleMap, 1);
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
        title: const Text('Clock Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(context, clockImage['dark'], clockImage['light']),
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
                    value: !clockModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.access_time),
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
                      clockModulePositionMBS(context, positions, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(getPositionName(clockModuleMap['position'])),
                  ),
                  leading: const Icon(Icons.flip_to_front),
                  title: const Text('Position'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['showTime'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['showTime'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.history_toggle_off),
                  title: const Text('Show time'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['displayType'] == 'analog'
                        ? true
                        : false,
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['displayType'] =
                            value ? 'analog' : 'digital';
                      });
                    },
                  ),
                  leading: const Icon(Icons.schedule),
                  title: const Text('Analog Clock'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed:
                        clockModuleMap['config']['displayType'] == 'analog'
                            ? () {
                                clockModuleFaceMBS(
                                    context, clockFaces, localSetState);
                              }
                            : null,
                    icon: const Icon(Icons.expand_more),
                    label: Text(getClockFaceName(
                        clockModuleMap['config']['analogFace'])),
                  ),
                  leading: const Icon(Icons.manage_history),
                  title: const Text('Analog clock face'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['showDate'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['showDate'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.calendar_month),
                  title: const Text('Show date'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['displaySeconds'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['displaySeconds'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.alarm),
                  title: const Text('Display seconds'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['timeFormat'] == 12
                        ? true
                        : false,
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['timeFormat'] =
                            value ? 12 : 24;
                      });
                    },
                  ),
                  leading: const Icon(Icons.watch),
                  title: const Text('12h Clock'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: clockModuleMap['config']['clockBold'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['clockBold'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.format_bold),
                  title: const Text('Bold time'),
                )),
            const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> clockModulePositionMBS(
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
                    groupValue: clockModuleMap['position'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['position'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for Face
  Future<dynamic> clockModuleFaceMBS(
      BuildContext context, List clockFaces, StateSetter localSetState) {
    return showModalBottomSheet(
        constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              for (var face in clockFaces)
                ListTile(
                  title: Text(face.face),
                  trailing: Radio(
                    value: face.id,
                    groupValue: clockModuleMap['config']['analogFace'],
                    onChanged: (value) {
                      localSetState(() {
                        clockModuleMap['config']['analogFace'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }
}
