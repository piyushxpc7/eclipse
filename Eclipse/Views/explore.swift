import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    let genres = ["Crime", "Mystery", "Romance", "Science Fiction"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Discover")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, 10)
                    .padding(.horizontal)

                SearchBar(searchText: $searchText)

                BackgroundCard(title: "New Releases 📖", description: "Discover the latest additions to our collection.", color: Color.white.opacity(0.9)) {
                    NewReleasesView()
                }
                
                GenreSelectionView(genres: genres)
                    .padding(.leading, 15)

                BackgroundCard(title: "Swipe to Find the Perfect Book", description: "Swipe through books and find your perfect match. ❤️", color: Color.white.opacity(0.9)) {
                    SwipeCard(books: books)
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                FeaturedAuthorsView(authors: authors)
                    .padding(.leading, 14)

                BackgroundCard(title: "From Book to the Screen 🎬", description: "Spoiler Alert: The Book is ALWAYS better.", color: Color.white.opacity(0.6)) {
                    Booktofilm()
                }
                .padding(.bottom, 20)

                QuizPromptView()
                    .padding(.leading, 10)

                BackgroundCard(title: "Best Sellers 📚", description: "Discover the best-selling books in the app.", color: Color.white.opacity(0.9)) {
                    BestSellersView(books: books)
                }
                .padding(.top, 20)

                BackgroundCard(title: "Booker Prize 2024 🏆", description: "Explore the nominees and winners.", color: Color.white.opacity(0.4)) {
                    NewReleasesView()
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Explore")
        .padding(.bottom)
    }
}

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 10)

            TextField("Search Books...", text: $searchText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.leading, 5)
                .padding(.trailing, 10)
        }
        .padding()
    }
}

struct BackgroundCard<Content: View>: View {
    var title: String
    var description: String
    var color: Color
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            content()
                .padding(.top)
        }
        .padding()
        .background(color)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct NewReleasesView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(books, id: \.id) { book in
                    BookCard(book: book)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct Booktofilm: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(books, id: \.id) { book in
                    BookCard(book: book)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BestSellersView: View {
    var books: [Book]

    var body: some View {
        let rows = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .top, spacing: 10) {
                ForEach(books, id: \.id) { book in
                    VStack(spacing: 10) {
                        BookCard(book: book)
                            .frame(width: 150)
                    }
                    .padding(.vertical, 10)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct GenreSelectionView: View {
    var genres: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Browse Genres")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#005C78"))
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(genres, id: \.self) { genre in
                        GenreOptionButton(genre: genre)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 10)
    }
}

struct GenreOptionButton: View {
    var genre: String

    var body: some View {
        Text(genre)
            .fontWeight(.bold)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color(hex: "#005C78"))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
            )
    }
}

struct FeaturedAuthorsView: View {
    let authors: [Author]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Authors ✍🏽")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(authors, id: \.name) { author in
                        AuthorCardExplore(author: author)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .padding(.bottom)
    }
}

struct AuthorCardExplore: View {
    var author: Author

    var body: some View {
        VStack {
            Image(author.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 120)
                .cornerRadius(8)
                .clipped()
                .shadow(radius: 3)

            Text(author.name)
                .font(.headline)
                .foregroundColor(Color(hex: "#005C78"))
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

let authors: [Author] = [
    Author(name: "Jane Austen", bio: "An English novelist known for her novels about the British landed gentry at the end of the 18th century.", image: "AAA"),
    Author(name: "Mark Twain", bio: "An American writer known for his novels The Adventures of Tom Sawyer and Adventures of Huckleberry Finn.", image: "ss"),
    Author(name: "George Orwell", bio: "An English novelist famous for '1984' and 'Animal Farm'.", image: "george_orwell"),
    Author(name: "Virginia Woolf", bio: "An English writer, considered one of the foremost modernists of the twentieth century.", image: "virginia_woolf"),
    Author(name: "F. Scott Fitzgerald", bio: "An American novelist and short story writer, widely regarded as one of the greatest American writers of the 20th century.", image: "f_scott_fitzgerald")
]

struct FeatureCard: View {
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 2)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .frame(width: 150)
    }
}

struct QuizPromptView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "lightbulb.fill")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                Text("Not Sure What Book to Read?")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Text("Take a quick quiz to get personalized recommendations!")
                .font(.subheadline)
                .foregroundColor(.gray)

            NavigationLink(destination: QuizView()) {
                Text("Start Quiz")
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: 120)
                    .background(Color(hex: "#005C78"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .padding(20)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct QuizView: View {
    var body: some View {
        Text("Quiz goes here")
            .font(.largeTitle)
            .navigationTitle("Book Quiz")
    }
}

struct SwipeCard: View {
    var books: [Book]
    @State private var randomBooks: [Book] = []
    @State private var isAnimating = false

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                if randomBooks.indices.contains(0) {
                    VStack {
                        Image(randomBooks[0].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(-10))
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .onTapGesture {
                                navigateToSwipeScreen()
                            }
                        
                        Text(randomBooks[0].title)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                if randomBooks.indices.contains(1) {
                    VStack {
                        Image(randomBooks[1].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .onTapGesture {
                                navigateToSwipeScreen()
                            }
                        
                        Text(randomBooks[1].title)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                if randomBooks.indices.contains(2) {
                    VStack {
                        Image(randomBooks[2].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .rotationEffect(.degrees(10))
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .onTapGesture {
                                navigateToSwipeScreen()
                            }
                        
                        Text(randomBooks[2].title)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                getRandomBooks()
                startAnimation()
            }
        }
        .padding(.horizontal)
    }
    
    func startAnimation() {
        withAnimation(.easeInOut(duration: 1).repeatForever()) {
            isAnimating.toggle()
        }
    }

    func getRandomBooks() {
        if books.count >= 3 {
            randomBooks = [books[0], books[1], books[2]]
        }
    }
    
    func navigateToSwipeScreen() {
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
