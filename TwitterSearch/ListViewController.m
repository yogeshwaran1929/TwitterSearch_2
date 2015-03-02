//
//  ListViewController.m
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

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
    
    resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerLabel.frame.origin.y+headerLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    resultTableView.backgroundColor = [UIColor whiteColor];
    resultTableView.delegate = self;
    resultTableView.dataSource  =self;
    [self.view addSubview:resultTableView];
    
    [self loadQuery];
    // Do any additional setup after loading the view.
}


#pragma mark - Twitter Feeds

- (void)loadQuery
{

    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/search/tweets.json";
    
    NSDictionary *params = @{@"q" : textfieldString,@"geocode" : passLoation,@"result_type":@"mixed",@"count":@"50"};

    
    //q=Chennai&geocode=13.0405026%2C80.2336924%2C1km&result_type=mixed";
 
    NSError *clientError;
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
                             URLRequestWithMethod:@"GET"
                             URL:statusesShowEndpoint
                             parameters:params
                             error:&clientError];
    
    if (request) {
        [[[Twitter sharedInstance] APIClient]
         sendTwitterRequest:request
         completion:^(NSURLResponse *response,
                      NSData *data,
                      NSError *connectionError) {
             if (data) {
                 // handle the response data e.g.
                 NSError *jsonError;
                 NSDictionary *jsonResult = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:0
                                             error:&jsonError];
                 
                 NSArray *result1 = jsonResult[@"statuses"];
                 
                 
                 if ([result1 count] != 0)
                 {
                     [resultArray removeAllObjects];

                     for(NSDictionary *dict in result1)
                     {
                        
                         NSString *name = [[dict valueForKey:@"user"]  valueForKey:@"name"];
                         NSString *location = [[dict valueForKey:@"place"] valueForKey:@"name"];
                         NSString *imageURL =[[dict valueForKey:@"user"] valueForKey:@"profile_image_url"];
                         NSString *fullString = [NSString stringWithFormat:@"%@^%@^%@",name,location, imageURL];
                         [resultArray addObject:fullString];
                         
                        [resultTableView reloadData];

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
    
    NSString *reString = [resultArray objectAtIndex:indexPath.row];
    NSArray *reArray = [reString componentsSeparatedByString:@"^"];
    
    UIView *newsCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, resultTableView.frame.size.width, 80)];
    newsCellView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:newsCellView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, (newsCellView.frame.size.height-75)/2, 75, 75)];
//    imgView.image= [UIImage imageNamed:[reArray objectAtIndex:2]];
   
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+imgView.frame.origin.x+5, 10, 230, 35)];
    titleLabel.text = [reArray objectAtIndex:0];
    titleLabel.numberOfLines = 10;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    titleLabel.textColor = [UIColor blackColor];
    [newsCellView addSubview:titleLabel];

    
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+imgView.frame.origin.x+5, 40, 230, 35)];
    locationLabel.text = [reArray objectAtIndex:1];
    locationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    locationLabel.textColor = [UIColor blackColor];
    [newsCellView addSubview:locationLabel];
    
    
    NSString *str = [NSString stringWithFormat:@"%@",[reArray objectAtIndex:2]];

    dispatch_async(kBgQueue, ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.image = [UIImage imageWithData:imgData];
        });
    });
    [newsCellView addSubview:imgView];
    
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,78,resultTableView.frame.size.width,1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:174.0/255 green:174.0/255 blue:175.0/255 alpha:1];
    [newsCellView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0,79,resultTableView.frame.size.width,1)];
    lineLabel1.backgroundColor =[UIColor colorWithRed:220.0/255 green:222.0/255 blue:217.0/255 alpha:1];
    [newsCellView addSubview:lineLabel1];

    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 80;
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
