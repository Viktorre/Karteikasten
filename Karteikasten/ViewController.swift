import Foundation
import UIKit


struct ResponseData: Codable {
    var vocab: [Vocab]
}

struct Vocab: Codable {
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

    func saveJson(fileName: String, vocabs: [Vocab]) {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("\(fileName).json")
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            let response = ResponseData(vocab: vocabs)
            let data = try encoder.encode(response)
            try data.write(to: url, options: [.atomic])
            print("Saved \(fileName).json to: \(url.path)")
        } catch {
            print("Failed to save \(fileName).json: \(error)")
        }
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
            vocabs[0].french = "test 04"
            saveJson(fileName: "vocab", vocabs: vocabs)
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        currentIndex += 1
        displayCurrentWord()
    }
}

