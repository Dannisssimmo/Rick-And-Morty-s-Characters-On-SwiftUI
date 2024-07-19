import SwiftUI

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .frame(width: 85.0, height: 65.0)
                    
                    
                case .failure(_):
                    Color.red
                        .frame(width: 85.0, height: 65.0)
                case .empty:
                    ProgressView()
                default:
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name).bold()
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                HStack {
                    Text(character.status.capitalized).bold()
                        .foregroundColor(colorStatus[character.status])
                    Text("•").bold()
                    Text(character.species).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                }
                
                
                Text(character.gender)
            }
            .font(.subheadline)
            Spacer()
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.082, green: 0.082, blue: 0.082))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding(.horizontal)
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: exampleCharacter)
    }
}
