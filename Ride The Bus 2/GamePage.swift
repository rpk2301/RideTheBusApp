import SwiftUI

struct GamePage: View {
    let suits = ["clubs", "diamonds", "hearts", "spades"]
    let ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king","ace"]
    
    @State private var currentIndex = 0
    @State private var nextIndex = 1
    @State private var deckIndex = 0
    @State private var higherGuess = false
    @State private var lowerGuess = false
    @State private var bus: [Stack<Card>]
    @State private var FirstStackTop: Card
    @State private var SecondStackTop: Card
    @State private var ThirdStackTop: Card
    @State private var FourthStackTop: Card
    @State private var isGuessing: Bool = true
    @State private var isGlowing: [Bool] = [false, false, false, false]
    @State private var secondStackFirstFlop: Bool = false
    @State private var thirdStackFirstFlip: Bool = false
    @State private var fourthStackFirstFlip: Bool = false
    

    private var deck: [Card]
    
    init() {
        var shuffledDeck = [Card]()
        for suit in suits {
            for rank in ranks {
                let card = Card(suit: suit, rank: rank)
                shuffledDeck.append(card)
            }
        }
        self.deck = shuffledDeck.shuffled()
        var bus = [Stack<Card>]()
        
        
        for i in 0..<4 {
            var stack = Stack<Card>()
            stack.push(deck[i])
            bus.append(stack)
            deck.remove(at: 0)
        }
        for  card in deck {
            print(card.rank+card.suit)
        }
        self.bus = bus
        FirstStackTop = bus[0].peek()!
        SecondStackTop = bus[1].peek()!
        ThirdStackTop = bus[2].peek()!
        FourthStackTop = bus[3].peek()!
       
       
    }
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .ignoresSafeArea(.all)
                HStack{
                    if(currentIndex == 0 || currentIndex == 1)
                    {
                        VStack{
                            Button(action: {
                                higherGuess = true
                                isGuessing=false
                                checkGuess()
                            }, label: {
                                Text("Higher")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 200, height: 50)
                                
                                    .foregroundColor(.yellow)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.8, green: 0.6, blue: 0.2), //
                                                Color(red: 0.1, green: 0.4, blue: 0.2)
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                                    .rotationEffect(.degrees(90))
                            })
                            .padding(.trailing, 50.0)
                            .frame(width: 65.0, height: 205.0)
                            Button(action: {
                                lowerGuess = true
                                isGuessing = false
                                checkGuess()
                            }, label: {
                                Text("Lower")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 200, height: 50)
                                    .foregroundColor(.yellow)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.8, green: 0.6, blue: 0.2),
                                                Color(red: 0.1, green: 0.4, blue: 0.2)
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                                    .rotationEffect(.degrees(90))
                            })
                            .padding(.trailing, 50.0)
                            .frame(width: 65.0, height: 205.0)
                        }
                    }
                    else if(currentIndex == 2 || currentIndex == 3){
                        VStack{
                            Button(action: {
                                higherGuess = true
                                isGuessing=false
                                checkGuess()
                            }, label: {
                                Text("Red")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 200, height: 50)
                                
                                    .foregroundColor(.yellow)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.8, green: 0.6, blue: 0.2), //
                                                Color(red: 0.1, green: 0.4, blue: 0.2)
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                                    .rotationEffect(.degrees(90))
                            })
                            .padding(.trailing, 50.0)
                            .frame(width: 65.0, height: 205.0)
                            Button(action: {
                                lowerGuess = true
                                isGuessing = false
                                checkGuess()
                            }, label: {
                                Text("Black")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 200, height: 50)
                                    .foregroundColor(.yellow)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.8, green: 0.6, blue: 0.2),
                                                Color(red: 0.1, green: 0.4, blue: 0.2)
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                                    .rotationEffect(.degrees(90))
                            })
                            .padding(.trailing, 50.0)
                            .frame(width: 65.0, height: 205.0)
                        }
                        
                    }
                    VStack() {
                        
                        HStack{
                            let rank0 = FirstStackTop.rank
                            let suit0 = FirstStackTop.suit
                            let imageName = "\(rank0)_of_\(suit0)"
                            Image(imageName)
                                .frame(width: 180.0, height: 125.0)
                                .rotationEffect(.degrees(90))
                                .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.yellow, lineWidth: 10)
                                        .blur(radius: 5)
                                        .opacity(self.isGlowing[currentIndex] && currentIndex == 0 ? 1.0 : 0.0)
                                )
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                        self.isGlowing[currentIndex] = true
                                    }
                                }
                            
                        }
                        
                        HStack{
                            let rank1 = SecondStackTop.rank
                            let suit1 = SecondStackTop.suit
                            let imageName = "\(rank1)_of_\(suit1)"
                            if(secondStackFirstFlop){
                                Image(imageName)
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && currentIndex == 1 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            else{
                                Image(imageName)
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && currentIndex == 1 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            
                        }
                        HStack{
                            Image("2B")
                                .frame(width: 125.0, height: 200.0)
                                .scaleEffect(CGSize(width: 0.75, height: 0.75))
                        }
                        HStack{
                            
                            let rank2 = ThirdStackTop.rank
                            let suit2 = ThirdStackTop.suit
                            let imageName = "\(rank2)_of_\(suit2)"
                            if(thirdStackFirstFlip){
                                Image(imageName)
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && self.currentIndex == 2 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            else{
                                Image("2B")
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && self.currentIndex == 2 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            
                            
                        }
                        HStack{
                            
                            let rank3 = FourthStackTop.rank
                            let suit3 = FourthStackTop.suit
                            let imageName = "\(rank3)_of_\(suit3)"
                            if(fourthStackFirstFlip){
                                Image(imageName)
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && self.currentIndex == 3 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            else{
                                Image("2B")
                                    .frame(width: 180.0, height: 125.0)
                                    .rotationEffect(.degrees(90))
                                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 10)
                                            .blur(radius: 5)
                                            .opacity(self.isGlowing[currentIndex] && self.currentIndex == 3 ? 1.0 : 0.0)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.isGlowing[currentIndex] = true
                                        }
                                    }
                            }
                            
                        }
                        
                    }
                    HStack {
                        VStack {
                            Text("Deck Size: \(deck.count-deckIndex)")
                                .frame(maxWidth: .infinity, maxHeight: nil)
                                .frame(width: 175.0)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .font(.system(size: 22))
                                .fontWeight(.medium)
                                .foregroundColor(Color.yellow)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 30.0, height: 300.0)
                        .rotationEffect(.degrees(90))
                    }
                    
                }
            
            
        }
    }
    
    func checkGuess() {
        let TopPileCard = bus[currentIndex].peek()
        DrawCard()
 
        //if the
        if (deck[deckIndex].numericValue > TopPileCard?.numericValue ?? 0 && higherGuess) ||
            (deck[deckIndex].numericValue < TopPileCard?.numericValue ?? 0 && lowerGuess) {
            currentIndex = nextIndex
            nextIndex = nextIndex+1
            if(currentIndex == 1 ){
                secondStackFirstFlop = true
            }
            else if currentIndex == 2 {
                  thirdStackFirstFlip = true
              }
            else if currentIndex == 3 {
                fourthStackFirstFlip = true
            }
            print("Correct!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
            print(currentIndex)
        } else {
            if(currentIndex > 0){
                currentIndex = currentIndex-1
                nextIndex=nextIndex-1
            }
            print("Incorrect!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
            print(currentIndex)
        }
        
        
        higherGuess = false
        lowerGuess = false
    }
    
    func DrawCard(){
        if(currentIndex == 0 ){
            bus[0].push(deck[deckIndex])
            FirstStackTop = deck[deckIndex]
            
        }
        else if(currentIndex == 1){
            bus[1].push(deck[deckIndex])
            SecondStackTop = deck[deckIndex]
            
        }
        else if(currentIndex == 2){
            bus[2].push(deck[deckIndex])
            ThirdStackTop = deck[deckIndex]
            
        }
        else if(currentIndex == 3){
            bus[3].push(deck[deckIndex])
            FourthStackTop = deck[deckIndex]
            
        }
    }
    
    

    
    struct Card {
        let suit: String
        let rank: String
        
        // Compute numeric value for comparison
        var numericValue: Int {
            switch rank {
            case "jack": return 11
            case "queen": return 12
            case "king": return 13
            case "ace": return 14
            default:
                if let value = Int(rank) {
                    return value
                } else {
                    return 0
                }
            }
        }
    }
}


struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        GamePage()
    }
}


