//
//  ContentView.swift
//  SwiftUIPhotoPicker
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    // @State var yapıyoruz ki aşağıda bi değişiklik olduğunda burayı mesela imageview verdiysek o da kendini yenilesin ve göstersin
    @State var selectedItems : [PhotosPickerItem] = [] // bu bi PhotosPickerItem dizisi olucak ve başta boş olucak
    @State var data : Data? // bu bize bi data yani bildiğimiz 0-1 olarak gelicek
    
    var body: some View {
        VStack {
            if let data = data { // gerçekten datada bişi varsa
                if let selectedImage = UIImage(data:  data) { // bi uiimage oluşturulabilirse
                    Spacer() // araya boşluk koyar

                    Image(uiImage: selectedImage) // seçilen görseli göster
                        .resizable()
                        .frame(width: 300,height: 250,alignment: .center)
                        
                }
            }
                Spacer()
                    // PhotosPicker fotoğraf galerisinden seçmemiz için geliştirilmiş bi yapı. selection seçtikten sonra hangi değişkeni atayacağımız. maxSelectionCount a kullanıcının en fazla kaç fotoğraf seçebileceğini yazarız. matching e görsel mi video mu onu yazarız
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1,  matching: .images) {
                        Text("Select Image")
                    
                        // onChange e PhotosPicker değişince ne olucağını yazarız. değişecek şeyi of: buraya yazarız. alta selectedItems değişkeni değiştiğinde ne yapılacağını yazarız
                    }.onChange(of: selectedItems) { newValue in
                        guard let item = selectedItems.first else {
                            return
                        }
                        
                        // loadTransferable complation bloğuyla beraber yaptığımız işlemi dataya çevirecek. type: burada hangi type a çevireceğini sorar. yani aldığımız PhotosPickerItem ı dataya çeviriyoruz. selectedıtem değişkeni her değiştiğinde bu işlemi yapıyoruz
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data { // böylelikle kullanıcının seçtiği resmi, 0 lara 1lere yani dataya çevirip " @State var data : Data?" buradaki data nın içine koymuş oluyoruz
                                    self.data = data
                                }
                            case .failure(let error):
                                print(error)
                            }
                            
                        }
                    }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
