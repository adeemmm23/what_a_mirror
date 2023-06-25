import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';

import '../../../core/modules_post.dart';
import '../../../core/widgets.dart';
import '../modules_settings/modules_map.dart';

class NewsModule extends StatefulWidget {
  const NewsModule({super.key});

  @override
  State<NewsModule> createState() => _NewsModuleState();
}

class _NewsModuleState extends State<NewsModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String message = await postModules(newsModuleMap, 6);
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
        title: const Text('Newsfeed Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(context, newsImage['dark'], newsImage['light']),
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
                    value: !newsModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.newspaper),
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
                      newsModulePositionMBS(
                          context, positions, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: Text(
                      getPositionName(newsModuleMap['position']),
                    ),
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
                      newsModuleStationsMBS(context, newsFeedStations);
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Select'),
                  ),
                  leading: const Icon(Icons.radio),
                  title: const Text('Stations'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: newsModuleMap['config']['showSourceTitle'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['config']['showSourceTitle'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.campaign),
                  title: const Text('Show Source Title'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: newsModuleMap['config']['showPublishDate'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['config']['showPublishDate'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.schedule),
                  title: const Text('Show Publish Date'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: newsModuleMap['config']['showDescription'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['config']['showDescription'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.description),
                  title: const Text('Show Description'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: newsModuleMap['config']['broadcastNewsFeeds'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['config']['broadcastNewsFeeds'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.settings_input_antenna),
                  title: const Text('Broadcast News Feeds'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: newsModuleMap['config']['broadcastNewsUpdates'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['config']['broadcastNewsUpdates'] =
                            value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.signal_cellular_alt),
                  title: const Text('Broadcast News Updates'),
                )),
            const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> newsModulePositionMBS(
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
                    groupValue: newsModuleMap['position'],
                    onChanged: (value) {
                      localSetState(() {
                        newsModuleMap['position'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }

  // Modal Bottom Sheet for newsfeed Stations
  Future<dynamic> newsModuleStationsMBS(
      BuildContext context, List newsFeedStations) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
      context: context,
      builder: (context) {
        bool checkTitle(String title) {
          for (var feed in newsModuleMap['config']['feeds']) {
            if (feed['title'] == title) {
              debugPrint(feed['title'] + ' is already in the list');
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
              for (var station in newsFeedStations)
                ListTile(
                  title: Text(station.feed),
                  trailing: Checkbox(
                    value: checkTitle(station.feed),
                    onChanged: (value) {
                      setModaleState(() {
                        if (value!) {
                          newsModuleMap['config']['feeds']
                              .add(newsFeedRSS[station.feed]);
                        } else {
                          newsModuleMap['config']['feeds'].remove(
                              newsModuleMap['config']['feeds']
                                  .firstWhere((element) =>
                                      element['title'] ==
                                      station.feed));
                        }
                      });
                      debugPrint(newsModuleMap['config']['feeds']
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
