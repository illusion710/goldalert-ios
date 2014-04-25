//
//  ViewController.h
//  GoldAlert
//
//  Created by Bae Hyoungook on 4/4/14.
//  Copyright (c) 2014 illusion710. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *low;
@property (weak, nonatomic) IBOutlet UILabel *priceFl;
@property (weak, nonatomic) IBOutlet UILabel *perFl;
@property (weak, nonatomic) IBOutlet UILabel *priceState;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedAt;

@property (weak, nonatomic) IBOutlet UIButton *pushStateButton;
@end
