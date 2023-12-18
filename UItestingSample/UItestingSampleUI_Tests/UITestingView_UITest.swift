//
//  UITestingView_UITest.swift
//  UItestingSampleUI_Tests
//
//  Created by Ritwik Singh on 18/12/23.
//

import XCTest

final class UITestingView_UITest: XCTestCase {
    
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ContentView_SignUpButton_ShouldNotSignIn() throws {
        
        // Given
        let textfield = app.textFields["SignUpTextField"]
        
        // When
        textfield.tap()

        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertFalse(navBar.exists)
    }
    
    func test_ContentView_SignUpButton_ShouldSignIn() throws {
        
        
        let textfield = app.textFields["SignUpTextField"]
        
        textfield.tap()
        let KeyA = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        KeyA.tap()
        let Keya = app.keys["a"]
        Keya.tap()
        Keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navBar.exists)
        
    }
    
    func test_SignedInHomeView_ShowAlertButton_ShouldPopAlert() throws {
        let textfield = app.textFields["SignUpTextField"]
        
        textfield.tap()
        let KeyA = app.keys["A"]
        KeyA.tap()
        let Keya = app.keys["a"]
        Keya.tap()
        Keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navBar.exists)
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        // at a time only one alert exists
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_ShowAlertButton_ShouldPopAlertAndDismiss() throws {
        
        let textfield = app.textFields["SignUpTextField"]
        
        textfield.tap()
        let KeyA = app.keys["A"]
        KeyA.tap()
        let Keya = app.keys["a"]
        Keya.tap()
        Keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navBar.exists)
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        // at a time only one alert exists
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)

        let alertOKButton = alert.buttons["OK"]
//        XCTAssertTrue(alertOKButton.exists)
//        sleep(1)
        let exists = alertOKButton.waitForExistence(timeout: 5)
        XCTAssertTrue(exists)
        alertOKButton.tap()
//        sleep(1)
        let alertExists = alert.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
        
    }
    
    func test_SignedInHomeView_NavigationLinkToDestination_ShouldNavigateToDestination() throws {
        let textfield = app.textFields["SignUpTextField"]
        
        textfield.tap()
        let KeyA = app.keys["A"]
        KeyA.tap()
        let Keya = app.keys["a"]
        Keya.tap()
        Keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navBar.exists)
        
        let naviLinkButton = app.buttons["NavigationLinkToDestination"]
        naviLinkButton.tap()
        
        
        let detinationText = app.staticTexts["Destination"]
        XCTAssertTrue(detinationText.exists)
        
        let backButton = app.navigationBars.buttons["Welcome"]
        backButton.tap()
        
        XCTAssertTrue(navBar.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
