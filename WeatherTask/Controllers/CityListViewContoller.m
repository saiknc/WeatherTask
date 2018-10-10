//
//  ViewController.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "CityListViewContoller.h"
#import "MyProxy.h"
#import "Constants.h"
#import "CityListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CityDeatilsViewController.h"

@interface CityListViewContoller () <WebServiceDelegate> {
    IBOutlet UITableView *tblViewCityList;
    NSMutableArray *arrCityWeatherDetails;
}

@end

@implementation CityListViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getCityDataFromServer];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = true;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image=[UIImage imageNamed:@"Background"];
    tblViewCityList.backgroundView=bgImage;
}
// Mark: Get weather details from server
- (void)getCityDataFromServer {
    
    [MyProxy sharedProxy].delegate = self;
    BOOL isConnected = [[MyProxy sharedProxy] checkReachability];
    NSString *str =
    [NSString stringWithFormat:@"%@%@", KbaseURL, KgetGroupData];
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setValue:KcityIDs forKey:@"id"];
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

#pragma mark - TableView DataSoure Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrCityWeatherDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CityListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CityListModel *objjModel = [[CityListModel alloc]initWithData:[arrCityWeatherDetails objectAtIndex:indexPath.row]];
    
    // Load Cell Details
    UILabel *lblCityName = (UILabel *)[cell viewWithTag:7];
    lblCityName.text = objjModel.strCityName;
    
    UILabel *lblTemp = (UILabel *)[cell viewWithTag:77];
    lblTemp.text = objjModel.strTemp;
    if (IS_IPHONE5) {
        lblCityName.font = [UIFont systemFontOfSize:25];
        lblTemp.font = [UIFont systemFontOfSize:30];
    } else {
        lblCityName.font = [UIFont systemFontOfSize:30];
        lblTemp.font = [UIFont systemFontOfSize:40];
    }
    UILabel *lblTime = (UILabel *)[cell viewWithTag:777];
    lblTime.text = objjModel.strTime;
    
    UILabel *lblWeather = (UILabel *)[cell viewWithTag:7777];
    lblWeather.text = objjModel.strWeather;
    
    NSString *strImgURl=[NSString stringWithFormat:@"%@%@.png",KimageURL,objjModel.strIcon];
    UIImageView *imgViewWeather = (UIImageView *)[cell viewWithTag:9];
    [imgViewWeather sd_setImageWithURL:[NSURL URLWithString:strImgURl]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityDeatilsViewController *objjVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
     instantiateViewControllerWithIdentifier:@"CityDeatilsViewController"];
    objjVC.strCityID = [[arrCityWeatherDetails objectAtIndex:indexPath.row]valueForKey:@"id"];
    [self.navigationController pushViewController:objjVC animated:YES];
}

#pragma mark - service Response
- (void)serviceResponse:(NSDictionary *)responseDic
         withServiceURL:(NSString *)str_service {
    [[MyProxy sharedProxy] hideActivityIndicatorInView];
    //   NSLog(@"RESPONSE DICTINARY = %@", responseDic);
    arrCityWeatherDetails = [responseDic valueForKey:@"list"];
    [tblViewCityList reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
