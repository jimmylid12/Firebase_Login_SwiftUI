
//

import SwiftUI

struct TitleView: View {
    var Title: String
    
       var body: some View {
           
           VStack {
               VStack( alignment: .center) {
                      
                   
                Text("").foregroundColor(Color.white)
                    .font(.title).fontWeight(.ultraLight)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
                Text(Title).foregroundColor(Color.white)
                    .font(.largeTitle).fontWeight(.light)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                   
               }
            
           }.padding(.top, 30).padding(.trailing, 10)
            .background(Color.init(red: 0.035, green: 0, blue: 0.435)).shadow(radius:21)
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(Title: "")
    }
}
