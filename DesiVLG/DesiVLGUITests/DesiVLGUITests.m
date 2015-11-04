//
//  DesiVLGUITests.m
//  DesiVLGUITests
//
//  Created by Yike Xue on 10/6/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DesiVLGUITests : XCTestCase

@end

@implementation DesiVLGUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"DELIVERY"] tap];
    [app.buttons[@"PICK-UP"] tap];
    [app.buttons[@"LATER"] tap];
    [app.navigationBars[@"Order for Later"].buttons[@"Options"] tap];
    [app.navigationBars[@"Order Options"].buttons[@"Bookmarks"] tap];
    [app.navigationBars[@"Info"].buttons[@"Options"] tap];
    [app.buttons[@"SELECT YOUR ITEMS"] tap];
    [app.tables.staticTexts[@"BEVERAGES"] tap];

}

- (void)firstLauch{
    //    XCUIApplication *app = [[XCUIApplication alloc] init];
    //    [app.alerts[@"Allow \U201cDesi\U201d to access your location while you use the app?"].collectionViews.buttons[@"Allow"] tap];
}
- (void)testTimePicker{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *laterButton = app.buttons[@"LATER"];
    [laterButton tap];
    [[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Order for Later"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:5] tap];
    
    XCUIElement *pmButton = app.buttons[@"PM"];
    [pmButton tap];
    
    XCUIElement *confirmDateTimeButton = app.buttons[@"CONFIRM DATE & TIME"];
    [confirmDateTimeButton tap];
    [app.buttons[@"AM"] tap];
    [confirmDateTimeButton tap];
    [laterButton tap];
    [pmButton tap];
    
    //Test date difference, element name different
//    XCUIElementQuery *tablesQuery = app.tables;
//    XCUIElement *wedStaticText = [tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"28"].staticTexts[@"Wed"];
//    [wedStaticText tap];
//    [wedStaticText tap];
//    [confirmDateTimeButton tap];
//    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"29"].staticTexts[@"Thu"] tap];
    [confirmDateTimeButton tap];
    [app.navigationBars[@"Order for Later"].buttons[@"Options"] tap];
    
}

- (void)testAddInvalidAddress{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"DELIVERY"] tap];
    [app.buttons[@"SELECT YOUR ITEMS"] tap];
    
    XCUIElement *addressTextField = app.textFields[@"Address"];
    [addressTextField tap];
    [addressTextField typeText:@"Q"];
    
    XCUIElement *deliveryNotesOptionalTextField = app.textFields[@"Delivery Notes(Optional)"];
    [deliveryNotesOptionalTextField tap];
    [deliveryNotesOptionalTextField typeText:@"w"];
    
    XCUIElement *cityTownTextField = app.textFields[@"City/Town"];
    [cityTownTextField tap];
    [cityTownTextField typeText:@"E"];
    
    XCUIElement *stateTextField = app.textFields[@"State"];
    [stateTextField tap];
    [stateTextField typeText:@"R"];
    
    XCUIElement *doneButton = app.buttons[@"Done"];
    [doneButton tap];
    
    XCUIElement *zipCodeTextField = app.textFields[@"Zip Code"];
    [zipCodeTextField tap];
    [zipCodeTextField typeText:@"t"];
    [doneButton tap];

    [app.buttons[@"DONE"] tap];
    [app.alerts[@"Warning"].collectionViews.buttons[@"Cancel"] tap];
    [app.buttons[@"CANCEL"] tap];
    
}

- (void)testAddValidAddress{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"DELIVERY"] tap];
    [app.buttons[@"SELECT YOUR ITEMS"] tap];
    
    XCUIElement *addressTextField = app.textFields[@"Address"];
    [addressTextField tap];
    [addressTextField typeText:@"4535 Larchwood Ave"];
    
    XCUIElement *deliveryNotesOptionalTextField = app.textFields[@"Delivery Notes(Optional)"];
    [deliveryNotesOptionalTextField tap];
    [deliveryNotesOptionalTextField typeText:@"note"];
    
    XCUIElement *cityTownTextField = app.textFields[@"City/Town"];
    [cityTownTextField tap];
    [cityTownTextField typeText:@"Philadelphia"];
    
    XCUIElement *stateTextField = app.textFields[@"State"];
    [stateTextField tap];
    [stateTextField typeText:@"PA"];
    
    XCUIElement *doneButton = app.buttons[@"Done"];
    [doneButton tap];
    
    XCUIElement *zipCodeTextField = app.textFields[@"Zip Code"];
    [zipCodeTextField tap];
    [zipCodeTextField typeText:@"19143"];
    [doneButton tap];
    
    XCUIElement *doneButton2 = app.buttons[@"DONE"];
    [doneButton2 tap];
    
}

- (void)testShoppingCart{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"SELECT YOUR ITEMS"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    XCUIElement *beveragesStaticText = tablesQuery.staticTexts[@"BEVERAGES"];
    [beveragesStaticText tap];
    [tablesQuery.staticTexts[@"Lassi"] tap];
    
    XCUIElement *addToOrderButton = app.buttons[@"ADD TO ORDER"];
    [addToOrderButton tap];
    
    XCUIElement *dishDetailsNavigationBar = app.navigationBars[@"Dish Details"];
    XCUIElement *shoppingCartButton = dishDetailsNavigationBar.buttons[@"Shopping Cart"];
    [shoppingCartButton tap];
    
    XCUIElement *yourOrderNavigationBar = app.navigationBars[@"Your Order"];
    [yourOrderNavigationBar.buttons[@"Clear"] tap];
    [app.alerts[@"Warning"].collectionViews.buttons[@"Sure"] tap];
    [yourOrderNavigationBar.buttons[@"Dish Details"] tap];
    [app.buttons[@"2"] tap];
    
    XCUIElement *textView = [[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Dish Details"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView tap];
    [textView typeText:@"No ice"];
    [app.staticTexts[@"Special Instructions?"] tap];
    [addToOrderButton tap];
    [dishDetailsNavigationBar.buttons[@"ITEMS"] tap];
    [beveragesStaticText tap];
    
    tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"VEGETARIAN APPETIZER"] tap];
    [tablesQuery.staticTexts[@"Bhel Puri"] tap];
    [addToOrderButton tap];
    [shoppingCartButton tap];
    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"2"].buttons[@"minus alt"] tap];
    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Lassi($2.95)"].buttons[@"minus alt"] tap];
    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"1"].buttons[@"plus alt"] tap];
    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"0"].buttons[@"plus alt"] tap];
    [app.buttons[@"CHECK OUT          "] tap];
    [app.navigationBars[@"ApplePayView"].buttons[@"Your Order"] tap];
    
}

- (void)testSubmitOrder{

    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"DELIVERY"] tap];
    [app.buttons[@"LATER"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"3"].staticTexts[@"Tue"] tap];
    [app.buttons[@"CONFIRM DATE & TIME"] tap];
    [app.buttons[@"SELECT YOUR ITEMS"] tap];
    
    XCUIElement *addressTextField = app.textFields[@"Address"];
    [addressTextField tap];
    
    //***Test for real device and simulator are different
    [addressTextField typeText:@"4109 Walnut St"];
    
//    XCUIElement *shiftButton = app.buttons[@"shift"];
//    [shiftButton tap];
//    [addressTextField typeText:@"Walnut"];
//    [app.buttons[@"Walnut"] tap];
//    [addressTextField typeText:@" "];
//    [shiftButton tap];
//    [addressTextField typeText:@"St"];
    
    XCUIElement *deliveryNotesOptionalTextField = app.textFields[@"Delivery Notes(Optional)"];
    [deliveryNotesOptionalTextField tap];
    [app.buttons[@"Next keyboard"] tap];
    [deliveryNotesOptionalTextField typeText:@"🚕"];
    
    XCUIElement *cityTownTextField = app.textFields[@"City/Town"];
    [cityTownTextField tap];
    [cityTownTextField typeText:@"Philadelphia"];
    
    XCUIElement *stateTextField = app.textFields[@"State"];
    [stateTextField tap];
    [stateTextField typeText:@"PA"];
    
    XCUIElement *doneButton = app.buttons[@"Done"];
    [doneButton tap];

    
    XCUIElement *zipCodeTextField = app.textFields[@"Zip Code"];
    [zipCodeTextField tap];
    [zipCodeTextField typeText:@"19104"];
    [doneButton tap];
    
    XCUIElement *doneButton2 = app.buttons[@"DONE"];
    [doneButton2 tap];
    
    [tablesQuery.staticTexts[@"LAMB"] tap];
    [app.tables.staticTexts[@"Achari Lamb"] tap];
    
    XCUIElement *element = [[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Dish Details"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textView = [element childrenMatchingType:XCUIElementTypeTextView].element;

    [textView tap];
    [textView typeText:@"spicy"];
    
    [app.staticTexts[@"Special Instructions?"] tap];
    

    [app.buttons[@"ADD TO ORDER"] tap];
    
    XCUIElement *dishDetailsNavigationBar = app.navigationBars[@"Dish Details"];
    [dishDetailsNavigationBar.buttons[@"Shopping Cart"] tap];
    [app.buttons[@"CHECK OUT          "] tap];
    
    XCUIElement *pleaseInputYourNameTextField = app.textFields[@"Please Input Your Name"];
    [pleaseInputYourNameTextField tap];
    [pleaseInputYourNameTextField typeText:@"Harry Potter"];

    
    XCUIElement *pleaseInputYourPhoneNumberTextField = app.textFields[@"Please Input Your Phone Number"];
    [pleaseInputYourPhoneNumberTextField tap];
    [pleaseInputYourPhoneNumberTextField typeText:@"1234567890"];
    
    [app.staticTexts[@"- YOUR CONTACT -"] tap];
    
    //***Test for real device and simulator are different
//    [app.buttons[@"PAY LATER"] tap];
//    [app.navigationBars.buttons[@"Send"] tap];
    
//    [app.buttons[@"applePay"] tap];
//    [app.navigationBars[@"PKPaymentAuthorizationServiceView"].buttons[@"Cancel"] tap];
    
    
    [app.navigationBars[@"ApplePayView"].buttons[@"Your Order"] tap];
    [app.navigationBars[@"Your Order"].buttons[@"Dish Details"] tap];
    [dishDetailsNavigationBar.buttons[@"ITEMS"] tap];
    [app.navigationBars[@"ITEMS"].buttons[@"Options"] tap];
    
}
@end
