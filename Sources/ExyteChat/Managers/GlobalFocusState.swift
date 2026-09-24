//
//  Created by Alex.M on 07.07.2022.
//

import Foundation

public final class GlobalFocusState: ObservableObject {
    public init() {}

    /// MUX (Schritt 78): `didSet` schreibt JEDE Zuweisung in die Messspur — auch eine,
    /// die den Wert nicht aendert. Genau darauf kommt es an: SwiftUIs `onChange(of:)`
    /// feuert nur bei echter Aenderung, eine Zuweisung „gleicher Wert auf gleichen Wert"
    /// bleibt also folgenlos. Die Spur zeigt damit den Unterschied zwischen
    /// „Fokus wurde angefordert" und „Fokus hat sich wirklich bewegt".
    @Published public var focus: Focusable? {
        didSet {
            muxSpur("globalFocus alt=\(GlobalFocusState.beschreibung(oldValue)) neu=\(GlobalFocusState.beschreibung(focus))")
        }
    }

    private static func beschreibung(_ wert: Focusable?) -> String {
        switch wert {
        case .none: return "nil"
        case .some(.uuid(let id)): return id.uuidString.prefix(8).lowercased()
        }
    }
}
