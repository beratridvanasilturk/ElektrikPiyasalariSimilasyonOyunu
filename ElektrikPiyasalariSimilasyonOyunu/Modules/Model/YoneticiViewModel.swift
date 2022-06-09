//
//  YoneticiViewModel.swift
//  ElektrikPiyasalariSimilasyonOyunu
//
//  Created by Berat Rıdvan Asiltürk on 17.05.2022.
//

import Foundation

    /// uygulamada ekranlar arasinda kullanici verilerini yoneten sinif
class YoneticiViewModel {
    
    var periyot = 1
    let baslangicButcesi = 2_000_000_000
    
    var santraller: [EnerjiTurleri] {[
        YoneticiViewModel.EnerjiTurleri.gunes,
        YoneticiViewModel.EnerjiTurleri.ruzgar,
        YoneticiViewModel.EnerjiTurleri.bio,
        YoneticiViewModel.EnerjiTurleri.komur,
        YoneticiViewModel.EnerjiTurleri.nukleer,
    ]}
    
    /// Oyunda var olan enerji santralleri
    enum EnerjiTurleri {
        
        case nukleer
        case ruzgar
        case gunes
        case komur
        case bio
        
        
        /// Her bir santralin sahip oldugu MW degeri
        var megawatt : Int {
            switch self {
            case .nukleer:
                return 900
            case .ruzgar:
                return 80
            case .gunes:
                return 60
            case .komur:
                return 600
            case .bio:
                return 300
            }
        }
        
        
        /// Her bir santralin maliyeti
        var satinAlmaMaliyeti : Int {
            switch self {
            case .nukleer:
               return 8_000_000_000
            case .ruzgar:
               return 700_000_000
            case .gunes:
                return 600_000_000
            case .komur:
                return 1_700_000_000
            case .bio:
                return 1_000_000_000
            }
        }
        /// Her bir santralin kullnaim omru
        var santralinOmru : Int {
            
            switch self {
            case .nukleer:
                return 7
            case .ruzgar:
                return 4
            case .gunes:
                return 6
            case .komur:
                return 9
            case .bio:
                return 10
            }
        }
        
        /// Her bir santralin aktif olacagi donem
        var santralinAktiflesmeDonemi : Int {
            switch self {
            case .nukleer:
                return 2
            case .ruzgar:
                return 2
            case .gunes:
                return 1
            case .komur:
                return 1
            case .bio:
                return 3
            }
        }
        
        
        
    }
    
  
    let yildakiSaat = 8766
    
   
    
    /// Kullaniciya donen o turdaki gelir hesabi
    /// - Parameters:
    ///   - teklif: kullanicinin verdigi teklif
    ///   - enerjiTuru: kullanicinin teklif verdigi santral turu
    /// - Returns: Kullaniciya hesaplanan gelir doner
    func gelir(teklif: Int, enerjiTuru: EnerjiTurleri) -> Int {
        return teklif * enerjiTuru.megawatt * yildakiSaat
    }
    
    
    /// Mevcut periyot icin sistemin her bir enerji turune dondugu fiyat
    func minimumTeklifFiyati(_ periyot: Int, enerjiTuru: EnerjiTurleri) -> Int {
        
        // ilk 2 donem boyunca , piyasa arz talep dengelemesi icin , kabul edilen teklif.
        guard periyot > 2 else {
            return 0
        }
        
        let fiyat = (70...160).randomElement()!
        print("* sistemin teklifi: \(enerjiTuru) \(fiyat)")
        return fiyat
    }
    
    
    /// viewcontroller siniflari arasinda paylasilan obje
    static let shared = YoneticiViewModel()
    
    
    var kullaniciIsmi : String!
    
    
    /// Sistemin sahip oldugu 100 kullanici ismi
    let oyuncuIsimleri :  [String] = [
        
        "Sezgin Eken",
        "Hasan Akkoyun",
        "Zeynep Kocatürk",
        "Akar Dumanlı",
        "Ergül Fırat",
        "Arzu Akaydın",
        "Turhan Gül",
        "Mehmet Sakarya",
        "Rümeysa Meleknur Şener",
        "Kasım Kısakürek",
        "Mahsun Zorlu",
        "Abdullah Çamurcuoğlu",
        "Nil Zengin",
        "Tarkan Demirel",
        "Yaman Akdeniz",
        "Sami Gül",
        "Mete Akar",
        "Ülkü İnönü Alemdar",
        "Sezen Fırat",
        "Cemal Yaman",
        "Hande Aslan",
        "Çelem Zorlu",
        "Göktürk Sakarya",
        "Oğuzhan Yaman",
        "Feyza Yıldırım",
        "Erdoğan Akçay",
        "Sümeyra Sezgin",
        "Kayra Demir",
        "Tümer Yorulmaz",
        "Arısoy Fırat",
        "Seven Şensoy",
        "Elvan Demirel",
        "Şener Alemdar",
        "Asım Çorlu Türk",
        "Halide Türk",
        "Özgenur Kılıkırk",
        "Tümer Akçay",
        "Sümerya Durmuş Çorlu",
        "Ünal Mansız",
        "Şensoy Durdu",
        "Ülkü Naz Gül",
        "Haliye Duran",
        "Vuslat Yasemin Şensoy",
        "Bahar Tarhan",
        "Yıldırım Güçlü",
        "Taner Kemal Seven",
        "İçim Soylu",
        "Ülker Şensoy",
        "Karakucak Bilir",
        "Pınar Damla Demirel",
        "Leman Hançer Akça",
        "Binışık Akdeniz",
        "Işıl Deviner",
        "Selda Şener",
        "Ferdi Yaman",
        "Tuğtaş Sezer",
        "Şuayp Şensoy",
        "Günser Durdu",
        "Vildane Mansız",
        "Mehrigül Bilge",
        "Asım Sezgin",
        "Dağıstan Çorlu",
        "Barışcan Şener",
        "Arslan Şensoy",
        "Betül Yaman",
        "Ekber Yağın Akçay",
        "Gamze Demir",
        "Çağla Irmak",
        "Emel Kısakürek",
        "Akçay Yaman",
        "Sencar Ertaş",
        "Canan Tevetoğlu",
        "Günver Hançer",
        "Dincer Arsoy",
        "Övün Durmuş",
        "Emirşan Yıldırım",
        "Maksur Duran",
        "Bahaddin Demirel",
        "Ülküdeş Yüksel",
        "Korkmazalp Hasan Ay",
        "Gündüzalp Ertaş Kama",
        "Bahar Akçay",
        "Mecit Sakarya Yılmaz",
        "Yaman Şener",
        "Server Hayrioğlu",
        "Halenur Yorulmaz",
        "Neval Durdu",
        "Esen Korutürk",
        "Kaya İhsanoğlu",
        "Aslan Kemer",
        "Akçay Yaman",
        "Senanur Doğan",
        "Nazimet Gül",
        "Naide Gülen Şensoy",
        "Ülker Çetin",
        "Fırat Ertaş",
        "Leyla Gül",
        "Gül İhsanoğlu",
        "Hançer Duran",
        "Fazıl Akar"
    ]
    
    
    /// Ana oyuncu haric 9 kisiyi random secen degisken
    lazy var secilenOyuncularGetir : [Oyuncu] = {
        var secilenOyuncular = oyuncuIsimleri.shuffled().prefix(9).map { isim in
            Oyuncu(isim: isim, butce: baslangicButcesi)
        }
        
        let kullanici = Oyuncu(isim: kullaniciIsmi, butce: baslangicButcesi)
        
        secilenOyuncular.append(kullanici)
        
        return secilenOyuncular
        
    }()
    
    
}