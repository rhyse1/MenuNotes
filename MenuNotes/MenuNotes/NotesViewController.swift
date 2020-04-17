import Cocoa

class NotesViewController: NSViewController {
    @IBOutlet weak var secondTextBox: NSScrollView!
    @IBOutlet weak var firstTextBox: NSScrollView!
    @IBOutlet weak var quitButton: NSButton!
    
    class func loadFromNib() -> NotesViewController{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "NotesViewController") as! NotesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quitButton.action = #selector(self.quitApplication)
        firstTextBox.documentView!.insertText(ReadData(fileName: "notes.txt"))
        secondTextBox.documentView!.insertText(ReadData(fileName: "other.txt"))
    }
    
    @objc func quitApplication()
    {
        SaveData()
        NSApplication.shared.terminate(self)
    }

    func ReadData(fileName: String) -> String {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do{
            return try String(contentsOf: (dir?.appendingPathComponent(fileName))!, encoding: .utf8)
        }
        catch {
            return ""
        }
    }
    
    func SaveData() -> Void {
        WriteData(fileName: "notes.txt")
        WriteData(fileName: "other.txt")
    }
    
    func WriteData(fileName: String) -> Void { // Eventually return array of data
        var scrollView:NSScrollView = firstTextBox
        
        if fileName != "notes.txt"{
            scrollView = secondTextBox;
        }
        
        let myTextView: NSTextView = scrollView.documentView! as! NSTextView
        let text:String = myTextView.string
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do{
            try text.write(to: (dir?.appendingPathComponent(fileName))!, atomically: false, encoding: .utf8)
        }
        catch {
            return
        }
    }
}
