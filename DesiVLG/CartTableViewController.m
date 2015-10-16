//
//  CartTableViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/13/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "CartTableViewController.h"

@interface CartTableViewController ()
@property (nonatomic) float totalPrice;
@end

@implementation CartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Food Cart";
    self.totalPrice = 0;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS CART "
    "(ITEM TEXT PRIMARY KEY, QUANTITY INTEGER, PRICE FLOAT, NOTE TEXT);";
    [self.dbManager executeQuery:createSQL];
    [self loadData];
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
        float subtotal = [[item objectAtIndex:1] intValue] * [[item objectAtIndex:2] floatValue];
        self.totalPrice += subtotal;
    }
    
    // Reload the table view.
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfName = 0;//[self.dbManager.arrColumnNames indexOfObject:@"item"];
    NSInteger indexOfQuantity = 1;//[self.dbManager.arrColumnNames indexOfObject:@"quantity"];
    NSInteger indexOfPrice = 2;//[self.dbManager.arrColumnNames indexOfObject:@"price"];
    NSInteger indexOfNote = 3;//[self.dbManager.arrColumnNames indexOfObject:@"note"];
    
    float total = [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity] intValue] * [[[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice] floatValue];
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ \n($%@ x %@) Total: $%.2f", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfName],  [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfPrice], [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfQuantity],total];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Note: %@", [[self.itemArray objectAtIndex:indexPath.row] objectAtIndex:indexOfNote]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
