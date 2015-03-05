//
//  ListViewController.m
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.


#import "ListViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize searchDetails;
@synthesize resultTableView,resultArray;
@synthesize textfieldString,passLoation;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headerLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    headerLabel.text = @"Search Result";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    [self.view addSubview:headerLabel];

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(3,27, 32, 32);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_12"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    resultArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerLabel.frame.origin.y+headerLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-64)];
    resultTableView.backgroundColor = [UIColor whiteColor];
    self.resultTableView.separatorColor = [UIColor clearColor];

    [self.view addSubview:resultTableView];
    
    [self loadQuery];
    // Do any additional setup after loading the view.
}


#pragma mark - Twitter Feeds

- (void)loadQuery
{

     ////  Search Query images tag with hashtag name
    
    NSString *passTextFiled = [NSString stringWithFormat:@"#%@ filter:images",textfieldString];
    
    /// Twitter Search API
    
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/search/tweets.json";
    
    // Parameters (hashtag , geocode , count , include_entities)
    
    NSDictionary *params = @{@"q" : passTextFiled,@"geocode" :passLoation,@"count":@"100",@"include_entities":@"true"};

    NSError *clientError;
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
                             URLRequestWithMethod:@"GET"
                             URL:statusesShowEndpoint
                             parameters:params
                             error:&clientError];
    
    if (request) {
        [[[Twitter sharedInstance] APIClient]  sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data,   NSError *connectionError) {
             if (data)
             {
                 // handle the response data e.g.
                 NSError *jsonError;
                 NSDictionary *jsonResult = [NSJSONSerialization  JSONObjectWithData:data  options:0  error:&jsonError];
                 NSArray *resultStatus = jsonResult[@"statuses"] ;
                 NSMutableArray *entitesArray = [NSMutableArray array];
                 
                 if ([resultStatus count] != 0)
                 {
                     for(NSDictionary *finalDict in resultStatus)
                     {
                         [entitesArray  addObject: [finalDict valueForKey:@"entities"]];
                     }
                 }
                 if ([entitesArray count] != 0)
                 {
                     [resultArray removeAllObjects];
                     for(NSDictionary *dict in entitesArray)
                     {
                        NSString *imageURL = [NSString stringWithFormat:@"%@", [[dict valueForKey:@"media"] valueForKey:@"media_url"]];
                         NSString * removeChara1 = [imageURL stringByReplacingOccurrencesOfString: @"(" withString: @""];
                         NSString * removeChara2 = [removeChara1 stringByReplacingOccurrencesOfString: @")" withString: @""];
                         NSString * removeChara3 = [removeChara2 stringByReplacingOccurrencesOfString: @"\"" withString: @""];
                         NSString *finalResult = [removeChara3 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
                         if(![finalResult isEqualToString:@"null"])
                         {
                              [resultArray addObject:finalResult];
                         }
                    }
                         if([resultArray count] != 0)
                         {
                             resultTableView.delegate = self;
                             resultTableView.dataSource  =self;
                             [resultTableView reloadData];
                         }
                         else
                         {
                             UIAlertView* successAlert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No results found" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                             [successAlert show];
                         }
                    }
                 else
                  {
                      UIAlertView* successAlert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No results found" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                      [successAlert show];

                  }
             }
             else
             {
                 
                 UIAlertView* errorAlert1=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",connectionError] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [errorAlert1 show];
                 
             }
         }];
    }
    else
    {
        UIAlertView* errorAlert1=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",clientError] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlert1 show];
        
    }

}

#pragma mark - Back 

-(void)backAction
{
        [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
    for(UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    

    UIView *newsCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, resultTableView.frame.size.width, 150)];
    newsCellView.backgroundColor = [UIColor whiteColor];
   
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, newsCellView.frame.size.width-10, 148)];
    
    NSString *strResult1 = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:indexPath.row]];

    dispatch_async(kBgQueue, ^{
        
       NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strResult1]];
     
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.image = [UIImage imageWithData:imgData];
             [newsCellView addSubview:imgView];
        });
       
    });
    
    [cell.contentView addSubview:newsCellView];
    
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,148,resultTableView.frame.size.width,1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:174.0/255 green:174.0/255 blue:175.0/255 alpha:1];
    [newsCellView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0,149,resultTableView.frame.size.width,1)];
    lineLabel1.backgroundColor =[UIColor colorWithRed:220.0/255 green:222.0/255 blue:217.0/255 alpha:1];
    [newsCellView addSubview:lineLabel1];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // This will create a "invisible" footer
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 150;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
