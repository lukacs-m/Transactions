//
//  TransactionCell.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import SwiftUI

public struct TransactionCell: View {
    let transaction: TransactionUIModel
    let animation: Namespace.ID

    public init(transaction: TransactionUIModel, animation: Namespace.ID) {
        self.transaction = transaction
        self.animation = animation
    }

    private enum TransactionCellSize {
        static let mastHeadHight: CGFloat = 291
        static let mainIconSize: CGFloat = 28
        static let backgroundColorSize: CGFloat = 56
        static let smallIconSize: CGFloat = 12
        static let smallIconBackground: CGFloat = 20

        static let smallIconOffset: CGSize = .init(width: backgroundColorSize / 2 - smallIconSize / 2,
                                                   height: backgroundColorSize / 2 - smallIconSize / 2)
    }

    private var isPositive: Bool {
        transaction.price.contains("+")
    }

    public var body: some View {
        HStack(spacing: 16) {
            icon
            infos
        }
    }

    private var icon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(transaction.mainIcon.backgroundColor)
                .matchedGeometryEffect(id: "background\(transaction.id)", in: animation)
                .frame(width: TransactionCellSize.backgroundColorSize,
                       height: TransactionCellSize.backgroundColorSize)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(transaction.mainIcon.color.opacity(0.06), lineWidth: 1))
            mainIcon
            smallIcon
        }
    }

    private var infos: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(transaction.title)
                    .foregroundColor(.black)
                Spacer()
                Text(transaction.price)
                    .foregroundColor(isPositive ? .purple : .black)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(priceBackground)
            }.font(.system(size: 15, weight: .semibold))
            Text(transaction.subtitle)
                .foregroundColor(.gray)
                .font(.system(size: 12, weight: .light))
        }
    }

    @ViewBuilder
    var priceBackground: some View {
        if isPositive {
            RoundedRectangle(cornerRadius: 9)
                .fill(.purple.opacity(0.4))
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    var mainIcon: some View {
        if let url = transaction.mainIcon.url {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
                    .frame(width: TransactionCellSize.mainIconSize,
                           height: TransactionCellSize.mainIconSize)
            } placeholder: {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
            }
        } else {
            Image(iconName: transaction.mainIcon.category)
                .resizable()
                .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
                .frame(width: TransactionCellSize.mainIconSize,
                       height: TransactionCellSize.mainIconSize)
        }
    }

    @ViewBuilder
    var smallIcon: some View {
        if let url = transaction.smallIcon.url {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .smallIconModifier(id: transaction.id,
                                       size: TransactionCellSize.smallIconSize,
                                       backgroundSize: TransactionCellSize.smallIconBackground,
                                       offset: TransactionCellSize.smallIconOffset,
                                       animation: animation)
//                    .resizable()
//                    .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
//                    .frame(width: TransactionCellSize.smallIconSize,
//                           height: TransactionCellSize.smallIconSize)
//                    .clipShape(Circle())
//                    .background(Circle()
//                        .fill(.white).frame(width: 20, height: 20)
//                        .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
//                    .offset(x: 56 / 2 - 6, y: 56 / 2 - 6)
            } placeholder: {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
            }
        } else {
            Image(iconName: transaction.smallIcon.category)
                .smallIconModifier(id: transaction.id,
                                   size: TransactionCellSize.smallIconSize,
                                   backgroundSize: TransactionCellSize.smallIconBackground,
                                   offset: TransactionCellSize.smallIconOffset,
                                   animation: animation)
//                .resizable()
//                .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
//                .frame(width: TransactionCellSize.smallIconSize,
//                       height: TransactionCellSize.smallIconSize)
//                .clipShape(Circle())
//                .background(Circle()
//                    .fill(.white).frame(width: 20, height: 20)
//                    .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
//                .offset(x: 56 / 2 - 6, y: 56 / 2 - 6)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @Namespace static var animation
    static let transaction = TransactionUIModel(id: "test",
                                                title: "test",
                                                subtitle: "7 march",
                                                price: "+18,75 $",
                                                mainIcon: IconUIModel(type: "test", category: "test", url: nil),
                                                smallIcon: IconUIModel(type: "test", category: "test", url: nil))
    static var previews: some View {
        TransactionCell(transaction: transaction,
                        animation: animation)
    }
}

extension Image {
    func smallIconModifier(id: String,
                           size: CGFloat,
                           backgroundSize: CGFloat,
                           offset: CGSize,
                           animation: Namespace.ID) -> some View {
        resizable()
            .matchedGeometryEffect(id: "smallIcon\(id)", in: animation)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .background(Circle()
                .fill(.white).frame(width: backgroundSize, height: backgroundSize)
                .matchedGeometryEffect(id: "smallIconBack\(id)", in: animation))
            .offset(offset)
    }
}
