//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceViewController: UIViewController {
    
    @IBOutlet private weak var strawberryCount: UILabel!
    @IBOutlet private weak var bananaCount: UILabel!
    @IBOutlet private weak var pineappleCount: UILabel!
    @IBOutlet private weak var kiwiCount: UILabel!
    @IBOutlet private weak var mangoCount: UILabel!
    
    private var juiceMaker = JuiceMaker()
    private let fruitStore = FruitStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFruitsCount()
    }
    
    private func showFruitsCount() {
        strawberryCount.text = fruitStore.storage[.strawberry]?.description
        bananaCount.text = fruitStore.storage[.banana]?.description
        pineappleCount.text = fruitStore.storage[.pineapple]?.description
        kiwiCount.text = fruitStore.storage[.kiwi]?.description
        mangoCount.text = fruitStore.storage[.mango]?.description
    }

    @IBAction private func adjustStock(_ sender: Any) {
        pushNavigationView()
    }
    
    private func pushNavigationView(_ uiAlertAction: UIAlertAction = UIAlertAction()) {
        let supplyVC = storyboard?.instantiateViewController(withIdentifier: "SupplyViewController") as! SupplyViewController
                                        
        navigationController?.pushViewController(supplyVC, animated: true)
    }
    
    private func alertJuiceServed(menu: JuiceMaker.Menu) {
        let alert = UIAlertController(title: "", message: "\(menu) 나왔습니다! 맛있게 드세요!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func alertInsufficientStock() {
        let alert = UIAlertController(title: "", message: "재료가 모자라요. 재고를 수정할까요?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("예", comment: "Default action"), style: .default, handler: pushNavigationView))
        alert.addAction(UIAlertAction(title: NSLocalizedString("아니오", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func orderJuice(menu: JuiceMaker.Menu) {
        do {
            try juiceMaker.makeJuice(menu: menu)
            alertJuiceServed(menu: menu)
            showFruitsCount()
        } catch {
            print(error)
            alertInsufficientStock()
        }
    }
    
    @IBAction private func orderStrawberryJuice(_ sender: Any) {
        orderJuice(menu: .딸기쥬스)
    }
    
    @IBAction private func orderBananaJuice(_ sender: Any) {
        orderJuice(menu: .바나나쥬스)
    }
    
    @IBAction private func orderPineappleJuice(_ sender: Any) {
        orderJuice(menu: .파인애플쥬스)
    }
    
    @IBAction private func orderKiwiJuice(_ sender: Any) {
        orderJuice(menu: .키위쥬스)
    }
    
    @IBAction private func orderMangoJuice(_ sender: Any) {
        orderJuice(menu: .망고쥬스)
    }
    
    @IBAction private func orderStrawberryBananaJuice(_ sender: Any) {
        orderJuice(menu: .딸바쥬스)
    }
    
    @IBAction private func orderMangoKiwiJuice(_ sender: Any) {
        orderJuice(menu: .망고키위쥬스)
    }
    
}

