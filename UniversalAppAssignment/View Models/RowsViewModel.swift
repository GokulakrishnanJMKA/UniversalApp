//
//  RowsViewModel.swift
//  UniversalAppAssignment
//
//  Created by apple on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct RowListViewModel {
    let rows: [Row]
}

extension RowListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.rows.count
    }
    
    func rowAtIndex(_ index: Int) -> RowViewModel {
        let row = self.rows[index]
        return RowViewModel(row)
    }
}

struct RowViewModel {
    private let row: Row
}

extension RowViewModel {
    init(_ row: Row) {
        self.row = row
    }
}

extension RowViewModel {
    var title: String {
        return self.row.title ?? ""
    }
    
    var description: String {
        return self.row.rowDescription ?? ""
    }
    
    var imageHref: String {
        return self.row.imageHref ?? ""
    }
}
