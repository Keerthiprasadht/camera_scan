import 'package:camera_scan/google_map_page.dart';
import 'package:camera_scan/scanner_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showFields = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          actions: [
            // Settings button
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Toggle the visibility of Scan and Map fields
                setState(() {
                  showFields = !showFields;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Conditional Scan and Map fields
              if (showFields)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 135, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: 5,
                      ),
                    ],
                    // color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle scan button press
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => QRCodeScannerScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Scan QR code',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Divider(
                        height: 20.0,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle map button press
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GoogleMapPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Load Map',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
