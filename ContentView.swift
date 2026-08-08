import SwiftUI
import UIKit

struct ContentView: View {
    @State private var text = "سڵاو دنیا"
    @State private var search = ""
    @State private var selectedStyle = FontStyle.all[0]
    @State private var favorites: Set<String> = []
    @StateObject private var store = StoreManager()

    private var filtered: [FontStyle] {
        if search.isEmpty {
            return FontStyle.all
        }
        return FontStyle.all.filter {
            $0.name.localizedCaseInsensitiveContains(search)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {

                    TextEditor(text: $text)
                        .frame(minHeight: 130)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 22))

                    HStack(spacing: 12) {

                        Button {
                            UIPasteboard.general.string =
                                selectedStyle.transform(text)
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        .buttonStyle(.borderedProminent)

                        ShareLink(
                            item: selectedStyle.transform(text)
                        ) {
                            Label(
                                "Share",
                                systemImage: "square.and.arrow.up"
                            )
                        }
                        .buttonStyle(.bordered)
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField(
                            "Search fonts",
                            text: $search
                        )
                    }
                    .padding(12)
                    .background(.thinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )

                    Text("Fonts")
                        .font(.title2.bold())
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )

                    LazyVStack(spacing: 12) {

                        ForEach(filtered) { style in

                            HStack {

                                Button {
                                    selectedStyle = style
                                } label: {

                                    VStack(
                                        alignment: .leading,
                                        spacing: 7
                                    ) {
                                        Text(style.name)
                                            .font(.headline)

                                        Text(
                                            style.transform(text)
                                        )
                                        .font(.system(size: 21))
                                        .lineLimit(2)
                                    }
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                }
                                .buttonStyle(.plain)

                                Button {
                                    if favorites.contains(style.id) {
                                        favorites.remove(style.id)
                                    } else {
                                        favorites.insert(style.id)
                                    }
                                } label: {
                                    Image(
                                        systemName:
                                            favorites.contains(style.id)
                                            ? "star.fill"
                                            : "star"
                                    )
                                    .font(.title3)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                            .background(
                                selectedStyle.id == style.id
                                ? Color.accentColor.opacity(0.15)
                                : Color.secondary.opacity(0.08)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                        }
                    }

                    VStack(spacing: 12) {

                        Image(systemName: "crown.fill")
                            .font(.largeTitle)

                        Text("Premium")
                            .font(.title2.bold())

                        Text(
                            "Unlock all styles and premium features."
                        )
                        .foregroundStyle(.secondary)

                        ForEach(store.products) { product in

                            Button {
                                Task {
                                    await store.purchase(product)
                                }
                            } label: {

                                HStack {
                                    Text(product.displayName)
                                    Spacer()
                                    Text(product.displayPrice)
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 16
                                    )
                                )
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
            .navigationTitle("Kurdish Fonts")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await store.loadProducts()
            }
        }
    }
}
