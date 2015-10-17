//
//  CartViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/16/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "CartViewController.h"
#import "OrderTableViewCell.h"

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource >
@property (nonatomic) float totalPrice;
@property (nonatomic) float taxRate;//PA
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Your Order";
    self.totalPrice = 0;
    self.taxRate = 0.06;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS CART "
    "(ITEM TEXT PRIMARY KEY, QUANTITY INTEGER, PRICE FLOAT, NOTE TEXT);";
    [self.dbManager executeQuery:createSQL];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from CART";
    
    // Get the results.
    if (self.itemArray != nil) {
        self.itemArray = nil;
    }
    self.itemArray = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    for(NSArray *item in self.itemArray){
        float subtotal = [[item objectAtIndex:2] intValue] * [[item objectAtIndex:3] floatValue];
        self.totalPrice += subtotal;
    }
    
    [self.myTableView reloadData];
    self.subtotalLabel.text = [NSString stringWithFormat:@"$ %.2f",self.totalPrice];
    self.taxLabel.text = [NSString stringWithFormat:@"$ %.2f",self.totalPrice * self.taxRate];
    self.totalLabel.text =
    [NSString stringWithFormat:@"$ %.2f",self.totalPrice * self.taxRate + self.totalPrice];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.itemArray == nil || [self.itemArray count] < 1){
        return 0;
    }
    return [self.itemArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"My Cart total:  $%.2f",self.totalPrice];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemInOrderCell" forIndexPath:indexPath];
    
    NSInteger indexOfName = 1;//[self.dbManager.arrColumnNames indexOfObject:@"item"];
    NSInteger indexOfQuantity = 2;//[self.dbManager.arrColumnNames indexOfObject:@"quantity"];
    NSInteger indexOfPrice = 3;//[self.dbManager.arrColumnNames indexOfObject:@"price"];
    NSInteger indexOfNote = 4;//[self.dbManager.arrColumnNames indexOfObject:@"note"];
    
    float total = [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity] intValue] * [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice] floatValue];
    // Set the loaded data to the appropriate cell labels.

    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity]];
    cell.itemNameLabel.text = [NSString stringWithFormat:@"%@($%.2f)", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfName],[[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice] floatValue]];
    cell.itemNoteField.text = [NSString stringWithFormat:@"Note: %@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfNote]];
    cell.itemPriceLabel.text = [NSString stringWithFormat:@"$ %.2f", total];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
