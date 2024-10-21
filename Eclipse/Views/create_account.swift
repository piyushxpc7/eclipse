import SwiftUI

struct create: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var birthdate: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Hey there!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 30)

            Text("Enter your information to get started.")
                .font(.custom("SFProDisplay-Medium", size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)

            CustomTextField(placeholder: "Name", text: $name)
            CustomTextField(placeholder: "Email", text: $email)
                .keyboardType(.emailAddress)
            CustomTextField(placeholder: "Birthdate (MM/DD/YYYY)", text: $birthdate)
            CustomTextField(placeholder: "Password", text: $password, isSecure: true)
            
            Button(action: {
            }) {
                Text("Create Account")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color(hex: "#005C78"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Text("Already have an account?")
            Button(action: {
            }) {
                Text("Log in")
                    .font(.custom("SFProDisplay-Regular", size: 18))
                    .foregroundColor(Color(hex: "#005C78"))
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        create()
    }
}

