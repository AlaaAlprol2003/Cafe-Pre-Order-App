import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';

class TableScannerScreen extends StatefulWidget {
  const TableScannerScreen({super.key});

  @override
  State<TableScannerScreen> createState() => _TableScannerScreenState();
}

class _TableScannerScreenState extends State<TableScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkChocolate,
      appBar: AppBar(
        title: const Text("Scan Table QR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && !isScanCompleted) {
                isScanCompleted = true;
                final String rawValue = barcodes.first.rawValue ?? "Unknown Table";
                Navigator.pop(context, rawValue);
              }
            },
          ),
          Center(
            child: Container(
              width: 240.w,
              height: 240.h,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.darkOrange, width: 3.w),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}