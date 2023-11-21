//
//  SimpleWeatherViewController.swift
//  HelloiOS
//
//  Created by 박성준 on 2023/11/20.
//

import UIKit

class SimpleWeatherViewController: UIViewController {
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let cities = ["Seoul", "Tokyo", "Seattle", "LA"]
    
    let images = ["sun.max.fill", "cloud.fill", "wind", "cloud.sun.rain.fill"]

    func reload() {
        let randomTemp = Int.random(in: 10..<30)
        city.text = cities.randomElement()!
        imageView.image = UIImage(systemName: images.randomElement()!)?.withRenderingMode(.alwaysOriginal)
        temp.text = "\(randomTemp)°"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
