//
//  StargazersUITests.swift
//  StargazersUITests
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import XCTest
@testable import Stargazers

class StargazersUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
   
    func tesSearchUseCase() {
        let app = XCUIApplication()
        let ownerInputText = "KnuffApp"
        let repoInputText = "Knuff"
        app.navigationBars.buttons.element(boundBy: 0).tap()
        _ = app.textFields["AccessibilityIdentifierOwnerField"].waitForExistence(timeout: 2)
        app.textFields["AccessibilityIdentifierOwnerField"].typeText(ownerInputText)
        app.textFields["AccessibilityIdentifierRepoField"].tap()
        app.textFields["AccessibilityIdentifierRepoField"].typeText(repoInputText)
        app.buttons["AccessibilityIdentifierConfirmBrn"].tap()
        sleep(5)
    }
    
    func testNotFoundSearchUseCase() {
        let app = XCUIApplication()
        let wrongOwnerInputText = "KnuffApp"
        let wrongRepoInputText = "Knufffff"
        app.navigationBars.buttons.element(boundBy: 0).tap()
        _ = app.textFields["AccessibilityIdentifierOwnerField"].waitForExistence(timeout: 2)
        app.textFields["AccessibilityIdentifierOwnerField"].typeText(wrongOwnerInputText)
        app.textFields["AccessibilityIdentifierRepoField"].tap()
        app.textFields["AccessibilityIdentifierRepoField"].typeText(wrongRepoInputText)
        app.buttons["AccessibilityIdentifierConfirmBrn"].tap()
        sleep(5)
    }
    
    func testNoStargazersSearchUseCase() {
        
        let app = XCUIApplication()
        
        // Search for Nocodb / Nocodb
        let OwnerInputText = "aleUnix"
        let repoInputText = "aqrCode"
        app.navigationBars.buttons.element(boundBy: 0).tap()
        _ = app.textFields["AccessibilityIdentifierOwnerField"].waitForExistence(timeout: 2)
        app.textFields["AccessibilityIdentifierOwnerField"].typeText(OwnerInputText)
        app.textFields["AccessibilityIdentifierRepoField"].tap()
        app.textFields["AccessibilityIdentifierRepoField"].typeText(repoInputText)
        app.buttons["AccessibilityIdentifierConfirmBrn"].tap()
        sleep(5)
        
    }
    
    func testDialogCancelBtn() {
        let app = XCUIApplication()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        _ = app.textFields["AccessibilityIdentifierCancelBrn"].waitForExistence(timeout: 2)
        app.buttons["AccessibilityIdentifierCancelBrn"].tap()
        sleep(5)
    }
 
}
