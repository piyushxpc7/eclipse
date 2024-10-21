import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 60)
                .padding(.bottom, 30)

            Text("Please enter your email and password.")
                .font(.custom("SFProDisplay-Medium", size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)

            CustomTextField(placeholder: "Email", text: $email)
                .keyboardType(.emailAddress)
            CustomTextField(placeholder: "Password", text: $password, isSecure: true)

            Button(action: {}) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color(hex: "#005C78"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text("Don't have an account?")
                .font(.footnote)
                .foregroundColor(.gray)

            Button(action: {}) {
                Text("Create Account")
                    .font(.custom("SFProDisplay-Regular", size: 18))
                    .foregroundColor(Color(hex: "#005C78"))
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
            } else {
                TextField(placeholder, text: $text)
                    .padding()
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .font(.custom("SFProDisplay-Regular", size: 18))
    }
}



#Preview {
    LoginView()
}
