import Foundation

enum Note : String
{
    case C, D, E, F, G, A, B
}

enum Accidental : String
{
    case sharp = "#",
         flat  = "b",
         none  = ""
}

enum Token
{
    case note(note: Note, suffix: Accidental)
    case numInt(value: Int)
    case opPlus
    case opMinus
}


struct Tokenizer : Sequence, IteratorProtocol
{

    let text: String

    private var iter_: IndexingIterator<String>
    private var nextChar_: Character?

    init(text: String)
    {
        self.text = text
        self.iter_ = self.text.makeIterator()
        self.getNextChar()
    }

    mutating func next() -> Token? 
    {
        self.skipWhiteSpaces()

        guard let c = self.nextChar_ else { return nil }

        switch c {
        case "A"..."G":
            return self.tryToParseNote()

        case "0"..."9":
            return self.tryToParseNumInt()

        case "+":
            self.getNextChar()
            return .opPlus

        case "-":
            self.getNextChar()
            return .opMinus

        default:
            return nil
        }
    }

    private mutating func getNextChar()
    {
        self.nextChar_ = self.iter_.next()
    }

    private mutating func skipWhiteSpaces()
    {
        while self.nextChar_ != nil {
            let s = String(self.nextChar_!).trimmingCharacters(in: .whitespacesAndNewlines)
            if !s.isEmpty {
                break
            }
            self.getNextChar()
        }
    }

    private mutating func tryToParseNote() -> Token?
    {
        guard let c = self.nextChar_,
              let note = Note(rawValue: String(c)) else { return nil }

        self.getNextChar()

        if let suffix = self.nextChar_,
                suffix == "#" || suffix == "b",
                let accidental = Accidental(rawValue: String(suffix)) {
            self.getNextChar()
            return .note(note: note, suffix: accidental)
        }
        return .note(note: note, suffix: .none)
    }

    private mutating func tryToParseNumInt() -> Token?
    {
        guard let c = self.nextChar_ else { return nil }

        self.getNextChar()

        var s = String(c)

        loop: while self.nextChar_ != nil {
            let nc = self.nextChar_!
            switch nc {
            case "0"..."9":
                s.append(nc)
                self.getNextChar()

            default:
                break loop
            }
        }

        guard let i = Int(s) else { return nil }

        return .numInt(value: i)
    }

}
