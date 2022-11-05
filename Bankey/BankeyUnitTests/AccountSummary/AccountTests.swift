//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Supapon Pucknavin on 5/11/2565 BE.
//

import Foundation
import XCTest

@testable import Bankey

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        // Game on here 🕹
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let results = try! decoder.decode([Account].self, from: data)
        
        XCTAssertEqual(results.count, 2)
        
        XCTAssertEqual(results[0].id, "1")
        XCTAssertEqual(results[0].type, .Banking)
        XCTAssertEqual(results[0].name, "Basic Savings")
        XCTAssertEqual(results[0].amount, 929466.23)
        XCTAssertEqual(results[0].createdDateTime.monthDayYearString, "Jun 21, 2010")
    }
}
