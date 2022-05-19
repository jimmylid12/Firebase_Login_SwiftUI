

import SwiftUI


public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

struct WelcomeView: View {
    
    @EnvironmentObject var userauth: UserAuth
    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false
    @State var selection: Int? = nil
    @State var viewState = CGSize.zero
    @State var MainviewState =  CGSize.zero
    @Environment(\.colorScheme) var colorScheme
    @State private var showButtons = true
    
    
    var body: some View {
        
        
        
        
        VStack {
            
            
            
            
            Spacer()
            
            
            
            if userauth.user == nil || !userauth.isEmailverified 
                
            {
                   
                VStack(spacing:20) {
                    
                
                    if showButtons{
                    VStack(spacing: 60){
                        
                        
                        Text("  Mobile Ordering System")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top,100)
                            .foregroundColor(.white)
                            
                        
                        Image("image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                       
                        Spacer()
                        
                        Button(action: {
                            self.signInIsPresent = true
                            
                        })
                        {
                            
                            Text("SIGN IN")
                                
                            
                        }.frame(width: 350, height: 75)
                        .background(
                            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650).edgesIgnoringSafeArea(.all))
                        .foregroundColor(.white)
                    .cornerRadius(10)
                        .padding(.top,10)
                        
                            

                        .sheet(isPresented: $signInIsPresent) {
                            
                            SignInView(onDismiss:{
                                
                                print("Dismissed")
                                
                            }).environmentObject(self.userauth)
                            
                        }
                        Button(action: {self.signUpIsPresent = true}){
                            Text("SIGN UP")
                                
                            
                        }
                        .frame(width: 350, height: 75)
                        .background(
                            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650).edgesIgnoringSafeArea(.all))
                        .foregroundColor(.white)
                    .cornerRadius(10)
                        .padding(.top,10)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        
                        .padding(30)
                        
                        
                        .sheet(isPresented: self.$signUpIsPresent){
                            
                            SignUpView().environmentObject(self.userauth)
                           
                        }
                        
                  
                        
                        
                    }
              
                    
                    }
                    
                    
                }
                .padding(10)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                .background(
                    RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650).edgesIgnoringSafeArea(.all))
                                
                                
                                
                                
                                
                
            }
                
                
                
                
                
            else{
        
                
                actIndSignin(shouldAnimate: .constant(true))
                
            }
            
            
            Spacer()
            
            
            
        }
        .edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom)
        
        
    }
    
    
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().environmentObject(UserAuth())
        
    }
}
