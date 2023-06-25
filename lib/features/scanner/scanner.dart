import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '/core/images.dart';

String userRefreshToken = '';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  // Scanning state
  bool isScanCompleted = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        isDark(context, logo['dark'], logo['light']),
                        height: 34,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Image.asset(
                  isDark(context, logo['dark'], logo['light']),
                  height: 30,
                ),
              ),
            ),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ready to link your mirror?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          MobileScanner(
                            controller: MobileScannerController(
                              returnImage: isScanCompleted,
                            ),
                            fit: BoxFit.cover,
                            onDetect: (capture) {
                              var output = capture.barcodes
                                  .map((value) => value.rawValue);
                              debugPrint(output.toString());
                              if (output.toString().startsWith('(mirror') &&
                                  !isScanCompleted) {
                                setState(() {
                                  isScanCompleted = true;
                                });
                                debugPrint('cbnn');
                                mirrorLinker(output.toString().substring(
                                    7, output.toString().length - 1));
                                context.go('/home');
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image.asset(
                              'assets/images/scanner.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Scan the QR code on your mirror \n to get started.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                        onPressed: () {
                          context.go('/home');
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Get back')),
                    const SizedBox(height: 70),
                  ]),
            ),
          );
        });
  }

  // Send users info to be linked to the mirror
  Future<void> mirrorLinker(String mirrorid) async {
    Map<String, dynamic> userInfos = {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'refreshToken': userRefreshToken,
      'idToken': await FirebaseAuth.instance.currentUser!.getIdToken(),
    };
    try {
      debugPrint(userInfos.toString());
      final dbRef = FirebaseDatabase.instance.ref('mirrors/$mirrorid');
      final dbRef2 = FirebaseDatabase.instance
          .ref('users/${FirebaseAuth.instance.currentUser!.uid}');
      await dbRef.update(userInfos);
      await dbRef2.update({'linkedMirror': mirrorid});
      debugPrint('Posted successfully');
    } catch (error) {
      debugPrint('Error posting: $error');
    }
  }
}
