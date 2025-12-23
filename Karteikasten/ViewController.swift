import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var vocabulary: [[String: String]] = [
        [
            "german": "dennoch",
            "french": "néanmoins"
        ],
        [
            "german": "deutsch",
            "french": "allemand"
        ]
    ]
  
    
    
    struct ResponseData: Decodable {
        var person: [Person]
    }

    struct Person: Decodable {
        var name: String
        var age: String
        var employed: String
    }
    
    func loadJson(filename fileName: String) -> [Person]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.person
            } catch {
                print("Error: \(error)")
            }
        }
        return nil
    }
    
  
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayCurrentWord()
        print(999)
        print(loadJson(filename: "vocab"))
    }
    
    func setupUI() {
        lbl1.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lbl1.textAlignment = .center
        lbl1.numberOfLines = 0
    }
    
    func displayCurrentWord() {
        if currentIndex < vocabulary.count {
            let entry = vocabulary[currentIndex]
            let german = entry["german"] ?? "—"
            let french = entry["french"] ?? "—"
            lbl1.text = "🇩🇪 \(german)\n🇫🇷 \(french)"
            nextButton.isEnabled = true
        } else {
            lbl1.text = "🎉 Done!"
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        currentIndex += 1
        displayCurrentWord()
    }
}

