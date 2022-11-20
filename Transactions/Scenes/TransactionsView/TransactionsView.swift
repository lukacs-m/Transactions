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

//    var body: some View {
//        NavigationStack {
//            ZStack {
//                if let selectedTransation = selectedTransation, isShowingDetailedScreen {
//                    DetailTransactionView(isShowingDetail: $isShowingDetailedScreen,
//                                          transaction: selectedTransation.toDetailScreenModel,
//                                          animation: animation)
    ////                    .navigationBarTitle(" ")
    ////                    .navigationBarHidden(true)
//
//                } else {
//                    //                    ScrollView(.vertical, showsIndicators: false) {
//                    //                        LazyVStack {
//                    //                            ForEach(viewModel.transactions, id: \.month) { item in
//                    //                                Section(header: Text(item.month.name)) {
//                    //                                    ForEach(item.transactions) { item in
//                    //                                        TransactionCell(transaction: item.toTransactionCellModel, animation: animation)
//                    //                                            //                                            .listRowSeparator(.hidden)
//                    //                                            .onTapGesture {
//                    //                                                withAnimation(.linear) {
//                    //                                                    self.selectedTransation = item
//                    //                                                    self.isShowingDetailedScreen = true
//                    //                                                }
//                    //                                            }
//                    //                                    }
//                    //                                }
//                    //                            }
//                    //                        }
//                    //                    }
//                    List {
//                        ForEach(viewModel.transactions, id: \.month) { item in
//                            Section(header: Text(item.month.name)) {
//                                ForEach(item.transactions) { item in
//                                    TransactionCell(transaction: item.toTransactionCellModel, animation: animation)
//                                        .listRowSeparator(.hidden)
//                                        .onTapGesture {
//                                            withAnimation(.linear) {
//                                                self.selectedTransation = item
//                                                self.isShowingDetailedScreen.toggle()
//                                            }
//                                        }
//                                }
//                            }
//                        }
//                    }
//                    .listStyle(.plain)
//                    .refreshable {
//                        viewModel.loadData()
//                    }
//                    .padding(.horizontal)
//                    .navigationBarTitle(isShowingDetailedScreen ? " " : "Test title")
//                }
//            }
//            .overlay {
//                overlayView
//            }
//            //
//        //            .navigationViewStyle(.stack)
//            ////            .animation(.default, value: isShowingDetailedScreen) //
//        }
//    }

//    @ViewBuilder
//    var test: some View {
//        if let selectedTransation = selectedTransation, isShowingDetailedScreen {
//            DetailTransactionView(isShowingDetail: $isShowingDetailedScreen,
//                                  transaction: selectedTransation.toDetailScreenModel,
//                                  animation: animation)
//        } else {
//            NavigationStack {
//                List {
//                    ForEach(viewModel.transactions, id: \.month) { item in
//                        Section(header: Text(item.month.name)) {
//                            ForEach(item.transactions) { item in
//                                TransactionCell(transaction: item.toTransactionCellModel, animation: animation)
//                                    .listRowSeparator(.hidden)
//                                    .onTapGesture {
//                                        withAnimation(.linear) {
//                                            self.selectedTransation = item
//                                            self.isShowingDetailedScreen.toggle()
//                                        }
//                                    }
//                            }
//                        }
//                    }
//                }
    ////                .listStyle(.plain)
    ////                .refreshable {
    ////                    viewModel.loadData()
    ////                }
    ////                .padding(.horizontal)
    ////                .navigationBarTitle(isShowingDetailedScreen ? " " : "Test title")
//                .overlay {
//                    overlayView
//                }
//            }
//        }
//    }

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

//
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
        .navigationBarTitle("Titre resto")
    }

    @ViewBuilder
    private var fullScreen: some View {
        if isShowingDetailedScreen, let selectedTransation = selectedTransation?.toDetailScreenModel {
//            FullScreenTransaction(model: selectedTransation, show: $showFullScreen, namespace: animation)
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
//                        TransactionCell(model: item.toTransactionCellModel, namespace: animation)
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

// struct DetailTransactionView: View {
//    @Binding var isShowingDetail: Bool
//    let transaction: TransactionUIModel
//    let animation: Namespace.ID
//    var body: some View {
//        VStack {
//            ZStack {
//                Rectangle()
//                    .fill(.orange)
//                    .frame(width: 600, height: 291)
//                Image(systemName: "play")
//                    .resizable()
//                    .frame(width: 56, height: 56)
//
//                Image(systemName: "xmark")
//                    .resizable()
//                    .frame(width: 18, height: 18)
//            }
////        CardView(item: item)
////          .matchedGeometryEffect(id: item.id, in: animation)
////          .onTapGesture {
////                isShowingDetail = false
////          }
////          ScrollView(.vertical, showsIndicators: false) {
////            Text("Lorem ipsum dolor...")
////          }
//        }
//        .padding(.horizontal)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationViewStyle(.stack)
//    }
// }

////
// struct ListView: View {
//  @State private var selectedCard: Model?
//  @State private var isShowingCard: Bool = false
//  @Namespace var animation
//  var body: some View {
//      NavigationView {
//        ZStack {         // container !!
//          if let selectedCard = selectedCard, isShowingCard {
//            DetailView(
//              isShowingDetail: $isShowingCard,
//              item: selectedCard,
//              animation: animation
//            )
//          } else {
//            ScrollView(.vertical, showsIndicators: false) {
//              ForEach(mockItems) { item in
//                CardView(item: item)
//                  .matchedGeometryEffect(id: item.id, in: animation)
//                  .onTapGesture {
//                      selectedCard = item
//                      isShowingCard = true
//                  }
//              }
//            }
//            .navigationTitle("Test title")
//          }
//      }
//      .padding(.horizontal)
//      .navigationViewStyle(.stack)
//      .animation(.default, value: isShowingCard)   // << animated here !!
//    }
//  }
// }

// struct TransactionCell: some View {
//    var body: some View {
//        NavigationStack {
//            mainContainer
//        }
//    }
// }
