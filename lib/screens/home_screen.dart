import 'package:flutter/material.dart';
import 'package:koli_takip/pages/barkod_okuma_sayfasi.dart';
import 'package:koli_takip/utils/excel_helper.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> barcodeData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koli Takip Ana Sayfa"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final file = await pickExcelFile();
                if (file == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Dosya seçilmedi!")),
                  );
                  return;
                }

                final data = await readBarcodeData(file);
                setState(() {
                  barcodeData = data;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Excel başarıyla yüklendi")),
                );
              },
              child: const Text("📁 Excel Yükle"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: barcodeData.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarkodOkumaSayfasi(
                            barcodeData: barcodeData,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text("📦 Barkod Okuma Sayfası"),
            ),
          ],
        ),
      ),
    );
  }
}
