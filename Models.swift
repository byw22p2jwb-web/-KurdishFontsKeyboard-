import Foundation

struct FontStyle: Identifiable, Hashable {
    let id: String
    let name: String
    let transform: (String) -> String

    static let all: [FontStyle] = [
        FontStyle(
            id: "normal",
            name: "Normal",
            transform: { $0 }
        ),
        FontStyle(
            id: "bold",
            name: "Bold",
            transform: { "𝙱" + $0 }
        ),
        FontStyle(
            id: "wide",
            name: "Wide",
            transform: { $0.map { String($0) }.joined(separator: " ") }
        ),
        FontStyle(
            id: "stars",
            name: "Stars",
            transform: { "★ " + $0 + " ★" }
        ),
        FontStyle(
            id: "heart",
            name: "Heart",
            transform: { "♡ " + $0 + " ♡" }
        ),
        FontStyle(
            id: "bracket",
            name: "Bracket",
            transform: { "『" + $0 + "』" }
        ),
        FontStyle(
            id: "flower",
            name: "Flower",
            transform: { "✿ " + $0 + " ✿" }
        ),
        FontStyle(
            id: "diamond",
            name: "Diamond",
            transform: { "◆ " + $0 + " ◆" }
        ),
        FontStyle(
            id: "cute",
            name: "Cute",
            transform: { "꒰ " + $0 + " ꒱" }
        ),
        FontStyle(
            id: "line",
            name: "Decorated",
            transform: { "━━ " + $0 + " ━━" }
        )
    ]
}
