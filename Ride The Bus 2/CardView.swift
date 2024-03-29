import SwiftUI

struct CardView: View {
    let stack: Stack<Card>
    @State private var leaveCardView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .ignoresSafeArea(.all)
            
            HStack {
                Text("")
                    .multilineTextAlignment(.leading)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .font(.system(size: 40.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.yellow)
                    .rotationEffect(.degrees(90))
                    .frame(width: 160.0, height: 200.0)
            
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.yellow)
                        .font(.title)
                }
                .padding(.trailing, 40.0)
                
            }
            .padding(.horizontal)
            .padding(.bottom, 660.0)
            VStack{
                Text("Cards In Stack: \(stack.count)")
                    .padding(.top, 280.0)
                    .frame(height: 300.0)
                    .rotationEffect(.degrees(90))
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .font(.system(size: 30.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.yellow)
                    .multilineTextAlignment(.center)
                    
            }
            VStack{
                Text("Black Cards: \(countBlack()) Red Cards: \(countRed())")
                    .foregroundColor(.yellow)
                    .padding(.bottom, 300.0)
                    .rotationEffect(.degrees(90))
                    .font(.system(size: 30))
            }
            VStack {
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(stack.toArray()) { card in
                            VStack {
                                Image("\(card.rank)_of_\(card.suit)")
                                    .resizable()
                                    .frame(width: 150.0, height: 200.0)
                                    .rotationEffect(.degrees(90))
                            }
                            .frame(width: 200.0, height: 160.0)
                        }
                    }
                    .padding(.top, 100.0)
                }
            }
        }
        .navigationBarHidden(true)
    }
    func countBlack() -> Int {
          
          return stack.toArray().filter { $0.suit == "spades" || $0.suit == "clubs" }.count
      }
    func countRed() -> Int {
          
          return stack.toArray().filter { $0.suit == "hearts" || $0.suit == "diamonds" }.count
      }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        var stack = Stack<Card>()
        stack.push(Card(suit: "hearts", rank: "ace"))
        stack.push(Card(suit: "hearts", rank: "ace"))
        stack.push(Card(suit: "hearts", rank: "ace"))
        stack.push(Card(suit: "hearts", rank: "ace"))
        stack.push(Card(suit: "hearts", rank: "ace"))
        return CardView(stack: stack)
    }
}

