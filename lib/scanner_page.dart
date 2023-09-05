import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QRCodeScannerScreenState();
}

class QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // unique identify the QR
  // late here is varable will be initialized after QRViewCont interact with and controll the scanning procees
  late QRViewController
      controller; // control(instance of Qr controller) and interact with QR scan
  String qrText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('QR Code Scanner'),
        toolbarHeight: 90,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(46.0), // Adjust the padding as needed

              child: AspectRatio(
                aspectRatio: 1,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Scanned QR Data: $qrText'),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    //updating the state of widget
    setState(() {
      this.controller = controller;
    });
    // scannedDataStreamProperty is a listener Barcode to control setstate
    controller.scannedDataStream.listen((Barcode scanData) {
      // setstate update the state of the widget
      setState(() {
        qrText = scanData
            .code!; // assigning QR code data scandata is to acces the text content
      });
      Fluttertoast.showToast(
        msg: 'Scanned QR Data: $qrText',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }
}
