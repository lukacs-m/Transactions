// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
    public enum Assets {
        public enum BigIcons {
            public static let bakery = SecuredIcons(name: "bakery")
            public static let burger = SecuredIcons(name: "burger")
            public static let computer = SecuredIcons(name: "computer")
            public static let supermarket = SecuredIcons(name: "supermarket")
            public static let sushi = SecuredIcons(name: "sushi")
            public static let train = SecuredIcons(name: "train")
        }

        public enum SallIcons {
            public static let gift = SecuredIcons(name: "gift")
            public static let heart = SecuredIcons(name: "heart")
            public static let mealVoucher = SecuredIcons(name: "meal_voucher")
            public static let mobility = SecuredIcons(name: "mobility")
            public static let question = SecuredIcons(name: "question")
            public static let split = SecuredIcons(name: "split")
        }
    }

    public enum Colors {
        public enum Backgrounds {
            public static let backgroundGray = SecuredColors(name: "backgroundGray")
            public static let backgroundOrange = SecuredColors(name: "backgroundOrange")
            public static let backgroundPink = SecuredColors(name: "backgroundPink")
            public static let backgroundPurple = SecuredColors(name: "backgroundPurple")
            public static let backgroundRed = SecuredColors(name: "backgroundRed")
        }

        public enum Main {
            public static let gray = SecuredColors(name: "gray")
            public static let orange = SecuredColors(name: "orange")
            public static let pink = SecuredColors(name: "pink")
            public static let purple = SecuredColors(name: "purple")
            public static let red = SecuredColors(name: "red")
        }
    }
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class SecuredColors {
    public fileprivate(set) var name: String

    #if os(macOS)
    public typealias SystemColor = NSColor
    #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias SystemColor = UIColor
    #endif

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    public private(set) lazy var systemColor: SystemColor = {
        guard let color = SystemColor(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    public private(set) lazy var color: Color = .init(systemColor)

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension SecuredColors.SystemColor {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: SecuredColors) {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        self.init(named: NSColor.Name(asset.name), bundle: bundle)
        #elseif os(watchOS)
        self.init(named: asset.name)
        #endif
    }
}

public struct SecuredIcons {
    public fileprivate(set) var name: String

    #if os(macOS)
    public typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Image = UIImage
    #endif

    public var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
        let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        let name = NSImage.Name(name)
        let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
        let image = Image(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

public extension SecuredIcons.Image {
    @available(macOS, deprecated,
               message: "This initializer is unsafe on macOS, please use the SecuredIcons.image property")
    convenience init?(asset: SecuredIcons) {
        #if os(iOS) || os(tvOS)
        let bundle = BundleToken.bundle
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
        self.init(named: asset.name)
        #endif
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
