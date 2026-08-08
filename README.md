# -KurdishFontsKeyboard- import SwiftUI

struct ContentView: View {
    @State private var text = "سڵاو دنیا"
    @State private var search = ""
    @State private var selectedStyle = FontStyle.all[0]
    @State private var favorites: Set<String> = []
    @StateObject private var store = StoreManager()

    private var filtered: [FontStyle] {
        if search.isEmpty { return FontStyle.all }
        return FontStyle.all.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    TextEditor(text: $text)
                        .frame(minHeight: 120)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 22))

                    HStack {
                        Button("Copy") {
                            UIPasteboard.general.string = selectedStyle.transform(text)
                        }
                        .buttonStyle(.borderedProminent)

                        ShareLink(item: selectedStyle.transform(text)) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .buttonStyle(.bordered)
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search fonts", text: $search)
                    }
                    .padding(12)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    LazyVStack(spacing: 12) {
                        ForEach(filtered) { style in
                            Button {
                                selectedStyle = style
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(style.name)
                                            .font(.headline)
                                        Text(style.transform(text))
                                            .font(.system(size: 21))
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    Button {
                                        if favorites.contains(style.id) {
                                            favorites.remove(style.id)
                                        } else {
                                            favorites.insert(style.id)
                                        }
                                    } label: {
                                        Image(systemName: favorites.contains(style.id) ? "star.fill" : "star")
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding()
                                .background(selectedStyle.id == style.id ? Color.accentColor.opacity(0.14) : Color.secondary.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    VStack(spacing: 10) {
                        Text("Premium")
                            .font(.title2.bold())
                        Text("Unlock all styles and remove ads.")
                            .foregroundStyle(.secondary)

                        ForEach(store.products) { product in
                            Button {
                                Task { await store.purchase(product) }
                            } label: {
                                HStack {
                                    Text(product.displayName)
                                    Spacer()
                                    Text(product.displayPrice)
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
                    .padding(.top, 12)
                }
                .padding()
            }
            .navigationTitle("Kurdish Fonts")
            .task { await store.loadProducts() }
        }
    }
}
