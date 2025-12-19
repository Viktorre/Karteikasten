
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var vocabularyList = [
        "1 - Hallo",
        "Goodbye - Auf Wiedersehen",
        "Thank you - Danke",
        "Please - Bitte",
        "Yes - Ja",
        "No - Nein",
        "Water - Wasser",
        "Food - Essen"
    ]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayCurrentWord()
    }
    
    func setupUI() {
        lbl1.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lbl1.textAlignment = .center
        lbl1.numberOfLines = 0
    }
    
    func displayCurrentWord() {
        if currentIndex < vocabularyList.count {
            lbl1.text = vocabularyList[currentIndex]
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

