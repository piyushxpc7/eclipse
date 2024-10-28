import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("userpic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    Text("John Doe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()

                List {
                    Section(header: Text("Account")) {
                        NavigationLink("Edit Profile", destination: ContentView())
                        NavigationLink("Notifications", destination: ContentView())
                        NavigationLink("Book Support", destination: ContentView())
                        NavigationLink("Security", destination: ContentView())
                    }
                    
                    Section(header: Text("Actions")) {
                        NavigationLink("Report a Problem", destination: ContentView())
                        NavigationLink("Add Account", destination: ContentView())
                        Button("Log Out") {
                            
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                Spacer()
            }
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    UserProfileView()
}
