//
//  ViewController.m
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    
//    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/search/tweets.json";
//    
//    NSDictionary *params = @{@"q" : textfieldString,@"geocode" : passLoation,@"result_type":@"mixed",@"count":@"50"};
//    
//    
//    //q=Chennai&geocode=13.0405026%2C80.2336924%2C1km&result_type=mixed";
//    
//    NSError *clientError;
//    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
//                             URLRequestWithMethod:@"GET"
//                             URL:statusesShowEndpoint
//                             parameters:params
//                             error:&clientError];
//    
//    if (request) {
//        [[[Twitter sharedInstance] APIClient]
//         sendTwitterRequest:request
//         completion:^(NSURLResponse *response,
//                      NSData *data,
//                      NSError *connectionError) {
//             if (data) {
//                 // handle the response data e.g.
//                 NSError *jsonError;
//                 NSDictionary *jsonResult = [NSJSONSerialization
//                                             JSONObjectWithData:data
//                                             options:0
//                                             error:&jsonError];
//                 
//                 NSArray *result1 = jsonResult[@"statuses"];
//                 
//                 
//                 if ([result1 count] != 0)
//                 {
//                     [resultArray removeAllObjects];
//                     
//                     for(NSDictionary *dict in result1)
//                     {
//                         
//                         NSString *name = [[dict valueForKey:@"user"]  valueForKey:@"name"];
//                         NSString *location = [[dict valueForKey:@"place"] valueForKey:@"name"];
//                         NSString *imageURL =[[dict valueForKey:@"user"] valueForKey:@"profile_image_url"];
//                         NSString *fullString = [NSString stringWithFormat:@"%@^%@^%@",name,location, imageURL];
//                         [resultArray addObject:fullString];
//                         
//                         [resultTableView reloadData];
//                         
//                     }
//                     
//                 }

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
