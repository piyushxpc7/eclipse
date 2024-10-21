import SwiftUI

struct PreferenceSelectionView: View {
    let preferences: [(String, String)] = [
        ("Thriller", "book.fill"),
        ("Murder", "cross.fill"),
        ("Romance", "heart.fill"),
        ("Sci-Fi", "star.fill"),
        ("Fantasy", "star.fill"),
        ("Mystery", "magnifyingglass"),
        ("Horror", "flame.fill"),
        ("Adventure", "leaf.fill"),
        ("Historical", "clock.fill"),
        ("Non-Fiction", "book.closed.fill")
    ]
    
    @State private var selectedPreferences: Set<String> = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Preferences!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .foregroundColor(.primary)
                .padding(.bottom, 50)
            
        
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(preferences, id: \.0) { preference in
                    PreferenceBubble(preference: preference.0, icon: preference.1, isSelected: selectedPreferences.contains(preference.0)) {
                        toggleSelection(for: preference.0)
                    }
                    .padding(.horizontal, 5)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
       
                print("Selected Preferences: \(selectedPreferences)")
            }) {
                Text("Start Reading")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#005C78"))
            .cornerRadius(10)
            .padding()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    private func toggleSelection(for preference: String) {
        if selectedPreferences.contains(preference) {
            selectedPreferences.remove(preference)
        } else {
            selectedPreferences.insert(preference)
        }
    }
}

struct PreferenceBubble: View {
    var preference: String
    var icon: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .white : .blue)
            Text(preference)
                .font(.subheadline)
                .foregroundColor(isSelected ? .white : .black)
                .padding(5)
        }
        .padding(10)
        .background(isSelected ? Color(hex: "#005C78") : Color.gray.opacity(0.2))
        .cornerRadius(12)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .shadow(color: isSelected ? Color.blue.opacity(0.4) : Color.clear, radius: 3, x: 0, y: 2)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    PreferenceSelectionView()
}
