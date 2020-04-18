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
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("MenuNotes")
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }

    func ReadData(fileName: String) -> String {
        do{
            return try String(contentsOf: (FOLDER_URL?.appendingPathComponent(fileName))!, encoding: .utf8)
        }
        catch {
            return ""
        }
    }
    
    func SaveData() {
        WriteData(fileName: "notes.txt")
        WriteData(fileName: "other.txt")
    }
    
    func WriteData(fileName: String) { // Eventually return array of data
        var scrollView:NSScrollView = firstTextBox
        
        if fileName != "notes.txt"{
            scrollView = secondTextBox;
        }
        
        let myTextView: NSTextView = scrollView.documentView! as! NSTextView
        let text:String = myTextView.string

        do{
            try text.write(to: (FOLDER_URL?.appendingPathComponent(fileName))!, atomically: false, encoding: .utf8)
        }
        catch {
            return
        }
    }
}
