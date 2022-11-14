//
//  TransactionsView.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//
//

import DesignSystem
import SwiftUI

struct TransactionsView: View {
    @StateObject private var viewModel = TransactionsViewModel()
    @Namespace private var animation
    @State private var selectedTransation: Transaction?
    @State private var showFullScreen = false

    var body: some View {
        NavigationStack {
            mainContainer
        }.overlay {
            fullScreen
        }
    }

//    @ViewBuilder
//    private var overlayView: some View {
//        switch viewModel.pageState {
//        case .loading:
//            LoadingView(title: "Loading")
//                .task(loadData)
//        case .empty:
//            VStack {
//                Text("No transactions found")
//            }
//        case let .error(errorDescription):
//            Text(" ")
    ////            GenericFullScreenTextViewUI(title: "Error content \(errorDescription)".toLocalisedKey,
    ////                                        retryAction: { viewModel.reloadContent() })
//        default:
//            EmptyView()
//        }
//    }
}

private extension TransactionsView {
    @ViewBuilder
    var mainContainer: some View {
        ZStack {
            loadedView
        }
        .navigationTitle("Titre resto")
    }

    @ViewBuilder
    private var fullScreen: some View {
        if showFullScreen, let selectedTransation = selectedTransation?.toFullScreenModel {
            FullScreenTransaction(model: selectedTransation, show: $showFullScreen, namespace: animation)
        } else {
            EmptyView()
        }
    }
}

private extension TransactionsView {
    var loadedView: some View {
        List {
            ForEach(viewModel.transactions, id: \.month) { item in
                Section(header: Text(item.month.name)) {
                    ForEach(item.transactions) { item in
                        TransactionCell(model: item.toTransactionCellModel, namespace: animation)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    self.selectedTransation = item
                                    self.showFullScreen.toggle()
                                }
                            }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
