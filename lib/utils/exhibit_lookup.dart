import '../data/mock_data.dart';
import '../models/heritage_place.dart';

class ExhibitMatch {
  final Exhibit exhibit;
  final HeritagePlace place;

  const ExhibitMatch({required this.exhibit, required this.place});
}

/// Resolves a scanned QR payload to an exhibit in mock data.
class ExhibitLookup {
  static ExhibitMatch? byQrCode(String raw) {
    final code = raw.trim().toUpperCase();
    if (code.isEmpty) return null;

    for (final place in MockData.heritagePlaces) {
      for (final exhibit in place.exhibits) {
        final qr = exhibit.qrCode?.toUpperCase();
        if (qr == null) continue;
        if (code == qr || code.contains(qr) || qr.contains(code)) {
          return ExhibitMatch(exhibit: exhibit, place: place);
        }
      }
    }
    return null;
  }

  static ExhibitMatch? byExhibitId(String id) {
    for (final place in MockData.heritagePlaces) {
      for (final exhibit in place.exhibits) {
        if (exhibit.id == id) {
          return ExhibitMatch(exhibit: exhibit, place: place);
        }
      }
    }
    return null;
  }
}
