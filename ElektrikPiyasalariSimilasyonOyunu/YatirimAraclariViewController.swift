//
//  YatirimAraclariViewController.swift
//  ElektrikPiyasalariSimilasyonOyunu
//
//  Created by Berat Rıdvan Asiltürk on 4.06.2022.
//

import UIKit

class YatirimAraclariViewController: UIViewController , YatirimEkraniViewControllerDelegate {
    
    
    @IBOutlet weak var nukleerLabel: UILabel!
    @IBOutlet weak var ruzgarLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var komurLabel: UILabel!
    @IBOutlet weak var gunesLabel: UILabel!
    @IBOutlet weak var butceLabel: UILabel!
    @IBOutlet weak var periyotLabel: UILabel!
    
    @IBOutlet weak var gunesSliderOutlet: UISlider!
    @IBOutlet weak var komurSliderOutlet: UISlider!
    @IBOutlet weak var bioSliderOutlet: UISlider!
    @IBOutlet weak var ruzgarSliderOutlet: UISlider!
    @IBOutlet weak var nukleerSliderOutlet: UISlider!
    
    var periyot = 1
    
    ///Her bir santral icin default atanan baslangic degerleri
    var bioSatinAlinanPeriyot: Int?
    var komurSatinAlinanPeriyot: Int?
    var nukSatinAlinanPeriyot: Int?
    var ruzgarSatinAlinanPeriyot: Int?
    var gunesSatinAlinanPeriyot: Int?
    
    
    /// Oyun baslangicinda kullaniciya verilen butce
    var butce = 200000000
    
    /// Oyuncunun yatirim yaptigi enerji santralleri
    /// Satin alinan santraller bu degiskende tutulur
    var yatirimlarim : [YoneticiViewModel.EnerjiTurleri] = []
    
    /// Kullanicinin O Periyotta Verdigi Teklif
    /// Her Periyot Sifirlanir
    var komurTeklifim = 0
    var gunesTeklifim = 0
    var ruzgarTeklifim = 0
    var nukleerTeklifim = 0
    var bioTeklifim = 0
    
    
    /// Santal Yatirimi Butonu Tiklandiginda Tetiklenir ve Oyuncunun Alabilecegi Santaller Ekrana Gelir
    @IBAction func santralYatirimButtonTapped(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyBoard.instantiateViewController(withIdentifier: "YatirimEkraniViewController") as! YatirimEkraniViewController
        destination.delegate = self
        present(destination, animated: true, completion: nil)
        
    }
    
    fileprivate func kullaniciGelirleriniHesapla() {
        /// Bio Yakit santarlin omru toplam periyottan kucuk esitse ve
        /// Bio Yakit santralin aktiflesme donemi ile satin alinan andaki periyotun oyun geneli toplam periyottan kucuk ve esit olmasi kosulunda ancak kodu calistiran kosul
        if let bioSatinAlinanPeriyot = bioSatinAlinanPeriyot,
           bioTeklifim > YoneticiViewModel.shared.minimumTeklifFiyati(periyot, enerjiTuru: .bio),
           YoneticiViewModel.EnerjiTurleri.bio.santralinOmru >= periyot,
           YoneticiViewModel.EnerjiTurleri.gunes.santralinAktiflesmeDonemi + bioSatinAlinanPeriyot <= periyot {
            butce += YoneticiViewModel.shared.gelir(teklif: bioTeklifim, enerjiTuru: .bio)
            print("✅  Bio Teklifim Kabul Edildi ")
        }
        /// Gunes santarlin omru toplam periyottan kucuk esitse ve
        /// Gunes santralin aktiflesme donemi ile satin alinan andaki periyotun oyun geneli toplam periyottan kucuk ve esit olmasi kosulunda ancak kodu calistiran kosul
        if let gunesSatinAlinanPeriyot = gunesSatinAlinanPeriyot,
           gunesTeklifim > YoneticiViewModel.shared.minimumTeklifFiyati(periyot, enerjiTuru: .gunes),
           YoneticiViewModel.EnerjiTurleri.gunes.santralinOmru >= periyot,
           YoneticiViewModel.EnerjiTurleri.gunes.santralinAktiflesmeDonemi + gunesSatinAlinanPeriyot <= periyot {
            butce += YoneticiViewModel.shared.gelir(teklif: gunesTeklifim, enerjiTuru: .gunes)
            print("✅  Gunes Teklifim Kabul Edildi ")
        }
        
        /// Komur santarlin omru toplam periyottan kucuk esitse ve
        /// Komur santralin aktiflesme donemi ile satin alinan andaki periyotun oyun geneli toplam periyottan kucuk ve esit olmasi kosulunda ancak kodu calistiran kosul
        if let komurSatinAlinanPeriyot = komurSatinAlinanPeriyot,
           komurTeklifim > YoneticiViewModel.shared.minimumTeklifFiyati(periyot, enerjiTuru: .komur),
           YoneticiViewModel.EnerjiTurleri.komur.santralinOmru >= periyot,
           YoneticiViewModel.EnerjiTurleri.komur.santralinAktiflesmeDonemi + komurSatinAlinanPeriyot <= periyot {
            butce += YoneticiViewModel.shared.gelir(teklif: komurTeklifim, enerjiTuru: .komur)
            print("✅  Komur Teklifim Kabul Edildi ")
        }
        /// Nukleer santarlin omru toplam periyottan kucuk esitse ve
        /// Nukleer santralin aktiflesme donemi ile satin alinan andaki periyotun oyun geneli toplam periyottan kucuk ve esit olmasi kosulunda ancak kodu calistiran kosul
        if let nukSatinAlinanPeriyot = nukSatinAlinanPeriyot,
           nukleerTeklifim > YoneticiViewModel.shared.minimumTeklifFiyati(periyot, enerjiTuru: .nukleer),
           YoneticiViewModel.EnerjiTurleri.nukleer.santralinOmru >= periyot,
           YoneticiViewModel.EnerjiTurleri.nukleer.santralinAktiflesmeDonemi + nukSatinAlinanPeriyot <= periyot {
            butce += YoneticiViewModel.shared.gelir(teklif: nukleerTeklifim, enerjiTuru: .nukleer)
            print("✅  Nuk Teklifim Kabul Edildi ")
        }
        /// Ruzgar santarlin omru toplam periyottan kucuk esitse ve
        /// ruzgar santralin aktiflesme donemi ile satin alinan andaki periyotun oyun geneli toplam periyottan kucuk ve esit olmasi kosulunda ancak kodu calistiran kosul
        if let ruzgarSatinAlinanPeriyot = ruzgarSatinAlinanPeriyot,
           ruzgarTeklifim > YoneticiViewModel.shared.minimumTeklifFiyati(periyot, enerjiTuru: .ruzgar),
           YoneticiViewModel.EnerjiTurleri.ruzgar.santralinOmru >= periyot,
           YoneticiViewModel.EnerjiTurleri.ruzgar.santralinAktiflesmeDonemi + ruzgarSatinAlinanPeriyot <= periyot {
            
            butce += YoneticiViewModel.shared.gelir(teklif: ruzgarTeklifim, enerjiTuru: .ruzgar)
            print("✅  Ruzgar Teklifim Kabul Edildi ")
        }
    }
    
    fileprivate func uiGuncelle() {
        
        // Her periyotta Ui guncellenir
        butceLabel.text = "\(butce)$"
        periyot += 1
        periyotLabel.text = "\(periyot)"
        
        // Default degerler atanir
        komurTeklifim = 0
        gunesTeklifim = 0
        ruzgarTeklifim = 0
        nukleerTeklifim = 0
        bioTeklifim = 0
        
        //Default degerler atanir
        sliderGuncelle()
        
        bioSliderOutlet.setValue(0, animated: true)
        komurSliderOutlet.setValue(0, animated: true)
        gunesSliderOutlet.setValue(0, animated: true)
        ruzgarSliderOutlet.setValue(0, animated: true)
        nukleerSliderOutlet.setValue(0, animated: true)
        
        //Default degerler atanir
        nukleerLabel.text = "$"
        ruzgarLabel.text = "$"
        bioLabel.text = "$"
        komurLabel.text = "$"
        gunesLabel.text = "$"
    }
    
    /// Oyuncunun o periyottaki teklifini onaylatmak icin kullanilan butondur.
    @IBAction func onaylaButton(_ sender: UIButton) {
        
        // Oyunun toplam tur sayisi
        if periyot == 10 {
            return
        }
        // Butcenin sifirin altina dusmesi durumunda oyun sonlanir
        if butce <= 0 {
            return
        }

        kullaniciGelirleriniHesapla()
        
        uiGuncelle()
        
    }
    
    
    
    
    // Sliderlarin Oyuncunun Sectigi Tekliflere Gore Ui Guncellenir
    @IBAction func komurSlider(_ sender: UISlider) {
        komurTeklifim = Int(sender.value)
        komurLabel.text = "\(komurTeklifim)$"
    }
    @IBAction func gunesSlider(_ sender: UISlider) {
        gunesTeklifim = Int(sender.value)
        gunesLabel.text = "\(gunesTeklifim)$"
        
    }
    @IBAction func bioSlider(_ sender: UISlider) {
        bioTeklifim = Int(sender.value)
        bioLabel.text = "\(bioTeklifim)$"
    }
    
    @IBAction func nukleerSlider(_ sender: UISlider) {
        nukleerTeklifim = Int(sender.value)
        nukleerLabel.text = "\(nukleerTeklifim) $"
    }
    @IBAction func ruzgarSlider(_ sender: UISlider) {
        ruzgarTeklifim = Int(sender.value)
        ruzgarLabel.text = "\(ruzgarTeklifim)$"
    }
    
    /// Bu ekran ilk acildigi an tetiklenen methoddur, Oyun ilk acildiginda default degerler atanmalidir
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderGuncelle()
    }
    
    /// Yatirim Ekranindan Enerji Santrali Satin Alindiginda Tetiklenir,
    /// Butcenin olmadigi durumda kullaniciya uyari gider, ancak butce varsa satin alma islemi gerceklesir
    /// Oyun geregi kullanici bir santral aldiginda teklif vermeye baslayabilir
    func satinAlindi(enerjiTuru: YoneticiViewModel.EnerjiTurleri) {
        
        ///Alinmak istenen santralin maliyeti o anki butceden buyukse oyuncuya uyari bildirimi atilir
        if enerjiTuru.satinAlmaMaliyeti > butce {
            
            print("Alinmak Istenen Santrale Butce Yok")
            
            let title = "Alinmak Istenen Santrale Butce Yok"
            let tamam = UIAlertAction(title: "Tamam", style: .cancel)
            
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
            alert.addAction(tamam)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            return
        }
        /// Yatirim sonrasi butce ve ui guncellenir
        butce -= enerjiTuru.satinAlmaMaliyeti
        butceLabel.text = "\(butce)$"
        
        yatirimlarim.append(enerjiTuru)
        sliderGuncelle()
        
        print(" 🔥 Santral satin alindi : \(enerjiTuru)")
        
        ///Her bir santralin ne zaman satin alindigini belirleyen durum
        switch enerjiTuru {
        case .ruzgar :
            ruzgarSatinAlinanPeriyot = periyot
        case .nukleer :
            nukSatinAlinanPeriyot = periyot
        case .bio :
            bioSatinAlinanPeriyot = periyot
        case .gunes :
            gunesSatinAlinanPeriyot = periyot
        case .komur :
            komurSatinAlinanPeriyot = periyot
        }
    }
    
    
    /// Bu method yatirim yapildiktan sonra her bir enerji santrali icin o santralin sliderinin kullanimini duzenler
    func sliderGuncelle() {
        
        if let nukSatinAlinanPeriyot = nukSatinAlinanPeriyot,
           YoneticiViewModel.EnerjiTurleri.nukleer.santralinAktiflesmeDonemi + nukSatinAlinanPeriyot <= periyot,
           yatirimlarim.contains(.nukleer) {
            nukleerSliderOutlet.isUserInteractionEnabled = true
        } else {
            nukleerSliderOutlet.isUserInteractionEnabled = false
        }
        if let ruzgarSatinAlinanPeriyot = ruzgarSatinAlinanPeriyot,
           YoneticiViewModel.EnerjiTurleri.ruzgar.santralinAktiflesmeDonemi + ruzgarSatinAlinanPeriyot <= periyot,
           yatirimlarim.contains(.ruzgar) {
            ruzgarSliderOutlet.isUserInteractionEnabled = true
        } else {
            ruzgarSliderOutlet.isUserInteractionEnabled = false
        }
        
        if let bioSatinAlinanPeriyot = bioSatinAlinanPeriyot,
           YoneticiViewModel.EnerjiTurleri.bio.santralinAktiflesmeDonemi + bioSatinAlinanPeriyot <= periyot,
           yatirimlarim.contains(.bio)
        {
            bioSliderOutlet.isUserInteractionEnabled = true
        } else {
            bioSliderOutlet.isUserInteractionEnabled = false
        }
        
        if let komurSatinAlinanPeriyot = komurSatinAlinanPeriyot,
           YoneticiViewModel.EnerjiTurleri.komur.santralinAktiflesmeDonemi + komurSatinAlinanPeriyot <= periyot,
           yatirimlarim.contains(.komur) {
            komurSliderOutlet.isUserInteractionEnabled = true
        } else {
            komurSliderOutlet.isUserInteractionEnabled = false
        }
        
        if let gunesSatinAlinanPeriyot = gunesSatinAlinanPeriyot,
           YoneticiViewModel.EnerjiTurleri.gunes.santralinAktiflesmeDonemi + gunesSatinAlinanPeriyot <= periyot,
           yatirimlarim.contains(.gunes)
        {
            gunesSliderOutlet.isUserInteractionEnabled = true
        } else {
            gunesSliderOutlet.isUserInteractionEnabled = false
        }
        
        
    }
    
    
    
    
}
