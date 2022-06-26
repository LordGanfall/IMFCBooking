import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class UserReportPdf extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const UserReportPdf({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UserReportPdf> createState() => _UserReportPdfState(documentSnapshot);
}

class _UserReportPdfState extends State<UserReportPdf> {
  final DocumentSnapshot documentSnapshot;
  _UserReportPdfState(this.documentSnapshot);

final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PdfPreview(
         maxPageWidth: 600,
        // useActions: false,
        canChangePageFormat: true,
        canChangeOrientation: false,
        // pageFormats:pageformat,
        canDebug: false,
    
        build: (format) => generateDocument(
          format,
        ),
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();   

  final netImage = await networkImage('https://www.supastrikas.com/sites/default/files/team/players/North_Shaw_1.png');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 50,
            marginLeft: 50,
            marginRight: 50,
            marginTop: 50,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Center(
                child: pw.Text(
                  'User Details',
                  style: const pw.TextStyle(
                    fontSize: 38,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Divider(thickness: 2),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.SizedBox(
                    height: 380,
                  child: pw.Image(netImage),)
                ]
                ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Email : ',
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    documentSnapshot['email'],
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Full Name : ',
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    documentSnapshot['fullname'],
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Username : ',
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    documentSnapshot['username'],
                    style: const pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );

    return doc.save();
  }
}