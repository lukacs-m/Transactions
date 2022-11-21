//
//  DetailTransactionView.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import SwiftUI

public struct DetailTransactionView: View {
    @Binding var isShowingDetail: Bool
    let transaction: TransactionUIModel
    let animation: Namespace.ID
    @State private var showInfos = false
    @State private var showActions = false

    public init(isShowingDetail: Binding<Bool>,
                transaction: TransactionUIModel,
                animation: Namespace.ID,
                showInfos: Bool = false,
                showActions: Bool = false) {
        _isShowingDetail = isShowingDetail
        self.transaction = transaction
        self.animation = animation
        self.showInfos = showInfos
        self.showActions = showActions
    }

    private enum DetailTransactionViewSize {
        static let mastHeadHight: CGFloat = 224
        static let mainIconSize: CGFloat = 56
        static let mainIconOffset: CGFloat = DetailTransactionViewSize
            .mastHeadHight / 4 - (DetailTransactionViewSize.mainIconSize / 2)
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.ignoresSafeArea()
            VStack(spacing: 24) {
                masthead
                if showInfos {
                    mainInfos
                        .transition(.moveAndScale)
                }

                if showActions {
                    actions
                        .transition(.moveAndScale)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            if showInfos {
                closeButton
                    .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation(.linear.delay(0.6)) {
                showInfos = true
            }
            withAnimation(.linear.delay(1)) {
                showActions = true
            }
        }
    }

    @ViewBuilder
    var mainInfos: some View {
        VStack(spacing: 10) {
            Text(transaction.price)
                .font(.system(size: 34, weight: .bold))
            Text(transaction.title)
                .font(.system(size: 13, weight: .semibold))
            Text(transaction.subtitle)
                .foregroundColor(.gray)
                .font(.system(size: 13, weight: .light))
        }
    }

    @ViewBuilder
    var actions: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Image(iconName: transaction.smallIcon.category)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 13).fill(transaction.mainIcon.backgroundColor)
                        .frame(width: 32, height: 32))
                Text(Strings.TitreResto.Cell.title)
                Spacer()
                Button {} label: {
                    Text(Strings.ChangeAccount.Button.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.blue)
                        .font(.system(size: 12, weight: .bold))
                }.buttonStyle(.plain)
            }
            Divider().padding(.leading, 44)
            subActions(iconName: "split", title: Strings.ShareAccount.Cell.title)
            Divider().padding(.leading, 44)
            subActions(iconName: "heart", title: Strings.Love.Cell.title)
            Divider().padding(.leading, 44)
            subActions(iconName: "question", title: Strings.SignalProblem.Cell.title)
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    func subActions(iconName: String,
                    title: String) -> some View {
        HStack(spacing: 12) {
            Image(iconName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(6)
                .background(RoundedRectangle(cornerRadius: 13).fill(Asset.Colors.Backgrounds.backgroundGray.color)
                    .frame(width: 32, height: 32))
            Text(title)
            Spacer()
        }
    }

    @ViewBuilder
    var masthead: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(transaction.mainIcon.backgroundColor)
                .matchedGeometryEffect(id: "background\(transaction.id)", in: animation)
                .frame(maxWidth: .infinity, maxHeight: DetailTransactionViewSize.mastHeadHight)
            mainIcon

            HStack {
                Spacer()
                smallIcon
            }
        }
    }

    var closeButton: some View {
        Button {
            withAnimation(.linear) {
                showInfos = false
                showActions = false
            }
            withAnimation(.linear.delay(0.4)) {
                isShowingDetail = false
            }
        } label: {
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.black)
        }.padding()
    }

    @ViewBuilder
    var mainIcon: some View {
        if let url = transaction.mainIcon.url {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
            } placeholder: {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
            }
            .frame(width: DetailTransactionViewSize.mainIconSize,
                   height: DetailTransactionViewSize.mainIconSize)
            .offset(y: DetailTransactionViewSize.mainIconOffset)
        } else {
            Image(iconName: transaction.mainIcon.category)
                .resizable()
                .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation)
                .frame(width: DetailTransactionViewSize.mainIconSize,
                       height: DetailTransactionViewSize.mainIconSize)
                .offset(y: DetailTransactionViewSize.mainIconOffset)
        }
    }

    @ViewBuilder
    var smallIcon: some View {
        if let url = transaction.smallIcon.url {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
            } placeholder: {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
            }
            .frame(width: 18, height: 18)
            .clipShape(Circle())
            .background(Circle()
                .fill(.white).frame(width: 26, height: 26)
                .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
            .offset(y: DetailTransactionViewSize.mastHeadHight / 2)
            .padding(.trailing, 20)
        } else {
            Image(iconName: transaction.smallIcon.category)
                .resizable()
                .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation)
                .frame(width: 18, height: 18)
                .background(Circle()
                    .fill(.white).frame(width: 26, height: 26)
                    .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation))
                .offset(y: DetailTransactionViewSize.mastHeadHight / 2)
                .padding(.trailing, 20)
        }
    }
}

struct DetailTransactionView_Previews: PreviewProvider {
    @Namespace static var animation
    @State var test = true
    static let transaction = TransactionUIModel(id: "test",
                                                title: "test",
                                                subtitle: "7 march",
                                                price: "-18,75 $",
                                                mainIcon: IconUIModel(type: "test", category: "test", url: nil),
                                                smallIcon: IconUIModel(type: "test", category: "test", url: nil))
    static var previews: some View {
        DetailTransactionView(isShowingDetail: .constant(true),
                              transaction: transaction,
                              animation: animation)
    }
}

private extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .opacity)
    }
}
