import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/modules_post.dart';
import '../modules/modules_settings/modules_map.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  double? progress;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setLocalState) {
      return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'save',
            onPressed: () async {
              await postModules(wallpaperModuleMap, 8);
              String message = await postModules(brightnessModuleMap, 9);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            },
            label: const Text('Save'),
            icon: const Icon(Icons.save),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: [
              const SizedBox(height: 20),
              const Text('Theming',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text('Configure your mirror\'s look',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                  shadowColor: Colors.transparent,
                  color: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        wallpaperModuleMap['config']['source'],
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/skelton.png',
                        fit: BoxFit.cover,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                            begin: 0,
                            end: brightnessModuleMap['config']['brightness']
                                .toDouble()),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        builder: (context, double value, child) {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Color.fromRGBO(0, 0, 0, (value - 1).abs()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          side: wallpaperModuleMap['config']['index'] == 0
                              ? BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                )
                              : BorderSide.none,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              setLocalState(() {
                                wallpaperModuleMap['config']['source'] =
                                    'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBlack.jpg?alt=media&token=8ec6b3fd-a424-4606-b004-69a8f74a8fcc';
                                wallpaperModuleMap['config']['index'] = 0;
                              });
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBlack.jpg?alt=media&token=8ec6b3fd-a424-4606-b004-69a8f74a8fcc',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          side: wallpaperModuleMap['config']['index'] == 1
                              ? BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                )
                              : BorderSide.none,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              setLocalState(() {
                                wallpaperModuleMap['config']['source'] =
                                    'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FFlower.jpg?alt=media&token=a1ef5852-e32a-4459-b129-7bc234663161';
                                wallpaperModuleMap['config']['index'] = 1;
                              });
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FFlower.jpg?alt=media&token=a1ef5852-e32a-4459-b129-7bc234663161',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          side: wallpaperModuleMap['config']['index'] == 2
                              ? BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                )
                              : BorderSide.none,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              setLocalState(() {
                                wallpaperModuleMap['config']['source'] =
                                    'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBird.jpg?alt=media&token=8345ee53-feca-4803-bf04-70be5814ccc2';
                                wallpaperModuleMap['config']['index'] = 2;
                              });
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBird.jpg?alt=media&token=8345ee53-feca-4803-bf04-70be5814ccc2',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          side: wallpaperModuleMap['config']['index'] == 3
                              ? BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 3,
                                )
                              : BorderSide.none,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              setLocalState(() {
                                wallpaperModuleMap['config']['source'] =
                                    'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FMountain.jpg?alt=media&token=bbc39839-ceb7-4945-aa13-48c7f05fbfdb';
                                wallpaperModuleMap['config']['index'] = 3;
                              });
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FMountain.jpg?alt=media&token=bbc39839-ceb7-4945-aa13-48c7f05fbfdb',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: progress == null
                            ? () {
                                uploadWallpaper(setLocalState);
                              }
                            : null,
                        child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            child: Center(
                                child: progress == null
                                    ? Icon(
                                        Icons.add,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )
                                    : TweenAnimationBuilder(
                                        tween: Tween<double>(
                                            begin: 1, end: progress!),
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        builder:
                                            (context, double value, child) {
                                          return CircularProgressIndicator(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.2),
                                            value: value,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          );
                                        }))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.brightness_low),
                    Expanded(
                      child: Slider(
                        value: brightnessModuleMap['config']['brightness']
                            .toDouble(),
                        onChanged: (value) {
                          setLocalState(() {
                            brightnessModuleMap['config']['brightness'] = value;
                            debugPrint(brightnessModuleMap['config']
                                    ['brightness']
                                .toString());
                          });
                        },
                        min: 0.2,
                        max: 1,
                        divisions: 8,
                      ),
                    ),
                    const Icon(Icons.brightness_high)
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  'Try to choose a dark wallpaper for better view to other modules!',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ));
    });
  }

  void uploadWallpaper(StateSetter setLocalState) async {
    // pick image from gallery
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    // creating instance in firebase bucket
    Reference ref = FirebaseStorage.instance
        .ref('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('wallpaper');
    try {
      UploadTask uploadTask = ref.putFile(File(file.path));
      uploadTask.snapshotEvents.listen((event) {
        if (event.state == TaskState.running) {
          setLocalState(() {
            progress = event.bytesTransferred / event.totalBytes;
          });
        } else if (event.state == TaskState.success) {
          ref.getDownloadURL().then((value) {
            setLocalState(() {
              wallpaperModuleMap['config']['index'] = 4;
              progress = null;
              wallpaperModuleMap['config']['source'] = value;
            });
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
