//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct LoginView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(UserManager.self) private var userManager
  
  @SwiftUI.State private var username = ""
  @SwiftUI.State private var password = ""
  @SwiftUI.State private var showPassword = false
  @SwiftUI.State private var isLoggingIn = false
  @SwiftUI.State private var errorMessage = ""
  @SwiftUI.State private var showError = false
  
  @FocusState private var isUsernameFocused: Bool
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: LoginView.self))
  
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
      Text("Welcome Back")
        .font(.largeTitle)
        .bold()
      Text("Login Below")
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
      TextField("Username", text: $username, prompt: Text("Username"))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .focused($isUsernameFocused)
      HStack {
        Group {
          if showPassword {
            TextField("Password", text: $password, prompt: Text("Password"))
          } else {
            SecureField("Password", text: $password, prompt: Text("Password"))
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
        withAnimation {
          isLoggingIn = true
        }
        Task {
          await login()
          isLoggingIn = false
        }
      } label: {
        HStack {
          Spacer()
          if isLoggingIn {
            ProgressView()
          } else {
            Text("Log In")
          }
          Spacer()
        }
      }
      .disabled(isLoginDisabled)
    }
  }
  
  private func login() async {
    guard let sdk = AdvantageSDK.sharedInstance() else {
      logger.error("Unable to accees shared instance of SDK")
      return
    }
    
    guard let identityProvider = await selectIdentityProvider(sdk) else {
      errorMessage = "Error selecting identity provider: Inspire Authentication not available."
      logger.error("\(errorMessage)")
      showError.toggle()
      return
    }
    logger.debug("Using identity provider: \(identityProvider.providerType!) (\(identityProvider.providerId!))")
    
    if let sessionInfo = await loginWithCredentials(
      sdk,
      username: username,
      password: password,
      identityProvider: identityProvider
    ) {
      clearFormFields()
      userManager.currentSession = sessionInfo
    }
  }
  
  private func selectIdentityProvider(
    _ sdk: AdvantageSDK,
    providerType: String = "InspireAuthentication"
  ) async -> IdentityProvider? {
    return await withCheckedContinuation { continuation in
      sdk.authenticationService.listAvailableIdentityProviders { providers, error in
        if let error = error {
          errorMessage = "Error getting list of providers: \(error.localizedDescription)"
          logger.error("\(errorMessage)")
          showError.toggle()
          continuation.resume(returning: nil)
        } else {
          for provider in providers! {
            if provider.providerType == providerType {
              continuation.resume(returning: provider)
            }
          }
        }
      }
    }
  }
  
  private func loginWithCredentials(
    _ sdk: AdvantageSDK,
    username: String,
    password: String,
    identityProvider: IdentityProvider
  ) async -> SessionInfo? {
    return await withCheckedContinuation { continuation in
      sdk.authenticationService.login(
        withCredentials: username,
        password: password,
        identityProvider: identityProvider
      ) { (sessionInfo, error) in
        if let error = error {
          errorMessage = "Login error: \(error.localizedDescription)"
          logger.error("\(errorMessage)")
          showError.toggle()
          continuation.resume(returning: nil)
        } else {
          continuation.resume(returning: sessionInfo)
        }
      }
    }
  }
  
  private func clearFormFields() {
    username = ""
    password = ""
  }
}

#Preview {
  LoginView()
}
