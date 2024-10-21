import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Eclipse")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .padding(.bottom, 50)

            OnboardingCard(
                title: "Personalized Recommendations",
                description: "Discover tailored suggestions based on your preferences and interests.",
                imageName: "star.fill"
            )

            OnboardingCard(
                title: "Rent from Near You",
                description: "You can now rent all your favorite books from those who live less than 5km from you.",
                imageName: "house.fill"
            )

            Spacer()

            Button(action: {}) {
                Text("Get Started >>>")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#005C78"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct OnboardingCard: View {
    var title: String
    var description: String
    var imageName: String

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(hex: "#005C78"))
                .padding(.top)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
