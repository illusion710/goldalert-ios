//
//  ViewController.m
//  GoldAlert
//
//  Created by Bae Hyoungook on 4/4/14.
//  Copyright (c) 2014 illusion710. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.pushStateButton.layer.cornerRadius = 20;
    [self.price setFont:[UIFont fontWithName:@"NeoSansPro-Bold" size:37]];
    [self.high setFont:[UIFont fontWithName:@"NeoSansPro-Light" size:17]];
    [self.low setFont:[UIFont fontWithName:@"NeoSansPro-Light" size:17]];
    [self.priceFl setFont:[UIFont fontWithName:@"NeoSansPro-Light" size:17]];
    [self.perFl setFont:[UIFont fontWithName:@"NeoSansPro-Light" size:17]];
    [self.lastUpdatedAt setFont:[UIFont fontWithName:@"NeoSansPro-Light" size:10]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *requestURLString = @"http://api.goldprice.wisestar.net/ticker";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager.requestSerializer setValue:@"DtsZxYeQiK" forHTTPHeaderField:@"X-GOLDPRICE-REST-OBJECT-ID"];
    [manager.requestSerializer setValue:@"0c36329c-17ec-480a-a92f-f79d369e1b29" forHTTPHeaderField:@"X-GOLDPRICE-REST-API-KEY"];
    
    [manager GET:requestURLString
        parameters:nil
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *)responseObject;
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData: [json[@"data"] dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
            
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            
            NSString *highLowFormat = @"%@ 원";
            NSString *perFlFormat = @"%@%%";
            NSString *lateUpdatedAdFormat = @"Last update %@";
            
            NSString *price = data[@"price"];
            NSString *formattedPrice = [formatter stringFromNumber:[NSNumber numberWithInteger:[price intValue]]];
            [self.price setText:formattedPrice];

            NSString *high = data[@"high"];
            NSString *formattedHigh = [NSString stringWithFormat:highLowFormat, [formatter stringFromNumber:[NSNumber numberWithInteger:[high intValue]]]];
            [self.high setText:formattedHigh];

            NSString *low = data[@"low"];
            NSString *formattedLow = [NSString stringWithFormat:highLowFormat, [formatter stringFromNumber:[NSNumber numberWithInteger:[low intValue]]]];
            [self.low setText:formattedLow];
            
            NSString *priceFl = data[@"price_fl"];
            NSString *formattedPriceFl = [formatter stringFromNumber:[NSNumber numberWithInteger:[priceFl intValue]]];
            [self.priceFl setText:formattedPriceFl];
            
            NSString *perFl = data[@"per_fl"];
            NSString *formattedPerFl = [NSString stringWithFormat:perFlFormat, perFl];
            [self.perFl setText:formattedPerFl];
            
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            
            NSString *formattedLastUpdatedAt = [NSString stringWithFormat:lateUpdatedAdFormat, [dateFormatter stringFromDate:date]];
            [self.lastUpdatedAt setText:formattedLastUpdatedAt];
            NSLog(@"success");
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure");
        }
    ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
