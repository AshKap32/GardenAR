//
//  RegisterView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import SwiftUI

struct RegisterView: View {
    @Binding var displayLogin: Bool
    
    func validate() -> Bool {
        // to do: hook this up to the backend
        return true
    }
    
    func register() {
        if validate() {
            // to do: hook this up to the backend
        } else {
            // to do: display an error message
        }
    }
    
    func toggle() {
        displayLogin.toggle()
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    RegisterView(displayLogin: .constant(false))
}
