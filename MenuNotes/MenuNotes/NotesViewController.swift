import Cocoa

class NotesViewController: NSViewController {
    @IBOutlet weak var secondTextBox: NSScrollView!
    @IBOutlet weak var firstTextBox: NSScrollView!
    @IBOutlet weak var quitButton: NSButton!
    
    let FOLDER_URL = URL(string: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.absoluteString + "MenuNotes/")
    
    class func loadFromNib() -> NotesViewController{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "NotesViewController") as! NotesViewController
    }
    
    override func viewDidLoad() {
        CreateDirectory()
        super.viewDidLoad()
        quitButton.action = #selector(self.quitApplication)
        firstTextBox.documentView!.insertText(ReadData(fileName: "notes.txt"))
        secondTextBox.documentView!.insertText(ReadData(fileName: "other.txt"))
    }
    
    @objc func quitApplication() {
        SaveData()
        NSApplication.shared.terminate(self)
    }
    
    func CreateDirectory() {
        let docURL = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let dataPath = docURL!.appendingPathComponent("MenuNotes")
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {}
        }
    }

    func ReadData(fileName: String) -> String { // Eventually return array of data
        do{
            return try String(contentsOf: (FOLDER_URL?.appendingPathComponent(fileName))!, encoding: .utf8)
        }
        catch {
            return ""
        }
    }
    
    func SaveData() {
        let notesText = (firstTextBox.documentView! as! NSTextView).string
        let otherText = (secondTextBox.documentView! as! NSTextView).string

        do{
            try notesText.write(to: (FOLDER_URL?.appendingPathComponent("notes.txt"))!, atomically: false, encoding: .utf8)
            try otherText.write(to: (FOLDER_URL?.appendingPathComponent("other.txt"))!, atomically: false, encoding: .utf8)
        }
        catch {
            return
        }
    }
}
