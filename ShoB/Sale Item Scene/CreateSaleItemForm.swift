//
//  CreateSaleItemForm.swift
//  ShoB
//
//  Created by Dara Beng on 7/4/19.
//  Copyright © 2019 Dara Beng. All rights reserved.
//

import SwiftUI


/// A view used to create new sale item.
struct CreateSaleItemForm : View, CreatableForm {
    
    /// The model to create sale item.
    @Binding var model: SaleItemForm.Model
    
    var onCreate: () -> Void
    
    var onCancel: () -> Void
    
    
    // MARK: - Body
    
    var body: some View {
        SaleItemForm(model: $model, mode: .saleItem)
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(leading: cancelNavItem(), trailing: createNavItem(title: "Add"))
    }
}

#if DEBUG
struct AddSaleItemView_Previews : PreviewProvider {
    static let cud = CUDDataSource<SaleItem>(context: CoreDataStack.current.mainContext)
    static var previews: some View {
        CreateSaleItemForm(model: .constant(.init()), onCreate: {}, onCancel: {})
    }
}
#endif
