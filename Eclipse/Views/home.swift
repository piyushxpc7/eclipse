import SwiftUI

struct Home: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    searchBar
                    VStack(alignment: .leading) {
                        Text("Books of the Day")
                            .font(.title)
                            .fontWeight(.bold)
                            
                        booksOfTheDaySection
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Your Favourites")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        favoritesSection
                    }
                    
                    RecentlyViewed(books: recentlyViewedBooks)
                    topRentersSection
                }
                .padding()
                .background(Color(hex: "#F7F7F7").ignoresSafeArea())
                .navigationBarHidden(true)
            }
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 24))
                    .foregroundColor(Color(hex: "#005C78"))
            }
            .padding(.leading, 10)
        }
        .padding()
    }

    private var favoritesSection: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 0) {
            ForEach(favoriteGenres, id: \.self) { genre in
                GenreCard(genre: genre)
            }
        }
        .padding(.horizontal, 15)
    }

    private var booksOfTheDaySection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#005C78").opacity(0.8), Color(hex: "#005C78").opacity(0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(books, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookCard(book: book)
                                .frame(width: 150, height: 200)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
        }
    }

    private var topRentersSection: some View {
        Section(header: sectionHeader(title: "Top Renters")) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(topRenters, id: \.id) { renter in
                        RenterCard(renter: renter)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color(hex: "#005C78"))
            .padding(.leading)
    }
}

struct GenreCard: View {
    var genre: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(genre)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 90)
                .clipped()
                .blur(radius: 0.4)

            Text(genre)
                .font(.system(size: 14))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10, corners: [.topLeft, .topRight])
        }
        .frame(width: 150, height: 120)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = []

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct BookCard: View {
    var book: Book

    var body: some View {
        VStack {
            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .cornerRadius(8)
                .clipped()

            Text(book.title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .padding(.horizontal, 5)
                .frame(maxWidth: 100)
                .background(Material.thick)
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}

struct RenterCard: View {
    var renter: Renter

    var body: some View {
        VStack {
            Image(renter.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color(hex: "#005C78"), lineWidth: 4)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

            Text(renter.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .frame(width: 80)
        }
        .padding(10)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetailView: View {
    var book: Book

    var body: some View {
        Text(book.title)
            .font(.largeTitle)
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct Book: Identifiable {
    var id: UUID
    var title: String
    var imageName: String
}

struct Renter: Identifiable {
    var id: UUID
    var name: String
    var imageName: String
}

let books = [
    Book(id: UUID(), title: "The Great Gatsby", imageName: "x"),
    Book(id: UUID(), title: "1984", imageName: "1984"),
    Book(id: UUID(), title: "To Kill a Mockingbird", imageName: "y"),
    Book(id: UUID(), title: "Pride and Prejudice", imageName: "pride_and_prejudice"),
    Book(id: UUID(), title: "The Catcher in the Rye", imageName: "catcher_in_the_rye"),
    Book(id: UUID(), title: "Moby Dick", imageName: "moby_dick"),
    Book(id: UUID(), title: "War and Peace", imageName: "war_and_peace"),
    Book(id: UUID(), title: "The Odyssey", imageName: "the_odyssey"),
    Book(id: UUID(), title: "Brave New World", imageName: "brave_new_world"),
    Book(id: UUID(), title: "The Picture of Dorian Gray", imageName: "dorian_gray"),
    Book(id: UUID(), title: "The Hobbit", imageName: "the_hobbit"),
    Book(id: UUID(), title: "Fahrenheit 451", imageName: "fahrenheit_451")
]

let favoriteGenres = [
    "Mystery & Thriller",
    "J.K. Rowling",
    "Dystopian",
    "Sarah J."
]

let topRenters = [
    Renter(id: UUID(), name: "Alice Johnson", imageName: "b"),
    Renter(id: UUID(), name: "Bob Smith", imageName: "a"),
    Renter(id: UUID(), name: "Diana Prince", imageName: "f"),
    Renter(id: UUID(), name: "Charlie Brown", imageName: "c")
]

struct RecentlyViewed: View {
    var books: [Book]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Viewed")
                .font(.headline)
                .padding(.horizontal)

            Text("Check out the books you've recently viewed.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(books, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookCard(book: book)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.vertical)
    }
}

let recentlyViewedBooks = [
    Book(id: UUID(), title: "The Great Gatsby", imageName: "x"),
    Book(id: UUID(), title: "1984", imageName: "1984"),
    Book(id: UUID(), title: "To Kill a Mockingbird", imageName: "y")
]

#Preview {
    Home()
}
