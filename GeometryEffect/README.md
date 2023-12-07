# SwiftUI Matched Geometry Effect Showcase

This repository contains SwiftUI code snippets showcasing the usage of matched geometry effects to create synchronized animations between views.

## Introduction

Matched geometry effect is a powerful feature in SwiftUI that allows you to create smooth transitions and animations between different views. This repository provides examples and snippets to help you understand and implement matched geometry effects in your SwiftUI projects.

### Example: Basic Matched Geometry Effect

```swift
struct ContentView: View {
    @Namespace private var namespace

    var body: some View {
        VStack {
            // View 1
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .matchedGeometryEffect(id: "exampleView", in: namespace)

            // Spacer or other content

            // View 2
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .matchedGeometryEffect(id: "exampleView", in: namespace)
        }
    }
}
