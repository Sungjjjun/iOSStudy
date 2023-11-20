//
//  SymbolRollerViewController.swift
//  HelloiOS
//
//  Created by 박성준 on 2023/11/20.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // 화면에 보이지 않는 상태(보이기 전 준비, 메모리에 올라감)
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(systemName: "sun.min")
        // Do any additional setup after loading the view.
    }
    
    // 화면에 보이지 직전 상태
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // 화면에 보인 후 상태
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("버튼 클릭됨...")
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
