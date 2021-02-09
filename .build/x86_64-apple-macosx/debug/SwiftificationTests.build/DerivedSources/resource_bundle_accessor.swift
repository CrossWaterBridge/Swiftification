import class Foundation.Bundle

extension Foundation.Bundle {
    static var module: Bundle = {
        let mainPath = Bundle.main.bundlePath + "/" + "Swiftification_SwiftificationTests.bundle"
        let buildPath = "/Users/jessicalemon/Projects/Swiftification/.build/x86_64-apple-macosx/debug/Swiftification_SwiftificationTests.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle != nil ? preferredBundle : Bundle(path: buildPath) else {
            fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}