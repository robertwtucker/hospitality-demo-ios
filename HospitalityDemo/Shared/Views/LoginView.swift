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
    guard let sdk = AdvantageSDK.sharedInstance() else {
      logger.error("Unable to accees shared instance of SDK")
      return
    }
    
    guard let identityProvider = await selectIdentityProvider(using: sdk) else {
      errorMessage = "Error selecting identity provider: Inspire Authentication not available."
      logger.error("\(errorMessage)")
      showError.toggle()
      return
    }
    logger.debug("Using identity provider: \(identityProvider.providerType!) (\(identityProvider.providerId!))")
    
    do {
      guard let sessionInfo = try await sdk.authenticationService.login(withCredentials: username, password: password, identityProvider: identityProvider) else {
        return }
      clearFormFields()
      userManager.currentSession = sessionInfo
    } catch {
      errorMessage = "Login error: \(error.localizedDescription)"
      logger.error("\(errorMessage)")
      showError.toggle()
    }
  }
  
  private func selectIdentityProvider(using sdk: AdvantageSDK, ofType: String = "InspireAuthentication" ) async -> IdentityProvider? {
    do {
      guard let providers = try await sdk.authenticationService.listAvailableIdentityProviders() else {
        return nil
      }
      for provider in providers {
        if provider.providerType == ofType {
          return provider
        }
      }
    } catch {
      logger.error("Advantage SDK returned an error getting list of identity providers: \(error.localizedDescription)")
    }
    return nil
  }
  
  private func clearFormFields() {
    username = ""
    password = ""
  }
}

#Preview {
  LoginView()
    .environment(UserManager.shared)
}
