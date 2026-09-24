//
//  MuxSpur.swift
//  MUX-Abspaltung (Schritt 77/78)
//

import Foundation

/// MUX: Messspur fuer die Fokusfrage (B21). Schreibt in denselben Ordner wie die App
/// (`tmp/b21/wischen.txt`), damit sich am echten Geraet die Reihenfolge nachvollziehen
/// laesst: wer setzt den Fokus, wer raeumt ihn ab, und geht die Tastatur danach auf?
/// Nur im Debug-Bau — im Release ist die Funktion leer.
///
/// Schritt 78: aus `ChatView.swift` hierher gezogen. Dort stand sie VOR dem Dateikopf
/// und damit an einer Stelle, an der niemand sie sucht.
func muxSpur(_ zeile: String) {
    #if DEBUG
    let ordner = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("b21", isDirectory: true)
    try? FileManager.default.createDirectory(at: ordner, withIntermediateDirectories: true)
    let datei = ordner.appendingPathComponent("wischen.txt")
    let text = "\(Date().timeIntervalSince1970) BIBLIOTHEK \(zeile)\n"
    if let daten = text.data(using: .utf8) {
        if let griff = try? FileHandle(forWritingTo: datei) {
            defer { try? griff.close() }
            _ = try? griff.seekToEnd()
            try? griff.write(contentsOf: daten)
        } else {
            try? daten.write(to: datei)
        }
    }
    #endif
}
