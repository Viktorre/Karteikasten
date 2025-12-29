import Foundation
import UIKit


struct ResponseData: Decodable {
    var vocab: [Vocab]
}

struct Vocab: Decodable {
    var german: String
    var french: String
    var difficulty: Int
}


class ViewController: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentIndex = 0
    var vocabs: [Vocab]!

    func loadJson(fileName: String) -> [Vocab]? {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vocabs = loadJson(fileName: "vocab")!
        print(vocabs.count==2)
        print(vocabs[0].french)
        vocabs[0].french = "changed value"
        print(vocabs[0].french)
        displayCurrentWord()
        print(999)
        print(loadJson(fileName: "vocab")?.count==2)

    }
    
    func setupUI() {
        lbl1.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lbl1.textAlignment = .center
        lbl1.numberOfLines = 0
    }
    
    func displayCurrentWord() {
        if currentIndex < vocabs.count {
            let german = vocabs[currentIndex].german
            let french = vocabs[currentIndex].french
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

