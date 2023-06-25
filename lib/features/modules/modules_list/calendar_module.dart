import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';
import 'package:the_mirror/core/validators.dart';

import '../../../core/modules_post.dart';
import '../../../core/widgets.dart';
import '../modules_settings/modules_map.dart';

GlobalKey<FormState> formAddCalendar = GlobalKey<FormState>();

class CalendarModule extends StatefulWidget {
  const CalendarModule({super.key});

  @override
  State<CalendarModule> createState() => _CalendarModuleState();
}

class _CalendarModuleState extends State<CalendarModule> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final symbolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).colorScheme.primaryContainer;
    Color inactiveColor = Theme.of(context).colorScheme.primary;
    bool calendarMax = calendarModuleMap['config']['maximumEntries'] == 15;
    bool calendarMin = calendarModuleMap['config']['maximumEntries'] == 3;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String message = await postModules(calendarModuleMap, 2);
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
        title: const Text('Calendar Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(context, calendarImage['dark'], calendarImage['light']),
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
                    value: !calendarModuleMap['disabled'],
                    onChanged: (value) {
                      setState(() {
                        calendarModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.calendar_month),
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
                      calendarModulePositionMBS(context, positions);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(getPositionName(calendarModuleMap['position'])),
                  ),
                  leading: const Icon(Icons.flip_to_front),
                  title: const Text('Position'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onLongPress: () {
                    addDialog(context, localSetState);
                  },
                  trailing: FilledButton.icon(
                    onPressed: () {
                      calendarsMBS(context, publicCalendarsName,
                          calendarModuleMap['config']['addionalCalendars']);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Add'),
                  ),
                  subtitle: const Text('Hold to add custom'),
                  leading: const Icon(Icons.edit_calendar),
                  title: const Text('Add Calendar'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: calendarModuleMap['config']['fade'],
                    onChanged: (value) {
                      setState(() {
                        calendarModuleMap['config']['fade'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.blur_on),
                  title: const Text('Fade'),
                )),
            Card(
              elevation: 2,
              shadowColor: Colors.transparent,
              child: ListTile(
                trailing: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      if (details.primaryVelocity! < 0 &&
                          calendarModuleMap['config']['maximumEntries'] < 15) {
                        calendarModuleMap['config']['maximumEntries']++;
                      } else if (details.primaryVelocity! > 0 &&
                          calendarModuleMap['config']['maximumEntries'] > 3) {
                        calendarModuleMap['config']['maximumEntries']--;
                      }
                    });
                  },
                  child: FilledButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_left,
                          color: calendarMin ? inactiveColor : activeColor,
                        ),
                        Text(calendarModuleMap['config']['maximumEntries']
                            .toString()),
                        Icon(
                          Icons.arrow_right,
                          color: calendarMax ? inactiveColor : activeColor,
                        ),
                      ],
                    ),
                  ),
                ),
                subtitle: const Text('Drag to change'),
                leading: const Icon(Icons.swipe),
                title: const Text('Max Days to Show'),
              ),
            ),
            const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> calendarModulePositionMBS(
      BuildContext context, List positions) {
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
                    groupValue: calendarModuleMap['position'],
                    onChanged: (value) {
                      setState(() {
                        calendarModuleMap['position'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> calendarsMBS(
      BuildContext context, List publicCalendars, List addional) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      showDragHandle: true,
      context: context,
      builder: (context) {
        bool checkCalendar(String name) {
          for (var calendar in calendarModuleMap['config']['calendars']) {
            if (calendar['name'] == name) {
              debugPrint(calendar['name'] + ' is already in the list');
              return true;
            }
          }
          return false;
        }

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModaleState) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              for (var calendar in publicCalendars)
                ListTile(
                  title: Text(calendar.name),
                  leading: Icon(
                    calendar.icon,
                  ),
                  trailing: Checkbox(
                    value: checkCalendar(calendar.name),
                    onChanged: (value) {
                      setModaleState(() {
                        if (value!) {
                          calendarModuleMap['config']['calendars']
                              .add(publicCalendar[calendar.name]);
                        } else {
                          calendarModuleMap['config']['calendars'].remove(
                              calendarModuleMap['config']['calendars']
                                  .firstWhere((element) =>
                                      element['name'] == calendar.name));
                        }
                      });
                      debugPrint(
                          calendarModuleMap['config']['calendars'].toString());
                    },
                  ),
                ),
              if (addional.isNotEmpty) const Divider(),
              for (var calendar in addional)
                ListTile(
                  onLongPress: () async {
                    final result = await deleteDialog(context, calendar);
                    if (result != null && result) {
                      setModaleState(() {
                        calendarModuleMap['config']['addionalCalendars'].remove(
                            calendarModuleMap['config']['addionalCalendars']
                                .firstWhere((element) =>
                                    element['name'] == calendar['name']));
                        if (checkCalendar(calendar['name'])) {
                          calendarModuleMap['config']['calendars'].remove(
                              calendarModuleMap['config']['calendars']
                                  .firstWhere((element) =>
                                      element['name'] == calendar['name']));
                        }
                      });
                    }
                    debugPrint(
                        calendarModuleMap['config']['calendars'].toString());
                  },
                  title: Text(calendar['name']),
                  leading: Icon(
                    getCalendarSymbol(calendar['symbol']),
                  ),
                  trailing: Checkbox(
                    value: checkCalendar(calendar['name']),
                    onChanged: (value) {
                      setModaleState(() {
                        if (value!) {
                          calendarModuleMap['config']['calendars']
                              .add(calendar);
                        } else {
                          calendarModuleMap['config']['calendars'].remove(
                              calendarModuleMap['config']['calendars']
                                  .firstWhere((element) =>
                                      element['name'] == calendar['name']));
                        }
                      });
                      debugPrint(
                          calendarModuleMap['config']['calendars'].toString());
                    },
                  ),
                ),
            ],
          );
        });
      },
    );
  }

  // Delete Dialog
  Future<dynamic> deleteDialog(BuildContext context, calendar) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Calendar'),
          content: Text('Are you sure you want to delete ${calendar['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Add Dialog
  Future<dynamic> addDialog(BuildContext context, StateSetter localSetState) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Center(
              child: Form(
                key: formAddCalendar,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add your own Calendar',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: validateName,
                            controller: nameController,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 72,
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            value: 'calendar-check',
                            items: [
                              for (var symbol in calendarSymbols)
                                DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: symbol.symbol,
                                  child: Icon(symbol.icon),
                                ),
                            ],
                            onChanged: (value) {
                              localSetState(() {
                                symbolController.text = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateUrl,
                      controller: urlController,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'ics URL',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                      onPressed: () {
                        localSetState(() {
                          if (formAddCalendar.currentState!.validate()) {
                            calendarModuleMap['config']['addionalCalendars']
                                .add({
                              'name': nameController.text,
                              'symbol': symbolController.text,
                              'url': urlController.text,
                            });
                            calendarModuleMap['config']['calendars'].add({
                              'name': nameController.text,
                              'symbol': symbolController.text,
                              'url': urlController.text,
                            });
                            nameController.clear();
                            symbolController.clear();
                            urlController.clear();
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('Add Calendar'),
                    ),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
