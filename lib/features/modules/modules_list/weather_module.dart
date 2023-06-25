import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';
import '../../../core/modules_post.dart';
import '../../../core/widgets.dart';
import '../modules_settings/modules_map.dart';
import 'dart:core';

class WeatherModule extends StatefulWidget {
  const WeatherModule({super.key});

  @override
  State<WeatherModule> createState() => _WeatherModuleState();
}

class _WeatherModuleState extends State<WeatherModule> {
  var weatherModulePosition = 'Top Right';
  var weatherModuleUnit = 'Metric';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await postModules(weatherCurrentModuleMap, 4);
          String message = await postModules(weatherForcastModuleMap, 5);
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
        title: const Text('Weather Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(context, weatherImage['dark'], weatherImage['light']),
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
                    value: !(weatherForcastModuleMap['disabled'] &&
                        weatherCurrentModuleMap['disabled']),
                    onChanged: (value) {
                      localSetState(() {
                        weatherForcastModuleMap['disabled'] = !value;
                        weatherCurrentModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.cloud),
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
                  trailing: Switch(
                    value: !weatherCurrentModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        weatherCurrentModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.sunny),
                  title: const Text('Weather Current'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: !weatherForcastModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        weatherForcastModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.beach_access),
                  title: const Text('Weather Forecast'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed: () {
                      weatherModulePositionMBS(
                          context, positions, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(weatherModulePosition),
                  ),
                  leading: const Icon(Icons.flip_to_front),
                  title: const Text('Position'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed: () {
                      locationMBS(context, states, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(weatherCurrentModuleMap['config']['location']),
                  ),
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed: () {
                      weatherModuleUnitsMBS(context, units, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(weatherModuleUnit),
                  ),
                  leading: const Icon(Icons.thermostat),
                  title: const Text('Units'),
                )),
            const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> weatherModulePositionMBS(
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
                    groupValue: weatherCurrentModuleMap['position'],
                    onChanged: (value) {
                      localSetState(() {
                        weatherCurrentModuleMap['position'] = value;
                        weatherForcastModuleMap['position'] = value;
                        weatherModulePosition = position.position;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for Location
  Future<dynamic> locationMBS(
      BuildContext context, List states, StateSetter localSetState) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              for (var state in states)
                ListTile(
                  title: Text(state.name),
                  trailing: Radio(
                    value: state.id,
                    groupValue: weatherCurrentModuleMap['config']
                        ['locationID'],
                    onChanged: (value) {
                      localSetState(() {
                        weatherCurrentModuleMap['config']
                            ['locationID'] = value;
                        weatherForcastModuleMap['config']
                            ['locationID'] = value;
                        weatherCurrentModuleMap['config']
                            ['location'] = state.name;
                        weatherForcastModuleMap['config']
                            ['location'] = state.name;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for Units
  Future<dynamic> weatherModuleUnitsMBS(
      BuildContext context, List units, StateSetter localSetState) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
        showDragHandle: true,
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              for (var unit in units)
                ListTile(
                  title: Text(unit.unit),
                  trailing: Radio(
                    value: unit.id,
                    groupValue: weatherCurrentModuleMap['config']
                        ['units'],
                    onChanged: (value) {
                      localSetState(() {
                        weatherCurrentModuleMap['config']['units'] =
                            value;
                        weatherForcastModuleMap['config']['units'] =
                            value;
                        weatherCurrentModuleMap['config']
                            ['tempUnits'] = value;
                        weatherForcastModuleMap['config']
                            ['tempUnits'] = value;
                        weatherCurrentModuleMap['config']
                            ['windUnits'] = value;
                        weatherForcastModuleMap['config']
                            ['windUnits'] = value;
                        weatherModuleUnit = unit.unit;
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
