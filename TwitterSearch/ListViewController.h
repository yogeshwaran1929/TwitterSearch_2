//
//  ListViewController.h
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property(nonatomic,retain) NSString *searchDetails;
@property(nonatomic,strong)UITableView *resultTableView;
@property (nonatomic, retain) NSMutableArray *resultArray;
@property(nonatomic,strong) NSString *textfieldString,*passLoation;

@end
