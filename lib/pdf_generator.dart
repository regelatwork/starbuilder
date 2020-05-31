import 'package:pdf/pdf.dart';
import 'package:star_builder/character.dart';

class PdfGenerator {
  static PdfDocument generateForCharacter(StarfinderCharacter character) {
    PdfDocument pdf = new PdfDocument();

    PdfPage page = new PdfPage(pdf, pageFormat: PdfPageFormat.letter);
    PdfGraphics g = page.getGraphics();
    PdfFont font = new PdfFont.helvetica(pdf);
    double top = page.pageFormat.height;
    g.setColor(new PdfColor(0.3, 0.3, 0.3));

    // Name
    g.drawString(font, 14.0, "Character Name", 10.0 * PdfPageFormat.mm,
        top - 10.0 * PdfPageFormat.mm);
    g.drawString(font, 14.0, character.name, 60.0 * PdfPageFormat.mm,
        top - 10.0 * PdfPageFormat.mm);

    // Theme
    g.drawString(font, 14.0, "Theme", 10.0 * PdfPageFormat.mm,
        top - 20.0 * PdfPageFormat.mm);
    g.drawString(font, 14.0, character.getThemeName(), 60.0 * PdfPageFormat.mm,
        top - 20.0 * PdfPageFormat.mm);

    // Race
    g.drawString(font, 14.0, "Race", 10.0 * PdfPageFormat.mm,
        top - 30.0 * PdfPageFormat.mm);
    g.drawString(font, 14.0, character.getRaceName(), 60.0 * PdfPageFormat.mm,
        top - 30.0 * PdfPageFormat.mm);

    // Class
    g.drawString(font, 14.0, "Class", 10.0 * PdfPageFormat.mm,
        top - 40.0 * PdfPageFormat.mm);
    g.drawString(font, 14.0, character.getBaseClassName(),
        60.0 * PdfPageFormat.mm, top - 40.0 * PdfPageFormat.mm);

    return pdf;
  }
}
