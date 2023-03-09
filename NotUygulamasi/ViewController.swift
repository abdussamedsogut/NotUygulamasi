//
//  ViewController.swift
//  NotUygulamasi
//
//  Created by Abdüssamed Söğüt on 24.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var notTableView: UITableView!
    
    
    var notlarListe = [Notlar]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        veriTabaniKopyala()
        
        notTableView.delegate = self
        notTableView.dataSource = self
        

        }
    
    override func viewWillAppear(_ animated: Bool) {
        notlarListe = Notlardao().tumNotlardao()
        notTableView.reloadData()
        
        var toplam = 0
        
        for n in notlarListe {
            toplam = toplam + (n.not1! + n.not2!)/2
        }
        let ortalama = toplam/(notlarListe.count)

        if notlarListe.count != 0 {
            navigationItem.prompt = "Ortalama \(ortalama)"
        }else{
            navigationItem.prompt = "YOK"

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toNotDetay" {
            let gidilecekVC = segue.destination as! NotDetayViewController
            gidilecekVC.not = notlarListe[indeks!]
        }
    }
        
    
    func veriTabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(filePath: hedefYol).appending(component: "notlar.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("veritabanı zaten var. Kopyalamaya gerek yok ")
        } else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch  {
                print(error)
            }
        }
        
    }
    

    
    }
    
    extension ViewController: UITableViewDataSource,UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notlarListe.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let not = notlarListe[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
            
            
            cell.labelDersAdi.text = not.ders_adi
            cell.labelNot1.text! = String(not.not1!)
            cell.labelNot2.text! = String(not.not2!)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toNotDetay", sender: indexPath.row)
            
        }
        
    }
    

