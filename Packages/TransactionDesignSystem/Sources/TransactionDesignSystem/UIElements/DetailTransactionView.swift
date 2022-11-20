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
        static let mastHeadHight: CGFloat = 291
        static let mainIconSize: CGFloat = 56
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
            HStack {
                Image(systemName: "play")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 13).fill(.orange)
                        .frame(width: 32, height: 32))
                Text("Test of text")
                Spacer()
                Button {} label: {
                    Text("Changer \n de compte")
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.blue)
                        .font(.system(size: 12, weight: .bold))
                }.buttonStyle(.plain)
            }

            Text(transaction.price)
                .font(.system(size: 34, weight: .bold))
            Text(transaction.title)
                .font(.system(size: 13, weight: .semibold))
            Text(transaction.subtitle)
                .foregroundColor(.gray)
                .font(.system(size: 13, weight: .light))
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    var masthead: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.orange)
                .matchedGeometryEffect(id: "background\(transaction.id)", in: animation, isSource: isShowingDetail)
                .frame(maxWidth: .infinity, maxHeight: DetailTransactionViewSize.mastHeadHight)
            Image(systemName: "play")
                .resizable()
                .matchedGeometryEffect(id: "mainIcon\(transaction.id)", in: animation, isSource: isShowingDetail)
                .frame(width: DetailTransactionViewSize.mainIconSize, height: DetailTransactionViewSize.mainIconSize)
                .offset(y: DetailTransactionViewSize.mastHeadHight / 6 - (DetailTransactionViewSize.mainIconSize / 2))
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .resizable()
                    .matchedGeometryEffect(id: "smallIcon\(transaction.id)", in: animation, isSource: isShowingDetail)
                    .frame(width: 18, height: 18)
                    .background(Circle()
                        .fill(.white).frame(width: 26, height: 26)
                        .matchedGeometryEffect(id: "smallIconBack\(transaction.id)", in: animation, isSource: isShowingDetail))
                    .offset(y: DetailTransactionViewSize.mastHeadHight / 2)
                    .padding(.trailing, 20)
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

extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .opacity)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
