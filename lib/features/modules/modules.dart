import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({super.key});

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.store_rounded),
          label: const Text('Add Module'),
          onPressed: () {
            context.push('/modules/module_store');
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            const Text('Modules',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 2),
            Text('Tap on Modules to configure them',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/clock_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.access_time),
                  title: const Text('Clock Module'),
                  subtitle: const Text('This is a clock module'),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/calendar_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: const Text('Calendar Module'),
                  subtitle: const Text('This is a calendar module'),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/weather_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.cloud_outlined),
                  title: const Text('Weather Module'),
                  subtitle: const Text('This is a weather module'),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/compliments_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text('Compliments Module'),
                  subtitle: const Text('This is a compliments module'),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/news_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.newspaper_outlined),
                  title: const Text('Newsfeed Module'),
                  subtitle: const Text('This is a newsfeed module'),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    context.push('/modules/spotify_module');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  leading: const Icon(Icons.music_note_outlined),
                  title: const Text('Spotify Module'),
                  subtitle: const Text('This is a Spotify module'),
                )),
          ],
        ));
  }
}
