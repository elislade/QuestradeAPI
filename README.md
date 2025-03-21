# QuestradeAPI

## 🚀 Getting Started

The **QuestradeAPI** Swift library is built around two main components:

1. **Requestable** – Defines API requests in an abstract way.
2. **Session** – Manages and executes network requests.

---

## 📌 Requestable

`Requestable` is a protocol that all API request types conform to. It acts as an abstraction over `URLRequest`, where each API endpoint is represented by a concrete type conforming to `Requestable`.

### 🔹 RequestableHandler

A `RequestableHandler` is responsible for converting an abstract `Requestable` into a concrete `URLRequest`. It fetches data and decodes it into the associated `Response` type.

By default, it uses `DefaultBuilder`, but you can swap the builder using the public setter `requestBuilder`.

### 🏗️ Built-in Request Builders

#### **1. `DefaultBuilder`**

- Constructs requests with no additional context.
- Requires a non-nil host; otherwise, it throws an error.

#### **2. `AuthResponse`**

- Stores authentication tokens and host information for the current Questrade session.
- When set as the `requestBuilder`, it automatically authorizes all outgoing requests.

#### **3. `FakeDataRequestBuilder`**

- Maps `Requestable` to a local JSON file found in the `QuestradeAPIFakes` library.
- If no matching file is found, an error is thrown.

---

## 🌐 Session

`Session` is a subclass of `URLRequestHandler` that serves as the **default** method for processing all `Requestable` requests.

### 🔹 Features

- **`ObservableObject`** – Allows SwiftUI or Combine-based observers to react to changes.
- **Global error reporting** – Exposes an `@Published errors` array.
- **Advanced logging & metrics** – Can be customized via `URLSession` delegate initialization.
- **Authorization support** – Manage auth states via `@Published var token`.

---

## 📖 Example Usage

For an example project that runs on macOS, iOS, tvOS, watchOS, and visionOS; check out the included `QuestradeAPIExample` Xcode project.

### Single Fetch Request 
```swift
Task {
    let request = QuotesRequest(symbolId: 8049)
    
    // Implicit Request
    let quotes = try await request().quotes
    
    // Explicit Request
    let quotes = try await Session.shared.perform(request).quotes
}
```

### Stream Request
```swift
let streamTask = Task {
    let request = QuotesRequest(symbolId: 8049)
    for try await quote in request.stream {
        print(quote.volumn)
    }
}

// Stop Streaming
streamTask.cancel()
```

---

## 👨‍💻 Author

- **Eli Slade** - [GitHub](https://github.com/elislade)

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

