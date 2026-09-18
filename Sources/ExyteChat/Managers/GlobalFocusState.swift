//
//  Created by Alex.M on 23.06.2022.
//

import Foundation

public final class GlobalFocusState: ObservableObject {
    public init() {}
    @Published public var focus: Focusable?
}
