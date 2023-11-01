//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import OSLog

struct LoginView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  @SwiftUI.State private var username = ""
  @SwiftUI.State private var password = ""
  @SwiftUI.State private var showPassword = false
  @SwiftUI.State private var isLoggingIn = false
  @SwiftUI.State private var errorMessage = ""
  @SwiftUI.State private var showError = false
  
  @FocusState private var isUsernameFocused: Bool
  
  private let logger = Logger(
    subsystem: K.Logging.bundleIdentifier,
    category: K.Logging.sdk)
  
  private var isLoginDisabled: Bool {
    [username, password].contains(where: \.isEmpty)
  }
  
  var body: some View {
    NavigationStack {
      Image("general/traveling")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
      Text("login.title")
        .font(.largeTitle)
        .bold()
      Text("login.cta")
        .font(.callout)
      Form {
        credentialsSection
        buttonSection
      }
      .onAppear {
        isUsernameFocused = true
      }
      .sheet(isPresented: $showError) {
        ErrorView(error: errorMessage)
          .presentationDetents([.medium, .large])
          .presentationDragIndicator(.visible)
      }
    }
    .interactiveDismissDisabled(true)
  }
  
  private var credentialsSection: some View {
    Section {
      TextField("login.username", text: $username, prompt: Text("login.username"))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .focused($isUsernameFocused)
      HStack {
        Group {
          if showPassword {
            TextField("login.password", text: $password, prompt: Text("login.password"))
          } else {
            SecureField("login.password", text: $password, prompt: Text("login.password"))
          }
        }
        Button {
          showPassword.toggle()
        } label: {
          Image(systemName: showPassword ? "eye.slash" : "eye")
        }
      }
    }
  }
  
  private var buttonSection: some View {
    Section {
      Button {
        Task {
          isLoggingIn = true
          await login()
          isLoggingIn = false
        }
      } label: {
        HStack {
          Spacer()
          if isLoggingIn {
            ProgressView()
          } else {
            Text("button.login")
          }
          Spacer()
        }
      }
      .disabled(isLoginDisabled)
    }
  }
  
  private func login() async {
    do {
      try await sdkModel.login(username: username, password: password)
      clearFormFields()
    } catch {
      errorMessage = "Login error: \(error.localizedDescription)"
      logger.error("\(errorMessage)")
      showError.toggle()
    }
  }
  
  private func clearFormFields() {
    username = ""
    password = ""
  }
}

#Preview {
  LoginView()
    .environment(AdvantageSdkModel())
}
