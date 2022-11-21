//
//  TransactionsView.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//
//

import SwiftUI
import TransactionDesignSystem

struct TransactionsView: View {
    @StateObject private var viewModel = TransactionsViewModel()
    @Namespace private var animation
    @State private var selectedTransation: Transaction?
    @State private var isShowingDetailedScreen = false

    var body: some View {
        NavigationStack {
            mainContainer
        }
        .overlay {
            overlayView
        }
        .overlay {
            fullScreen
        }
    }

    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.pageState {
        case .loading:
            LoadingView(title: "Loading")
                .onAppear {
                    viewModel.loadData()
                }
        case let .error(errorDescription):
            Text(errorDescription)
        default:
            EmptyView()
        }
    }
}

private extension TransactionsView {
    @ViewBuilder
    var mainContainer: some View {
        ZStack {
            loadedView
        }
        .navigationBarTitle(Strings.TransactionView.title)
    }

    @ViewBuilder
    private var fullScreen: some View {
        if isShowingDetailedScreen, let selectedTransation = selectedTransation?.toDetailScreenModel {
            DetailTransactionView(isShowingDetail: $isShowingDetailedScreen, transaction: selectedTransation,
                                  animation: animation)
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
                        TransactionCell(transaction: item.toTransactionCellModel, animation: animation)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    self.selectedTransation = item
                                    self.isShowingDetailedScreen.toggle()
                                }
                            }
                    }
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.loadData()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
