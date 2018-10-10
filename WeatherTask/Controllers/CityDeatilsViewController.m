//
//  CityDeatilsViewController.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "CityDeatilsViewController.h"
#import "Constants.h"
#import "MyProxy.h"
#import "CityDetailsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CityDeatilsViewController () <WebServiceDelegate> {
    IBOutlet UITableView *tblViewCityDetails;
    IBOutlet UILabel *lblCityName;
    IBOutlet UILabel *lblTemp;
    IBOutlet UILabel *lblMinMaxTemp;
    NSMutableArray *arrCityWeatherData;
}

@end

@implementation CityDeatilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Weather Details";
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(btn_backClick:)];
    self.navigationItem.leftBarButtonItem = backButton;
    [self getCityWeatherDetailsFromServerWithCityID:self.strCityID];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = false;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image=[UIImage imageNamed:@"Background"];
    tblViewCityDetails.backgroundView=bgImage;
}
#pragma mark - Button Handlers
- (void)btn_backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// Mark: Get weather details from server
- (void)getCityWeatherDetailsFromServerWithCityID:(NSString *)cityID {
    
    [MyProxy sharedProxy].delegate = self;
    BOOL isConnected = [[MyProxy sharedProxy] checkReachability];
    NSString *str =
    [NSString stringWithFormat:@"%@%@", KbaseURL, KgetCityData];
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setValue:cityID forKey:@"id"];
    [postDic setValue:KtempType
               forKey:@"units"];
    [postDic setValue:kappID
               forKey:@"appid"];
    if (isConnected) {
        [[MyProxy sharedProxy] getServiceWith:str postDic:postDic];
    } else {
        [KAppDelegate showAlertForNoInternetConnection];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrCityWeatherData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CityDetailsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CityDetailsModel *objjModel = [[CityDetailsModel alloc]initWithData:[arrCityWeatherData objectAtIndex:indexPath.row]];
    
    // Load Cell Details
    NSString *strImgURl=[NSString stringWithFormat:@"%@%@.png",KimageURL,objjModel.strIcon];
    UIImageView *imgViewWeather = (UIImageView *)[cell viewWithTag:9];
    [imgViewWeather sd_setImageWithURL:[NSURL URLWithString:strImgURl]];
    
    UILabel *lblDay = (UILabel *)[cell viewWithTag:7];
    lblDay.text = objjModel.strDay;
    
    UILabel *lblTemp = (UILabel *)[cell viewWithTag:77];
    lblTemp.text = objjModel.strTemp;
    
    UILabel *lblTempMinMax = (UILabel *)[cell viewWithTag:777];
    lblTempMinMax.text = objjModel.strTempMinMax;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - Private Methods
- (NSMutableArray *)filterDayWiseDetailsFromArray:(NSArray *)arr {
    
    NSMutableArray *arrWorking = [[NSMutableArray alloc]init];
    //   [arrWorking addObject:[arr objectAtIndex:0]];
    for (int i=1; i<arr.count; i++) {
        NSString *strDate = [self getFormattedDateAndTime:[[arr objectAtIndex:i]valueForKey:@"dt_txt"]];
        if ([strDate isEqualToString:@"00:00:00"]) {
            [arrWorking addObject:[arr objectAtIndex:i]];
        }
    }
    return arrWorking;
}
- (NSString *)getFormattedDateAndTime:(NSString *)date {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [dateformatter dateFromString:date];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    return date = [dateformatter stringFromDate:startDate];
}

#pragma mark - service Response
- (void)serviceResponse:(NSDictionary *)responseDic
         withServiceURL:(NSString *)str_service {
    [[MyProxy sharedProxy] hideActivityIndicatorInView];
    //  NSLog(@"RESPONSE DICTINARY = %@", responseDic);
    arrCityWeatherData = [self filterDayWiseDetailsFromArray:[responseDic valueForKey:@"list"]];
    lblCityName.text =[NSString stringWithFormat:@"%@",[[responseDic valueForKey:@"city"]valueForKey:@"name"]];
    lblTemp.text =[NSString stringWithFormat:@"%@°C",[[[[responseDic valueForKey:@"list"]objectAtIndex:0] valueForKey:@"main"]valueForKey:@"temp"]];
    lblMinMaxTemp.text =[NSString stringWithFormat:@"Min:%@°C  Max:%@°C",[[[[responseDic valueForKey:@"list"]objectAtIndex:0] valueForKey:@"main"]valueForKey:@"temp_min"],[[[[responseDic valueForKey:@"list"]objectAtIndex:0] valueForKey:@"main"]valueForKey:@"temp_max"]];
    [tblViewCityDetails reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
