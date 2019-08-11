//
//  CustomerDataSource.swift
//  ShoB
//
//  Created by Dara Beng on 8/10/19.
//  Copyright © 2019 Dara Beng. All rights reserved.
//

import CoreData


class CustomerDataSource: NSObject, DataSource {
    
    let parentContext: NSManagedObjectContext
    
    let createContext: NSManagedObjectContext
    
    let updateContext: NSManagedObjectContext
    
    let fetchedResult: NSFetchedResultsController<Customer>
    
    var newObject: Customer?
    
    var updateObject: Customer?
    
    
    required init(parentContext: NSManagedObjectContext) {
        self.parentContext = parentContext
        createContext = parentContext.newChildContext()
        updateContext = parentContext.newChildContext()
        
        let request = Object.fetchRequest() as NSFetchRequest<Object>
        request.sortDescriptors = []
        
        fetchedResult = .init(
            fetchRequest: request,
            managedObjectContext: parentContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        fetchedResult.delegate = self
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    func saveNewObject() {
        guard let customer = newObject, customer.hasValidInputs() else { return }
        saveCreateContext()
    }
    
    func saveUpdateObject() {
        guard let customer = updateObject, customer.hasValidInputs() else { return }
        customer.objectWillChange.send() // still need this (beta 5)
        
        if customer.hasPersistentChangedValues {
            saveUpdateContext()
        } else {
            discardUpdateContext()
        }
    }
}
