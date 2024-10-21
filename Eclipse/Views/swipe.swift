import SwiftUI

struct scene: View {
    @State private var showBottomSheet = false
    @State private var selectedBook: CustomBook? = nil
    @State private var currentIndex = 0

    let books: [CustomBook] = [
        CustomBook(title: "The Enchanted Library", author: "Eleanor Smith", coverImageName: "The Enchanted Library", shortDescription: "An adventurous journey through a magical world hidden in books.", longDescription: "In 'The Enchanted Library,' Eleanor Smith takes you through a world where every book holds a magical universe waiting to be explored.", genres: ["Fantasy", "Adventure", "Magic"]),
        CustomBook(title: "Ocean's Whisper", author: "James Parker", coverImageName: "Ocean's Whisper", shortDescription: "A thrilling dive into the mysteries of the deep ocean.", longDescription: "James Parker's 'Ocean's Whisper' takes readers on a mysterious and dangerous underwater adventure.", genres: ["Thriller", "Adventure"]),
        CustomBook(title: "Stardust Dreams", author: "Clara Reed", coverImageName: "Stardust_Dreams", shortDescription: "Exploring the beauty of the cosmos.", longDescription: "In 'Stardust Dreams,' Clara Reed explores space travel and human curiosity about the stars.", genres: ["Sci-Fi", "Drama"])
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(hex: "#005C78").opacity(0.7),
                Color(hex: "#005C78").opacity(0.3)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Find Your Book Match")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "person.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                                
                Spacer()
                
                CustomBookCardView(book: books[currentIndex])
                    
                    .frame(width: 380, height: 600)
                    .padding(.vertical)
                
                Spacer()
            }
            .sheet(isPresented: $showBottomSheet, content: {
                if let book = selectedBook {
                    CustomBookDetailSheet(book: book)
                }
            })
        }
    }
}

struct CustomBookCardView: View {
    var book: CustomBook
    
    var body: some View {
        VStack {
            Text(book.title)
                .font(.title)
                .bold()
                .padding(.top)
                .foregroundColor(Color(hex: "#005C78"))
            
            Image(book.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 420)
                .clipped()
                .cornerRadius(20)
            
            Text("by \(book.author)")
                .italic()
                .foregroundColor(.gray)
            
            Text(book.shortDescription)
                .font(.body)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 2)
            
            HStack {
                ForEach(book.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.caption)
                        .padding(5)
                        .background(Color(hex: "#005C78").opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct CustomBookDetailSheet: View {
    var book: CustomBook
    
    var body: some View {
        VStack(spacing: 20) {
            Image(book.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 150)
                .clipped()
                .cornerRadius(15)
            
            Text(book.title)
                .font(.title)
                .bold()
                .foregroundColor(Color(hex: "#005C78"))
            
            Text("by \(book.author)")
                .italic()
                .foregroundColor(.gray)
            
            Text(book.longDescription)
                .font(.body)
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

struct CustomBook {
    var title: String
    var author: String
    var coverImageName: String
    var shortDescription: String
    var longDescription: String
    var genres: [String]
}

struct SwipeViewPreviews: PreviewProvider {
    static var previews: some View {
        scene()
    }
}
