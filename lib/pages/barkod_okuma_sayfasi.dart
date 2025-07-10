import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarkodOkumaSayfasi extends StatefulWidget {
  final Map<String, int> barcodeData;

  const BarkodOkumaSayfasi({super.key, required this.barcodeData});

  @override
  State<BarkodOkumaSayfasi> createState() => _BarkodOkumaSayfasiState();
}

class _BarkodOkumaSayfasiState extends State<BarkodOkumaSayfasi> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Map<String, int> scanCounts = {};

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      final scannedCode = scanData.code ?? '';

      final expectedQty = widget.barcodeData[scannedCode];

      if (expectedQty == null) {
        _showStatusDialog("Barkod Excel’de bulunamadı ❌", Colors.red);
      } else {
        final currentCount = scanCounts[scannedCode] ?? 0;
        final newCount = currentCount + 1;
        scanCounts[scannedCode] = newCount;

        if (newCount == expectedQty) {
          _showStatusDialog("Tamamlandı ✅", Colors.green);
        } else if (newCount < expectedQty) {
          _showStatusDialog(
              "Eksik: $newCount / $expectedQty ⚠️", Colors.orange);
        } else {
          _showStatusDialog("Fazla okutma ❗️", Colors.redAccent);
        }
      }
    });
  }

  void _showStatusDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Durum", style: TextStyle(color: color)),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Tamam"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Barkod Okuma")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
