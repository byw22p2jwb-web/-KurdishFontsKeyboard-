import Foundation

struct FontStyle: Identifiable, Hashable {
    let id: String
    let name: String

    func transform(_ text: String) -> String {
        switch id {
        case "normal":
            return text
        case "bold":
            return "𝙱" + text
        case "wide":
            return text.map { String($0) }.joined(separator: " ")
        case "stars":
            return "★ " + text + " ★"
        case "heart":
            return "♡ " + text + " ♡"
        case "bracket":
            return "『" + text + "』"
        case "flower":
            return "✿ " + text + " ✿"
        case "diamond":
            return "◆ " + text + " ◆"
        case "cute":
            return "꒰ " + text + " ꒱"
        case "line":
            return "━━ " + text + " ━━"
        default:
            return text
        }
    }

    static let all: [FontStyle] = [
        FontStyle(id: "normal", name: "Normal"),
        FontStyle(id: "bold", name: "Bold"),
        FontStyle(id: "wide", name: "Wide"),
        FontStyle(id: "stars", name: "Stars"),
        FontStyle(id: "heart", name: "Heart"),
        FontStyle(id: "bracket", name: "Bracket"),
        FontStyle(id: "flower", name: "Flower"),
        FontStyle(id: "diamond", name: "Diamond"),
        FontStyle(id: "cute", name: "Cute"),
        FontStyle(id: "line", name: "Decorated")
    ]
}
