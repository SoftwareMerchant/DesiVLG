//
//  MenuIndexViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/8/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "MenuIndexViewController.h"
#import "ItemTableViewCell.h"
#import "ItemDetailViewController.h"

@interface MenuIndexViewController ()<UITableViewDelegate, UITableViewDataSource >

@end

@implementation MenuIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MenuCategory = [[NSMutableArray alloc] init];
    self.expSection = [[NSMutableDictionary alloc] init];
    //Form the detail menu
    NSMutableDictionary *item1 = [[NSMutableDictionary alloc] init];
    [item1 setObject:@"Lassi" forKey:@"name"];
    [item1 setObject:@2.95 forKey:@"price"];
    NSMutableDictionary *item2 = [[NSMutableDictionary alloc] init];
    [item2 setObject:@"Mango Lassi" forKey:@"name"];
    [item2 setObject:@2.95 forKey:@"price"];
    NSMutableDictionary *item3 = [[NSMutableDictionary alloc] init];
    [item3 setObject:@"Juice" forKey:@"name"];
    [item3 setObject:@2.95 forKey:@"price"];
    NSMutableDictionary *item4 = [[NSMutableDictionary alloc] init];
    [item4 setObject:@"Soda" forKey:@"name"];
    [item4 setObject:@2.00 forKey:@"price"];
    NSMutableDictionary *item5 = [[NSMutableDictionary alloc] init];
    [item5 setObject:@"Lemonade" forKey:@"name"];
    [item5 setObject:@2.00 forKey:@"price"];
    NSMutableDictionary *item6 = [[NSMutableDictionary alloc] init];
    [item6 setObject:@"Bottled Water" forKey:@"name"];
    [item6 setObject:@1.50 forKey:@"price"];
    NSArray *category1 = [[NSArray alloc] initWithObjects:item1,item2,item3,item4,item5,item6, nil];
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"BEVERAGES",@"categoryName", category1,@"items", nil];
    [self.MenuCategory addObject:dict1];
    [self.expSection setObject:@0 forKey:@0];
    
    NSMutableDictionary *item11 = [[NSMutableDictionary alloc] init];
    [item11 setObject:@"Bhel Puri" forKey:@"name"];
    [item11 setObject:@4.95 forKey:@"price"];
    NSMutableDictionary *item12 = [[NSMutableDictionary alloc] init];
    [item12 setObject:@"Chat Papri" forKey:@"name"];
    [item12 setObject:@4.95 forKey:@"price"];
    NSMutableDictionary *item13 = [[NSMutableDictionary alloc] init];
    [item13 setObject:@"Vegetable Samosa" forKey:@"name"];
    [item13 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item14 = [[NSMutableDictionary alloc] init];
    [item14 setObject:@"Vegetable Pakora" forKey:@"name"];
    [item14 setObject:@4.95 forKey:@"price"];
    NSMutableDictionary *item15 = [[NSMutableDictionary alloc] init];
    [item15 setObject:@"Samosa Chat" forKey:@"name"];
    [item15 setObject:@5.95 forKey:@"price"];
    NSMutableDictionary *item16 = [[NSMutableDictionary alloc] init];
    [item16 setObject:@"Paneer Pakora" forKey:@"name"];
    [item16 setObject:@6.95 forKey:@"price"];
    NSMutableDictionary *item17 = [[NSMutableDictionary alloc] init];
    [item17 setObject:@"Vegetarian Platter" forKey:@"name"];
    [item17 setObject:@7.95 forKey:@"price"];
    NSArray *category2 = [[NSArray alloc] initWithObjects:item11,item12,item13,item14,item15,item16,item17, nil];
    NSDictionary *dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"VEGETARIAN APPETIZER",@"categoryName", category2,@"items", nil];
    [self.MenuCategory addObject:dict2];
    [self.expSection setObject:@0 forKey:@1];
    
    
    NSMutableDictionary *item21 = [[NSMutableDictionary alloc] init];
    [item21 setObject:@"Chicken Pakora" forKey:@"name"];
    [item21 setObject:@6.95 forKey:@"price"];
    NSMutableDictionary *item22 = [[NSMutableDictionary alloc] init];
    [item22 setObject:@"Fish Bombay" forKey:@"name"];
    [item22 setObject:@7.95 forKey:@"price"];
    NSMutableDictionary *item23 = [[NSMutableDictionary alloc] init];
    [item23 setObject:@"Shrimp tik Tikka" forKey:@"name"];
    [item23 setObject:@7.95 forKey:@"price"];
    NSMutableDictionary *item24 = [[NSMutableDictionary alloc] init];
    [item24 setObject:@"Chicken Malabar" forKey:@"name"];
    [item24 setObject:@7.95 forKey:@"price"];
    NSMutableDictionary *item25 = [[NSMutableDictionary alloc] init];
    [item25 setObject:@"Non-Vegetarian Platter" forKey:@"name"];
    [item25 setObject:@8.95 forKey:@"price"];
    NSArray *category3 = [[NSArray alloc] initWithObjects:item21,item22,item23,item24,item25, nil];
    NSDictionary *dict3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"NON-VEGETARIAN APPETIZER",@"categoryName", category3,@"items", nil];
    [self.MenuCategory addObject:dict3];
    [self.expSection setObject:@0 forKey:@2];

    
    NSMutableDictionary *item31 = [[NSMutableDictionary alloc] init];
    [item31 setObject:@"Chicken Salad" forKey:@"name"];
    [item31 setObject:@4.95 forKey:@"price"];
    NSMutableDictionary *item32 = [[NSMutableDictionary alloc] init];
    [item32 setObject:@"Mixed Green Salad" forKey:@"name"];
    [item32 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item33 = [[NSMutableDictionary alloc] init];
    [item33 setObject:@"Fish Salad" forKey:@"name"];
    [item33 setObject:@5.95 forKey:@"price"];
    NSArray *category4 = [[NSArray alloc] initWithObjects:item31,item32,item33, nil];
    NSDictionary *dict4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"SALADS",@"categoryName", category4,@"items", nil];
    [self.MenuCategory addObject:dict4];
    [self.expSection setObject:@0 forKey:@3];
    
    NSMutableDictionary *item41 = [[NSMutableDictionary alloc] init];
    [item41 setObject:@"Mulligatawny Soup" forKey:@"name"];
    [item41 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item42 = [[NSMutableDictionary alloc] init];
    [item42 setObject:@"Yakhni Soup" forKey:@"name"];
    [item42 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item43 = [[NSMutableDictionary alloc] init];
    [item43 setObject:@"Tomato Soup" forKey:@"name"];
    [item43 setObject:@3.95 forKey:@"price"];
    NSArray *category5 = [[NSArray alloc] initWithObjects:item41,item42,item43, nil];
    NSDictionary *dict5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"SOUPS",@"categoryName", category5,@"items", nil];
    [self.MenuCategory addObject:dict5];
    [self.expSection setObject:@0 forKey:@4];
    
    NSMutableDictionary *item51 = [[NSMutableDictionary alloc] init];
    [item51 setObject:@"Chicken Shahi Korma" forKey:@"name"];
    [item51 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item52 = [[NSMutableDictionary alloc] init];
    [item52 setObject:@"Chicken Curry" forKey:@"name"];
    [item52 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item53 = [[NSMutableDictionary alloc] init];
    [item53 setObject:@"Chicken Jalfrezi" forKey:@"name"];
    [item53 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item54 = [[NSMutableDictionary alloc] init];
    [item54 setObject:@"Chicken Karahi" forKey:@"name"];
    [item54 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item55 = [[NSMutableDictionary alloc] init];
    [item55 setObject:@"Chicken Makhani" forKey:@"name"];
    [item55 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item56 = [[NSMutableDictionary alloc] init];
    [item56 setObject:@"Chicken Saagwala" forKey:@"name"];
    [item56 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item57 = [[NSMutableDictionary alloc] init];
    [item57 setObject:@"Chicken Tikka Masala" forKey:@"name"];
    [item57 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item58 = [[NSMutableDictionary alloc] init];
    [item58 setObject:@"Chicken Vindaloo" forKey:@"name"];
    [item58 setObject:@11.95 forKey:@"price"];
    NSArray *category6 = [[NSArray alloc] initWithObjects:item51,item52,item53,item54,item55,item56,item57,item58, nil];
    NSDictionary *dict6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"CHICKEN",@"categoryName", category6,@"items", nil];
    [self.MenuCategory addObject:dict6];
    [self.expSection setObject:@0 forKey:@5];
    
    NSMutableDictionary *item61 = [[NSMutableDictionary alloc] init];
    [item61 setObject:@"Achari Lamb" forKey:@"name"];
    [item61 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item62 = [[NSMutableDictionary alloc] init];
    [item62 setObject:@"Bhuna Lamb" forKey:@"name"];
    [item62 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item63 = [[NSMutableDictionary alloc] init];
    [item63 setObject:@"Lamb Karahi" forKey:@"name"];
    [item63 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item64 = [[NSMutableDictionary alloc] init];
    [item64 setObject:@"Lamb Rogan Josh" forKey:@"name"];
    [item64 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item65 = [[NSMutableDictionary alloc] init];
    [item65 setObject:@"Lamb Vindaloo" forKey:@"name"];
    [item65 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item66 = [[NSMutableDictionary alloc] init];
    [item66 setObject:@"Saag Lamb" forKey:@"name"];
    [item66 setObject:@12.95 forKey:@"price"];
    NSArray *category7 = [[NSArray alloc] initWithObjects:item61,item62,item63,item64,item65,item66, nil];
    NSDictionary *dict7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"LAMB",@"categoryName", category7,@"items", nil];
    [self.MenuCategory addObject:dict7];
    [self.expSection setObject:@0 forKey:@6];
    
    NSMutableDictionary *item71 = [[NSMutableDictionary alloc] init];
    [item71 setObject:@"Boti Kabab" forKey:@"name"];
    [item71 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item72 = [[NSMutableDictionary alloc] init];
    [item72 setObject:@"Chicken Tikka" forKey:@"name"];
    [item72 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item73 = [[NSMutableDictionary alloc] init];
    [item73 setObject:@"Garlic and Ginger Kabab" forKey:@"name"];
    [item73 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item74 = [[NSMutableDictionary alloc] init];
    [item74 setObject:@"Lamb Seekh Kabab" forKey:@"name"];
    [item74 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item75 = [[NSMutableDictionary alloc] init];
    [item75 setObject:@"Malai Kabab" forKey:@"name"];
    [item75 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item76 = [[NSMutableDictionary alloc] init];
    [item76 setObject:@"Reshmi Kabab" forKey:@"name"];
    [item76 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item77 = [[NSMutableDictionary alloc] init];
    [item77 setObject:@"Salmon Tandoori" forKey:@"name"];
    [item77 setObject:@14.95 forKey:@"price"];
    NSMutableDictionary *item78 = [[NSMutableDictionary alloc] init];
    [item78 setObject:@"Tandoori Chicken" forKey:@"name"];
    [item78 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item79 = [[NSMutableDictionary alloc] init];
    [item79 setObject:@"Tandoori Mixed Grill" forKey:@"name"];
    [item79 setObject:@16.95 forKey:@"price"];
    NSMutableDictionary *item710 = [[NSMutableDictionary alloc] init];
    [item710 setObject:@"Tandoori Paneer" forKey:@"name"];
    [item710 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item711 = [[NSMutableDictionary alloc] init];
    [item711 setObject:@"Tandoori Shrimps" forKey:@"name"];
    [item711 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item712 = [[NSMutableDictionary alloc] init];
    [item712 setObject:@"Tangree Kabab" forKey:@"name"];
    [item712 setObject:@11.95 forKey:@"price"];
    NSArray *category8 = [[NSArray alloc] initWithObjects:item71,item72,item73,item74,item75,item76,item77,item78,item79,item710,item711,item712, nil];
    NSDictionary *dict8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"TANDOORI SPECIALTIES(Bbq)",@"categoryName", category8,@"items", nil];
    [self.MenuCategory addObject:dict8];
    [self.expSection setObject:@0 forKey:@7];


    NSMutableDictionary *item81 = [[NSMutableDictionary alloc] init];
    [item81 setObject:@"Mutter Paneer" forKey:@"name"];
    [item81 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item82 = [[NSMutableDictionary alloc] init];
    [item82 setObject:@"Aloo Gobi" forKey:@"name"];
    [item82 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item83 = [[NSMutableDictionary alloc] init];
    [item83 setObject:@"Dal Fry" forKey:@"name"];
    [item83 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item84 = [[NSMutableDictionary alloc] init];
    [item84 setObject:@"Aloo Cholley" forKey:@"name"];
    [item84 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item85 = [[NSMutableDictionary alloc] init];
    [item85 setObject:@"Baingan Bhartha" forKey:@"name"];
    [item85 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item86 = [[NSMutableDictionary alloc] init];
    [item86 setObject:@"Bhindi Masala" forKey:@"name"];
    [item86 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item87 = [[NSMutableDictionary alloc] init];
    [item87 setObject:@"Dal Chana" forKey:@"name"];
    [item87 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item88 = [[NSMutableDictionary alloc] init];
    [item88 setObject:@"Dal Makhani" forKey:@"name"];
    [item88 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item89 = [[NSMutableDictionary alloc] init];
    [item89 setObject:@"Malai Kofta" forKey:@"name"];
    [item89 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item810 = [[NSMutableDictionary alloc] init];
    [item810 setObject:@"Palak Paneer" forKey:@"name"];
    [item810 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item811 = [[NSMutableDictionary alloc] init];
    [item811 setObject:@"Shahi Paneer" forKey:@"name"];
    [item811 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item812 = [[NSMutableDictionary alloc] init];
    [item812 setObject:@"Vegetables Jalfrezzi" forKey:@"name"];
    [item812 setObject:@10.95 forKey:@"price"];
    NSArray *category9 = [[NSArray alloc] initWithObjects:item81,item82,item83,item84,item85,item86,item87,item88,item89,item810,item811,item812, nil];
    NSDictionary *dict9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"VEGETARIAN SPECIALTIES",@"categoryName", category9,@"items", nil];
    [self.MenuCategory addObject:dict9];
    [self.expSection setObject:@0 forKey:@8];

    
    NSMutableDictionary *item91 = [[NSMutableDictionary alloc] init];
    [item91 setObject:@"Jumbo Shrimp Karahi" forKey:@"name"];
    [item91 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item92 = [[NSMutableDictionary alloc] init];
    [item92 setObject:@"Salmon Fish Bhuna" forKey:@"name"];
    [item92 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item93 = [[NSMutableDictionary alloc] init];
    [item93 setObject:@"Shrimp Saagwala" forKey:@"name"];
    [item93 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item94 = [[NSMutableDictionary alloc] init];
    [item94 setObject:@"Shrimp Vindaloo" forKey:@"name"];
    [item94 setObject:@15.95 forKey:@"price"];
    NSArray *category10 = [[NSArray alloc] initWithObjects:item91,item92,item93,item94, nil];
    NSDictionary *dict10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"SEAFOOD",@"categoryName", category10,@"items", nil];
    [self.MenuCategory addObject:dict10];
    [self.expSection setObject:@0 forKey:@9];

    NSMutableDictionary *item101 = [[NSMutableDictionary alloc] init];
    [item101 setObject:@"Chana Pulao" forKey:@"name"];
    [item101 setObject:@9.95 forKey:@"price"];
    NSMutableDictionary *item102 = [[NSMutableDictionary alloc] init];
    [item102 setObject:@"Chicken Biryani" forKey:@"name"];
    [item102 setObject:@11.95 forKey:@"price"];
    NSMutableDictionary *item103 = [[NSMutableDictionary alloc] init];
    [item103 setObject:@"Lamb Biryani" forKey:@"name"];
    [item103 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item104 = [[NSMutableDictionary alloc] init];
    [item104 setObject:@"Mughlai Pulao" forKey:@"name"];
    [item104 setObject:@12.95 forKey:@"price"];
    NSMutableDictionary *item105 = [[NSMutableDictionary alloc] init];
    [item105 setObject:@"Plain Pulao Rice" forKey:@"name"];
    [item105 setObject:@2.95 forKey:@"price"];
    NSMutableDictionary *item106 = [[NSMutableDictionary alloc] init];
    [item106 setObject:@"Shrimp Biryani" forKey:@"name"];
    [item106 setObject:@15.95 forKey:@"price"];
    NSMutableDictionary *item107 = [[NSMutableDictionary alloc] init];
    [item107 setObject:@"Vegetable Biryani" forKey:@"name"];
    [item107 setObject:@10.95 forKey:@"price"];
    NSMutableDictionary *item108 = [[NSMutableDictionary alloc] init];
    [item108 setObject:@"Egg Biryani" forKey:@"name"];
    [item108 setObject:@11.95 forKey:@"price"];
    NSArray *category11 = [[NSArray alloc] initWithObjects:item101,item102,item103,item104,item105,item106,item107,item108, nil];
    NSDictionary *dict11 = [[NSDictionary alloc] initWithObjectsAndKeys:@"RICE",@"categoryName", category11,@"items", nil];
    [self.MenuCategory addObject:dict11];
    [self.expSection setObject:@0 forKey:@10];
    

    NSMutableDictionary *item111 = [[NSMutableDictionary alloc] init];
    [item111 setObject:@"Aloo Paratha" forKey:@"name"];
    [item111 setObject:@2.50 forKey:@"price"];
    NSMutableDictionary *item112 = [[NSMutableDictionary alloc] init];
    [item112 setObject:@"Bread Basket" forKey:@"name"];
    [item112 setObject:@6.95 forKey:@"price"];
    NSMutableDictionary *item113 = [[NSMutableDictionary alloc] init];
    [item113 setObject:@"Garlic Naan" forKey:@"name"];
    [item113 setObject:@2.50 forKey:@"price"];
    NSMutableDictionary *item114 = [[NSMutableDictionary alloc] init];
    [item114 setObject:@"Kabuli Naan" forKey:@"name"];
    [item114 setObject:@2.50 forKey:@"price"];
    NSMutableDictionary *item115 = [[NSMutableDictionary alloc] init];
    [item115 setObject:@"Keema Naan" forKey:@"name"];
    [item115 setObject:@4.50 forKey:@"price"];
    NSMutableDictionary *item116 = [[NSMutableDictionary alloc] init];
    [item116 setObject:@"Laccha Paratha" forKey:@"name"];
    [item116 setObject:@2.50 forKey:@"price"];
    NSMutableDictionary *item117 = [[NSMutableDictionary alloc] init];
    [item117 setObject:@"Naan" forKey:@"name"];
    [item117 setObject:@1.95 forKey:@"price"];
    NSMutableDictionary *item118 = [[NSMutableDictionary alloc] init];
    [item118 setObject:@"Onion Kulcha" forKey:@"name"];
    [item118 setObject:@2.50 forKey:@"price"];
    NSMutableDictionary *item119 = [[NSMutableDictionary alloc] init];
    [item119 setObject:@"Paneer Naan" forKey:@"name"];
    [item119 setObject:@3.50 forKey:@"price"];
    NSMutableDictionary *item1110 = [[NSMutableDictionary alloc] init];
    [item1110 setObject:@"Poori" forKey:@"name"];
    [item1110 setObject:@1.95 forKey:@"price"];
    NSMutableDictionary *item1111 = [[NSMutableDictionary alloc] init];
    [item1111 setObject:@"Roti" forKey:@"name"];
    [item1111 setObject:@1.95 forKey:@"price"];
    NSArray *category12 = [[NSArray alloc] initWithObjects:item111,item112,item113,item114,item115,item116,item117,item118,item119,item1110,item1111, nil];
    NSDictionary *dict12 = [[NSDictionary alloc] initWithObjectsAndKeys:@"BREADS",@"categoryName", category12,@"items", nil];
    [self.MenuCategory addObject:dict12];
    [self.expSection setObject:@0 forKey:@11];

    NSMutableDictionary *item121 = [[NSMutableDictionary alloc] init];
    [item121 setObject:@"Achaar" forKey:@"name"];
    [item121 setObject:@1.95 forKey:@"price"];
    NSMutableDictionary *item122 = [[NSMutableDictionary alloc] init];
    [item122 setObject:@"Mango Chutney" forKey:@"name"];
    [item122 setObject:@2.95 forKey:@"price"];
    NSMutableDictionary *item123 = [[NSMutableDictionary alloc] init];
    [item123 setObject:@"Papadam" forKey:@"name"];
    [item123 setObject:@1.95 forKey:@"price"];
    NSMutableDictionary *item124 = [[NSMutableDictionary alloc] init];
    [item124 setObject:@"Raita" forKey:@"name"];
    [item124 setObject:@1.95 forKey:@"price"];
    NSArray *category13 = [[NSArray alloc] initWithObjects:item121,item122,item123,item124, nil];
    NSDictionary *dict13 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ACCOMPANIMENTS",@"categoryName", category13,@"items", nil];
    [self.MenuCategory addObject:dict13];
    [self.expSection setObject:@0 forKey:@12];
    
    NSMutableDictionary *item131 = [[NSMutableDictionary alloc] init];
    [item131 setObject:@"Gajar Halwa" forKey:@"name"];
    [item131 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item132 = [[NSMutableDictionary alloc] init];
    [item132 setObject:@"Gulab Jamun" forKey:@"name"];
    [item132 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item133 = [[NSMutableDictionary alloc] init];
    [item133 setObject:@"Lahori Kheer" forKey:@"name"];
    [item133 setObject:@3.95 forKey:@"price"];
    NSMutableDictionary *item134 = [[NSMutableDictionary alloc] init];
    [item134 setObject:@"Rasmalai" forKey:@"name"];
    [item134 setObject:@3.95 forKey:@"price"];
    NSArray *category14 = [[NSArray alloc] initWithObjects:item131,item132,item133,item134, nil];
    NSDictionary *dict14 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DESSERTS",@"categoryName", category14,@"items", nil];
    [self.MenuCategory addObject:dict14];
    [self.expSection setObject:@0 forKey:@13];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapHeader:(UIButton *)sender
{
    if ([[self.expSection objectForKey:@(sender.tag - 100)]  isEqual:  @0]) {
        [self.expSection setObject:@1 forKey:@(sender.tag - 100)];
    }
    else
    {
        [self.expSection setObject:@0 forKey:@(sender.tag - 100)];

    }
    
    [self.myTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.MenuCategory count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    if([[self.expSection objectForKey:[NSNumber numberWithInteger:section]]  isEqual: @0]){
        return 0;
    }else{
        return [[self.MenuCategory[section] objectForKey:@"items"] count];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UIColor* color = [UIColor colorWithHue:0.06 saturation:0.67 brightness:0.81 alpha:1];
    view.backgroundColor = color;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 60 ,55)];
    headerLabel.numberOfLines = 2;
    headerLabel.text = [self.MenuCategory[section] objectForKey:@"categoryName"];
    headerLabel.textColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:1];
    [headerLabel setFont:[UIFont fontWithName:@"Menlo-Bold" size:18.0]];
    [view addSubview:headerLabel];
    
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeSystem];
    myButton.layer.masksToBounds = YES;
    myButton.layer.cornerRadius = 20;
    [myButton setTitle:[NSString stringWithFormat:@"%lu",[[self.MenuCategory[section] objectForKey:@"items"] count]] forState:UIControlStateNormal];
    myButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 50, 10, 40 , 40);
    myButton.backgroundColor = [UIColor orangeColor];
    myButton.tag = 100 + section;
    [myButton addTarget:self action:@selector(tapHeader:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:myButton];
    return view;
}
//-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
//        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
//        UIView* content = castView.contentView;
//        UIColor* color = [UIColor colorWithHue:0.06 saturation:0.67 brightness:0.81 alpha:1];
////        if(section % 2 == 1){
////            color = [UIColor colorWithRed:0.1 green:1 blue:0.1 alpha:0.8];
////        }
//        content.backgroundColor = color;
//        
//        UIButton * myButton = [UIButton buttonWithType:UIButtonTypeCustom];
////        myButton.titleLabel.text = [self.expSection objectForKey:[NSNumber numberWithInteger:section]];
//        myButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 40, 10, 40 , 40);
//        myButton.tag = 100 + section;
//        [myButton addTarget:self action:@selector(tapHeader:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:myButton];
//        
//    }
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [self.MenuCategory[section] objectForKey:@"categoryName"];
//}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
 
     cell.itemNameLabel.text = [[[self.MenuCategory[indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"name"];
     NSDecimalNumber *price = [[[self.MenuCategory[indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"price"];

     UIImage *img = [UIImage imageNamed:@"priceTag.png"];
     CGSize imgSize = cell.priceLabel.frame.size;
     UIGraphicsBeginImageContext( imgSize );
     [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height+10)];
     cell.priceLabel.backgroundColor = [UIColor colorWithPatternImage:img];
     cell.priceLabel.textColor = [UIColor whiteColor];
     cell.priceLabel.text = [NSString stringWithFormat:@"%.2f",[price floatValue]];
 
     return cell;
     
 }

//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

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


// #pragma mark - Navigation
// 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Get the new view controller using [segue destinationViewController].
    //Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"showItemDetail"]){
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:sender];
        ItemDetailViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setItemName:)]) {
            [destination setValue:[[[self.MenuCategory[indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"name"] forKey:@"itemName"];
        }
        if ([destination respondsToSelector:@selector(setItemPrice:)]) {
            [destination setValue:[[[self.MenuCategory[indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"price"] forKey:@"itemPrice"];
        }
    }
}

@end
