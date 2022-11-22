// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
    public enum ChangeAccount {
        public enum Button {
            /// Changer
            ///  de compte
            public static let title = Strings.tr("Localizable", "ChangeAccount.Button.Title", fallback: "Changer \n de compte")
        }
    }

    public enum Love {
        public enum Cell {
            /// Aimer
            public static let title = Strings.tr("Localizable", "Love.Cell.Title", fallback: "Aimer")
        }
    }

    public enum ShareAccount {
        public enum Cell {
            /// Partage d'addition
            public static let title = Strings.tr("Localizable", "ShareAccount.Cell.Title", fallback: "Partage d'addition")
        }
    }

    public enum SignalProblem {
        public enum Cell {
            /// Signaler un problème
            public static let title = Strings.tr("Localizable", "SignalProblem.Cell.Title", fallback: "Signaler un problème")
        }
    }

    public enum TitreResto {
        public enum Cell {
            /// Titres-resto
            public static let title = Strings.tr("Localizable", "TitreResto.Cell.Title", fallback: "Titres-resto")
        }
    }

    public enum TransactionView {
        /// Localizable.strings
        ///
        ///
        ///   Created by Martin Lukacs on 20/11/2022.
        public static let title = Strings.tr("Localizable", "TransactionView.Title", fallback: "Titres-resto")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
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
