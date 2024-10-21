import SwiftUI

struct Author: Identifiable {
    var id = UUID()
    var name: String
    var bio: String
    var image: String
}

struct AuthorsView: View {
    @State private var searchText: String = ""
    let authors: [Author] = [
        Author(name: "Jane Austen", bio: "An English novelist known for her novels about the British landed gentry at the end of the 18th century.", image: "AAA"),
        Author(name: "Mark Twain", bio: "An American writer known for his novels The Adventures of Tom Sawyer and Adventures of Huckleberry Finn.", image: "ss"),
        Author(name: "George Orwell", bio: "An English novelist famous for '1984' and 'Animal Farm'.", image: "george_orwell"),
        Author(name: "Virginia Woolf", bio: "An English writer, considered one of the foremost modernists of the twentieth century.", image: "virginia_woolf"),
        Author(name: "F. Scott Fitzgerald", bio: "An American novelist and short story writer, widely regarded as one of the greatest American writers of the 20th century.", image: "f_scott_fitzgerald")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Search authors...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Text("These are the authors you may like.")
                        .padding(.leading, 20)
                        .font(.custom("SFProDisplay-Medium", size: 25))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(authors) { author in
                        AuthorCard(author: author)
                    }
                    
                    ForEach(authors.shuffled().prefix(3)) { author in
                        AuthorCard(author: author)
                    }
                }
                .padding()
            }
            .navigationTitle("Authors")
        }
    }
}

struct AuthorCard: View {
    var author: Author
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(author.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
            
            Text(author.name)
                .font(.headline)
                .padding(.top, 10)
            
            Text(author.bio)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            Button(action: {
                print("Followed \(author.name)")
            }) {
                Text("Follow")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#005C78"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    AuthorsView()
}
