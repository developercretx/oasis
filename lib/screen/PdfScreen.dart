import 'package:flutter/material.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

class PdfScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfScreen({Key key, this.pdfUrl}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  PDFDocument doc;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    Future.microtask(() async {
      doc = await PDFDocument.fromURL(widget.pdfUrl);
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      goback: true,
      hasdrawer: false,
      isdark: true,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: doc,
              backgroundNavigation: Color(0xFF403d3d),
              iconNavigation: Colors.white,
              backgorundPickPage: Color(0xFF403d3d),
            ),
    );
  }
}
