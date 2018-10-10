//
//  CityListModel.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "CityListModel.h"

@implementation CityListModel


- (instancetype)initWithData:(NSDictionary*)dataDic {
    if (self = [super init]) {
        [self setInitialData];
    }
    self.strCityName = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"id"]];
    self.strCityName = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"name"]];
    self.strTemp = [NSString stringWithFormat:@"%@°C",[[dataDic valueForKey:@"main"]valueForKey:@"temp"]];
    self.strTime = [self getTimeFromTheDate:[NSString stringWithFormat:@"%@",[dataDic valueForKey:@"dt"]]];
    self.strWeather = [NSString stringWithFormat:@"%@",[[[dataDic valueForKey:@"weather"]objectAtIndex:0] valueForKey:@"main"]];
    self.strIcon = [NSString stringWithFormat:@"%@",[[[dataDic valueForKey:@"weather"]objectAtIndex:0] valueForKey:@"icon"]];
    return self;
}


- (void)setInitialData {
    self.strCityID = @"";
    self.strCityName = @"";
    self.strTemp = @"";
    self.strTime = @"";
    self.strWeather = @"";
    self.strIcon = @"";
}

- (NSString *)getTimeFromTheDate:(NSString *)date {
    NSTimeInterval seconds = [date doubleValue];
    NSDate * currentDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *stringFromDate = [formatter stringFromDate:currentDate];
    return stringFromDate;
}


@end
