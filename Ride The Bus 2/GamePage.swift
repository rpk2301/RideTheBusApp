import SwiftUI
import UIKit

struct GamePage: View {
    let suits = ["clubs", "diamonds", "hearts", "spades"]
    let ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king","ace"]
    
    @State private var currentIndex = 0
    @State private var nextIndex = 1
    @State private var deckIndex = 4
    @State private var score = 0
    @State private var higherGuess = false
    @State private var lowerGuess = false
    @State private var redGuess = false
    @State private var blackGuess = false
    @State private var spadeGuess = false
    @State private var clubGuess = false
    @State private var heartGuess = false
    @State private var diamondGuess = false
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
    @State private var isCardViewPresented = false
    @State private var didWin = false
    @State private var goHome = false
    
    
    private var deck: [Card]
    
    
    init() {
      
        var shuffledDecks = [[Card]]()

        
        for _ in 0..<20 {
            var deck = [Card]()
            
            // Create a deck of 52 cards
            for suit in suits {
                for rank in ranks {
                    let card = Card(suit: suit, rank: rank)
                    deck.append(card)
                }
            }
            
        
            deck.shuffle()
            
          
            shuffledDecks.append(deck)
        }

      
        let concatenatedDeck = shuffledDecks.flatMap { $0 }

        // Ensure the total count is still 1040
        self.deck = concatenatedDeck
        
        
        
        var bus = [Stack<Card>]()
        
        
        for i in 0..<4 {
            var stack = Stack<Card>()
            stack.push(deck[i])
            bus.append(stack)
            }
        print(deck.count)
        for i in 0..<54{
            print (deck[i].rank+deck[i].suit)
        }
        self.bus = bus
        FirstStackTop = bus[0].peek()!
        SecondStackTop = bus[1].peek()!
        ThirdStackTop = bus[2].peek()!
        FourthStackTop = bus[3].peek()!
        
    }
    
    
    
    
    var body: some View {
        if(isCardViewPresented){
            CardView(stack: bus[0])
        }
        else if(didWin){
            WinSplashView(score: score)
        }
        else if(deckIndex>1000){
            WinSplashView(score: 1001)
        }
        else if(goHome){
            ContentView()
        }
        else{
            NavigationView{
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
                                        .frame(width: 150, height: 50)
                                    
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
                                        .frame(width: 150, height: 50)
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
                        else if(currentIndex == 2){
                            VStack{
                                Button(action: {
                                    redGuess = true
                                    isGuessing=false
                                    checkColor()
                                }, label: {
                                    Text("Red")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 150, height: 50)
                                    
                                        .foregroundColor(.yellow)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.9, green: 0.3, blue: 0.3), // Dark Red
                                                    Color(red: 0.2, green: 0.0, blue: 0.0) // Black
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
                                    blackGuess = true
                                    isGuessing = false
                                    checkColor()
                                }, label: {
                                    Text("Black")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 150, height: 50)
                                        .foregroundColor(.white)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.0, green: 0.0, blue: 0.0), // Whitish color
                                                    Color(red: 0.9, green: 0.9, blue: 0.9) // Black
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
                        else if(currentIndex == 3){
                            VStack{
                                Button(action: {
                                    heartGuess = true
                                    isGuessing=false
                                    checkSuit()
                                }, label: {
                                    Text("Hearts")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 100, height: 50)
                                    
                                        .foregroundColor(.yellow)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.9, green: 0.3, blue: 0.3), // Dark Red
                                                    Color(red: 0.2, green: 0.0, blue: 0.0) // Black
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
                                .frame(width: 65.0, height: 100.0)
                                Button(action: {
                                    diamondGuess = true
                                    isGuessing = false
                                    checkSuit()
                                }, label: {
                                    Text("Diamonds")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 120, height: 50)
                                        .foregroundColor(.yellow)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.9, green: 0.3, blue: 0.3), // Dark Red
                                                    Color(red: 0.2, green: 0.0, blue: 0.0) // Black
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
                                .frame(width: 65.0, height: 115.0)
                                Button(action: {
                                    spadeGuess = true
                                    isGuessing=false
                                    checkSuit()
                                }, label: {
                                    Text("Spades")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 100, height: 50)
                                    
                                        .foregroundColor(.white)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.0, green: 0.0, blue: 0.0), // Whitish color
                                                    Color(red: 0.9, green: 0.9, blue: 0.9) // Black
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
                                .frame(width: 65.0, height: 100.0)
                                Button(action: {
                                    clubGuess = true
                                    isGuessing=false
                                    checkSuit()
                                }, label: {
                                    Text("Clubs")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .bold()
                                        .frame(width: 100, height: 50)
                                    
                                        .foregroundColor(.white)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.0, green: 0.0, blue: 0.0), // Whitish color
                                                    Color(red: 0.9, green: 0.9, blue: 0.9) // Black
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
                                .frame(width: 65.0, height: 100.0)
                            }
                        }
                        VStack() {
                            NavigationLink(destination: CardView(stack: bus[0])){
                                HStack{
                                    let rank0 = FirstStackTop.rank
                                    let suit0 = FirstStackTop.suit
                                    let imageName = "\(rank0)_of_\(suit0)"
                                    
                                    
                                    Image(imageName)
                                        .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                                    .rotationEffect(.degrees(90))
                                                    .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.yellow, lineWidth: UIScreen.main.bounds.height < 667 ? 5 : 10)
                                                            .blur(radius: 5)
                                                .opacity(self.isGlowing[currentIndex] && currentIndex == 0 ? 1.0 : 0.0)
                                        )
                                        .onAppear {
                                            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                                self.isGlowing[currentIndex] = true
                                            }
                                        }
                                    
                                    
                                }
                            }.navigationBarBackButtonHidden()
                            
                            NavigationLink(destination: CardView(stack: bus[1])){
                                HStack{
                                    
                                    let rank1 = SecondStackTop.rank
                                    let suit1 = SecondStackTop.suit
                                    let imageName = "\(rank1)_of_\(suit1)"
                                    if(secondStackFirstFlop){
                                        HStack {
                                            let rank1 = SecondStackTop.rank
                                            let suit1 = SecondStackTop.suit
                                            let imageName = "\(rank1)_of_\(suit1)"
                                            Image(imageName)
                                                .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                                .rotationEffect(.degrees(90))
                                                .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                                    else{
                                        Image(imageName)
                                            .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                            .rotationEffect(.degrees(90))
                                            .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                            }
                            HStack{
                                Image("2B")
                                    .frame(width: UIScreen.main.bounds.height < 737 ? 80.0 : 125.0, height: UIScreen.main.bounds.height < 737 ? 165.0 : 200.0)
                                .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))                            }
                            NavigationLink(destination: CardView(stack: bus[2])){
                                HStack{
                                    
                                    let rank2 = ThirdStackTop.rank
                                    let suit2 = ThirdStackTop.suit
                                    let imageName = "\(rank2)_of_\(suit2)"
                                    if(thirdStackFirstFlip){
                                        Image(imageName)
                                            .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                            .rotationEffect(.degrees(90))
                                            .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                                            .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                            .rotationEffect(.degrees(90))
                                            .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                            }
                            NavigationLink(destination: CardView(stack: bus[3])){
                                HStack{
                                    
                                    let rank3 = FourthStackTop.rank
                                    let suit3 = FourthStackTop.suit
                                    let imageName = "\(rank3)_of_\(suit3)"
                                    if(fourthStackFirstFlip){
                                        Image(imageName)
                                            .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                            .rotationEffect(.degrees(90))
                                            .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                                            .frame(width: UIScreen.main.bounds.height < 737 ? 145.0 : 180.0, height: UIScreen.main.bounds.height < 737 ? 100.0 : 125.0)
                                            .rotationEffect(.degrees(90))
                                            .scaleEffect(UIScreen.main.bounds.height < 737 ? CGSize(width: 0.6, height: 0.6) : CGSize(width: 0.75, height: 0.75))
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
                            
                        }
                        HStack {
                            VStack {
                                if(countDeck()>=1){
                                    Text("Score: \(countDeck())")
                                        .frame(maxWidth: .infinity, maxHeight: nil)
                                        .frame(width: 175.0)
                                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                        .font(.system(size: 30))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.yellow)
                                        .multilineTextAlignment(.center)
                                    Button(action: {
                                        goHome=true
                                    }) {
                                        Image(systemName: "arrow.left.circle.fill")
                                            .foregroundColor(.yellow)
                                            .font(.title)
                                    }
                                    .padding(.trailing,  UIScreen.main.bounds.height < 737 ? 600.0 : 700.0)
                                    .padding(.bottom,50)

                                }
                                else{
                                    Text("Ride The Bus")
                                        .frame(maxWidth: .infinity, maxHeight: nil)
                                        .frame(width: 175.0)
                                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                        .font(.system(size:30))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.yellow)
                                        .multilineTextAlignment(.center)
                             
                                    Button(action: {
                                        goHome=true
                                    }) {
                                        Image(systemName: "arrow.left.circle.fill")
                                            .foregroundColor(.yellow)
                                            .font(.title)
                                    }
                                    .padding(.trailing,  UIScreen.main.bounds.height < 737 ? 600.0 : 700.0)
                                    .padding(.bottom,50)
                                    
                                    
                                }
                            }
                            .frame(width: 30.0, height: 300.0)
                            .rotationEffect(.degrees(90))
                        }
                        
                    }
                    
                    
                }
            }
        }
    }
    
    func flashScreenRed(duration: TimeInterval) {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let window = windowScene.windows.first
        else {
            return
        }
        
        let redView = UIView(frame: window.bounds)
        redView.backgroundColor = UIColor.red
        redView.alpha = 0.5
        
        window.addSubview(redView)
        
        UIView.animate(withDuration: duration, animations: {
            redView.alpha = 0.0
        }) { _ in
            redView.removeFromSuperview()
        }
    }
    
    func flashScreenGreen(duration: TimeInterval) {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let window = windowScene.windows.first
        else {
            return
        }
        
        let redView = UIView(frame: window.bounds)
        redView.backgroundColor = UIColor.systemGreen
        redView.alpha = 0.5
        
        window.addSubview(redView)
        
        UIView.animate(withDuration: duration, animations: {
            redView.alpha = 0.0
        }) { _ in
            redView.removeFromSuperview()
        }
    }
    
    func navigateToCardView() {
        isCardViewPresented = true
    }
    
    
    func countDeck() -> Int{
        
        return score
    }
    
    func checkColor(){
        score+=1
        DrawCard()
        if((deck[deckIndex].suit == "hearts" || deck[deckIndex].suit == "diamonds") && redGuess || (deck[deckIndex].suit == "clubs" || deck[deckIndex].suit == "spades") && blackGuess)
        {
            flashScreenGreen(duration: 0.5)
            currentIndex = nextIndex
            nextIndex = nextIndex+1
            print("Correct!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
                thirdStackFirstFlip = true
            
        }
        else{
            flashScreenRed(duration: 1)
            currentIndex = currentIndex - 1
            nextIndex = nextIndex - 1
            print("Incorrect!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
        }
        if currentIndex == 2 {
            thirdStackFirstFlip = true
        }
        else if currentIndex == 3 {
            fourthStackFirstFlip = true
        }
        
        
        redGuess = false
        blackGuess = false
    }
    
    
    
     func checkSuit(){
        score+=1
        DrawCard()
        if((deck[deckIndex].suit == "hearts" && heartGuess) || (deck[deckIndex].suit == "diamonds" && diamondGuess) || (deck[deckIndex].suit == "clubs" && clubGuess) || (deck[deckIndex].suit == "spades" && spadeGuess))
            
        {
            flashScreenGreen(duration: 0.5)
            didWin = true
            UserDataFileManager.writeTotalScore(score)
            print("Bus Ridden!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
        }
        else{
            flashScreenRed(duration: 1)
            currentIndex = currentIndex - 1
            nextIndex = nextIndex - 1
            print("Incorrect!")
            print("The next card was " + deck[deckIndex].rank+deck[deckIndex].suit)
            deckIndex+=1
        }
        
        if currentIndex == 3 {
            fourthStackFirstFlip = true
        }
        
        
        clubGuess = false
        spadeGuess = false
        heartGuess = false
        diamondGuess = false
        
    }
    
    
    
    
    
    
    
    
    func checkGuess() {
        let TopPileCard = bus[currentIndex].peek()
        DrawCard()
        score+=1
        
        
        if (deck[deckIndex].numericValue > TopPileCard?.numericValue ?? 0 && higherGuess) ||
            (deck[deckIndex].numericValue < TopPileCard?.numericValue ?? 0 && lowerGuess) {
            flashScreenGreen(duration: 0.5)
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
            flashScreenRed(duration: 1)
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
    
    
}
    
    
    
    struct GamePage_Previews: PreviewProvider {
        static var previews: some View {
            GamePage()
        }
    }
    

