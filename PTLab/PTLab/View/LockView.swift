import SwiftUI
import LocalAuthentication

struct LockView: View {
    @State var isUnlocked: Bool
    
    var body: some View {
        Image(systemName: isUnlocked ? "lock.open.fill" : "lock.fill")
    }
}

