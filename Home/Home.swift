

import SwiftUI
import Firebase

struct Home: View {
    
    @EnvironmentObject var userauth: UserAuth
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    @State private var showAlert: Bool = false
    
    
    
    init(){
        
        UITableView.appearance().separatorStyle = .none
       
        
    }
    
    var alert: Alert {
        Alert(title: Text("Alert"), message: Text(userauth.userWarnInfo), dismissButton: .default(Text("Dismiss")))
        
    }
    
    var body: some View {
        
        VStack{
            
            if (userauth.user != nil && userauth.isEmailverified) {
                
                TabView {
                    
                 
                
                    
                    
                    OrdersListView().tabItem {
                        Image(systemName: "cart").font(.system(size: 16, weight: .regular))
                        Text("Orders")}.tag(2)
                    
                    searchbarr().tabItem {
                        Image(systemName: "square.and.pencil").font(.system(size: 16, weight: .regular))
                        Text("Search")}.tag(4)
                    
                    
                    newView().tabItem {
                        Image(systemName: "camera")
                        Text(" Upload Image")}.tag(4)
                    
                    
//                    FirebaseImage().tabItem {
//                        Image(systemName: "message").font(.system(size: 16, weight: .regular))
//                        Text("Message")}.tag(4)
//                    
                    
                
                    
                    Settings().tabItem {
                        Image(systemName: "gear")
                        Text("Settings")}.tag(4)
                    
                  
                  
                    
                    
                 
                }
                
            }
            
            else{
                
                WelcomeView().environmentObject(self.userauth)
                
            }
            
        }
        
    }
    
    
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(UserAuth())
      
    }
}
