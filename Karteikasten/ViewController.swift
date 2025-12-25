import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    struct ResponseData: Decodable {
        var vocab: [Vocab]
    }

    struct Vocab: Decodable {
        var german: String
        var french: String
        var difficulty: Int
    }


    func loadJson(filename fileName: String) -> [Vocab]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.vocab
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
        print(loadJson(filename: "vocab")?.count==2)
        var vocab = loadJson(filename: "vocab")!
        print(vocab.count==2)
    }
    
    func setupUI() {
        lbl1.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lbl1.textAlignment = .center
        lbl1.numberOfLines = 0
    }
    
    func displayCurrentWord() {
        var vocab = loadJson(filename: "vocab")!
        if currentIndex < vocab.count {
            let german = vocab[currentIndex].german
            let french = vocab[currentIndex].french
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

