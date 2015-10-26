//
//  OrderTableViewCell.m
//  DesiVLG
//
//  Created by Yike Xue on 10/16/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(Boolean)updateData{
    // Form the query.
    NSString *query = [NSString stringWithFormat: @"select * from CART where ITEM = '%@' AND NOTE = '%@'",self.name, self.note];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    NSArray *result = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (result != nil && [result count] > 0) {
        NSInteger indexOfID = 0;//[self.dbManager.arrColumnNames indexOfObject:@"id"];
        int existID = [[[result objectAtIndex:0] objectAtIndex:indexOfID] intValue];
        NSString *updateQuery = [NSString stringWithFormat: @"update CART set QUANTITY = %d WHERE ID = %d", [self.quantityLabel.text intValue],  existID];
        
        // Execute the query.
        [self.dbManager executeQuery:updateQuery];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Update query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
            self.itemPriceLabel.text = [NSString stringWithFormat:@"$ %.2f",self.unitPrice*[self.quantityLabel.text intValue]];
            [self.delegate updateCart];
            return YES;
        }
        else{
            NSLog(@"Could not execute the query.");
        }
    }
    NSLog(@"Fail to update quantity");
    return NO;
    
}

- (IBAction)tapUpBtn:(id)sender {
    int curQuan = [self.quantityLabel.text intValue];
    self.quantityLabel.text = [NSString stringWithFormat:@"%d",curQuan+1];
    if(![self updateData]){
        self.quantityLabel.text = [NSString stringWithFormat:@"%d",curQuan];
    }
    curQuan = [self.quantityLabel.text intValue];
    if(curQuan == 1){
        self.downBtn.enabled = YES;
        self.itemPriceLabel.alpha = 1;
        self.itemNameLabel.alpha = 1;
        self.itemNoteField.alpha = 1;
    }
    
}

- (IBAction)tapDownBtn:(id)sender {
    int curQuan = [self.quantityLabel.text intValue];
    self.quantityLabel.text = [NSString stringWithFormat:@"%d",curQuan-1];
    if(![self updateData]){
        self.quantityLabel.text = [NSString stringWithFormat:@"%d",curQuan];
    }
    curQuan = [self.quantityLabel.text intValue];
    if(curQuan == 0){
        self.downBtn.enabled = NO;
        self.itemPriceLabel.alpha = 0.4;
        self.itemNameLabel.alpha = 0.4;
        self.itemNoteField.alpha = 0.4;
    }
}

@end
