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
        static let mainIconSize: CGFloat = 56
    }

    private var isPositive: Bool {
        transaction.price.contains("+")
    }

    public var body: some View {
        HStack(spacing: 16) {
            icon
            infos
//            ZStack {
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(.orange)
//                    .matchedGeometryEffect(id: "background\(transaction.id)", in: animation)
//                    .frame(width: 56, height: 56)
//                    .overlay(RoundedRectangle(cornerRadius: 25)
//                        .stroke(.blue, lineWidth: 1))
//                Image(systemName: "play")
//                    .resizable()
//                    .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
//                    .frame(width: 28, height: 28)
//                Image(systemName: "xmark")
//                    .resizable()
//                    .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
//                    .frame(width: 12, height: 12)
//                    .background(Circle()
//                        .fill(.white).frame(width: 20, height: 20)
//                        .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
            ////                    .padding(2)
            ////                    .background(.white)
            ////                    .clipShape(Circle())
            ////                    .overlay(Circle()
            ////                        .stroke(.white, lineWidth: 3))
//                    .offset(x: 56 / 2 - 6, y: 56 / 2 - 6)
//            }
            Spacer()
        }
    }

    private var icon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.orange)
                .matchedGeometryEffect(id: "background\(transaction.id)", in: animation)
                .frame(width: 56, height: 56)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(.blue, lineWidth: 1))
            Image(systemName: "play")
                .resizable()
                .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
                .frame(width: 28, height: 28)
            Image(systemName: "xmark")
                .resizable()
                .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
                .frame(width: 12, height: 12)
                .background(Circle()
                    .fill(.white).frame(width: 20, height: 20)
                    .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
                .offset(x: 56 / 2 - 6, y: 56 / 2 - 6)
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
