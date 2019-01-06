import 'package:pdf/pdf.dart';
import 'package:star_builder/character.dart';

class PdfGenerator {
  static PDFDocument generateForCharacter(StarfinderCharacter character) {
    PDFDocument pdf = new PDFDocument();

    PDFPage page = new PDFPage(pdf, pageFormat: PDFPageFormat.letter);
    PDFGraphics g = page.getGraphics();
    PDFFont font = new PDFFont(pdf);
    double top = page.pageFormat.height;

    g.setColor(new PDFColor(0.3, 0.3, 0.3));
    g.drawString(font, 14.0, "Character Name", 10.0 * PDFPageFormat.mm,
        top - 10.0 * PDFPageFormat.mm);
    g.drawString(font, 14.0, character.name, 60.0 * PDFPageFormat.mm,
        top - 10.0 * PDFPageFormat.mm);

    return pdf;
  }
}
