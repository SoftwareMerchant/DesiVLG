//
//  CartViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/16/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "CartViewController.h"
#import "OrderTableViewCell.h"
#import "ApplePayViewController.h"

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource, CellUpdateDelegate>
@property (nonatomic) float totalPrice;
@property (nonatomic) float taxRate;//PA
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.title = @"Your Order";
    self.taxRate = 0.06;//PA tax
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearCart)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS CART (ID INTEGER PRIMARY KEY AUTOINCREMENT, ITEM TEXT, QUANTITY INTEGER, PRICE FLOAT, NOTE TEXT);";
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
    self.totalPrice = 0;
    for(NSArray *item in self.itemArray){
        float subtotal = [[item objectAtIndex:2] intValue] * [[item objectAtIndex:3] floatValue];
        self.totalPrice += subtotal;
    }
    
    [self.myTableView reloadData];
    self.subtotalLabel.text = [NSString stringWithFormat:@"$ %.2f",self.totalPrice];
    self.taxLabel.text = [NSString stringWithFormat:@"$ %.2f",self.totalPrice * self.taxRate];
    self.totalLabel.text =
    [NSString stringWithFormat:@"$ %.2f",self.totalPrice * self.taxRate + self.totalPrice];
    
    if(self.totalPrice == 0){
        self.checkOutBtn.enabled = NO;
        self.checkOutBtn.alpha = 0.8;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.checkOutBtn.enabled = YES;
        self.checkOutBtn.alpha = 1;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

-(void)clearCart{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                             message:@"It is going to clear the cart, are you sure?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertController addAction:actionCancel];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Sure"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [self clearConfirm];
                                   
                               }];
    
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)clearConfirm{
    NSString *removeSQL = @"drop table if exists cart";
    [self.dbManager executeQuery:removeSQL];
    [self loadData];
}

- (void)updateCart{
    [self loadData];
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
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [NSString stringWithFormat:@"My Cart total:  $%.2f",self.totalPrice];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemInOrderCell" forIndexPath:indexPath];
    
    NSInteger indexOfName = 1;//[self.dbManager.arrColumnNames indexOfObject:@"item"];
    NSInteger indexOfQuantity = 2;//[self.dbManager.arrColumnNames indexOfObject:@"quantity"];
    NSInteger indexOfPrice = 3;//[self.dbManager.arrColumnNames indexOfObject:@"price"];
    NSInteger indexOfNote = 4;//[self.dbManager.arrColumnNames indexOfObject:@"note"];
    
    float total = [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity] intValue] * [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice] floatValue];
    // Set the loaded data to the appropriate cell labels.

    cell.unitPrice = [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice] floatValue];
    cell.name = [NSString stringWithFormat:@"%@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfName]];
    cell.note = [NSString stringWithFormat:@"%@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfNote]];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity]];
    if([cell.quantityLabel.text isEqualToString:@"0"]){
        cell.downBtn.enabled = NO;
        cell.itemPriceLabel.alpha = 0.4;
        cell.itemNameLabel.alpha = 0.4;
        cell.itemNoteField.alpha = 0.4;
    }else{
        cell.downBtn.enabled = YES;
        cell.itemPriceLabel.alpha = 1;
        cell.itemNameLabel.alpha = 1;
        cell.itemNoteField.alpha = 1;
    }
    cell.itemNameLabel.text = [NSString stringWithFormat:@"%@($%.2f)", cell.name,cell.unitPrice];
    cell.itemNoteField.text = [NSString stringWithFormat:@"Note: %@", cell.note];
    [cell.itemNoteField setContentOffset:CGPointZero animated:YES];
    cell.itemPriceLabel.text = [NSString stringWithFormat:@"$ %.2f", total];
    cell.delegate = self;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"checkOut"]){
        ApplePayViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setSubtotal:)]) {
            destination.subtotal = self.totalPrice;
        }
        if ([destination respondsToSelector:@selector(setTax:)]) {
            destination.tax = self.totalPrice * self.taxRate;
        }
    }
}


@end
