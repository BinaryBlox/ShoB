//
//  SaleItemListView.swift
//  ShoB
//
//  Created by Dara Beng on 6/18/19.
//  Copyright © 2019 Dara Beng. All rights reserved.
//

import SwiftUI

struct SaleItemListView: View {
    
    @EnvironmentObject var saleItemDataSource: FetchedDataSource<SaleItem>
    @EnvironmentObject var cudDataSource: CUDDataSource<SaleItem>
    
    @State var isAddingNewItem = false
    
    /// Action to perform when an item is selected.
    ///
    /// Set this block to do custom action.
    /// Otherwise, The view will show the item details.
    var onItemSelected: ((SaleItem, SaleItemListView) -> Void)?
    
    
    var body: some View {
        List(saleItemDataSource.fetchController.fetchedObjects ?? []) { saleItem in
            if self.onItemSelected == nil { // default behavior, show item details
                SaleItemRow(saleItem: saleItem.get(from: self.cudDataSource.updateContext), onUpdated: { saleItem in
                    self.cudDataSource.saveUpdateContext()
                })
            } else { // custom behavior
                Button(saleItem.name, action: { self.onItemSelected?(saleItem, self) })
            }
        }
        .navigationBarItems(trailing: addNewSaleItemNavItem)
        .presentation(isAddingNewItem ? createSaleItemForm : nil)
    }
    

    var addNewSaleItemNavItem: some View {
        Button(action: {
            self.cudDataSource.discardNewObject()
            self.cudDataSource.prepareNewObject()
            self.isAddingNewItem = true
        }, label: {
            Image(systemName: "plus").imageScale(.large)
        })
        .accentColor(.accentColor)
    }
    
    var createSaleItemForm: Modal {
        let dismiss = { self.isAddingNewItem = false }
        
        let form = CreateSaleItemForm(onCreated: dismiss, onCancelled: dismiss)
            .environmentObject(cudDataSource)
        
        return Modal(NavigationView { form }, onDismiss: dismiss)
    }
}

#if DEBUG
struct SaleItemList_Previews : PreviewProvider {
    static var previews: some View {
        SaleItemListView()
    }
}
#endif
