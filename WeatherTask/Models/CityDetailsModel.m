//
//  CityDetailsModel.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "CityDetailsModel.h"

@implementation CityDetailsModel
- (instancetype)initWithData:(NSDictionary*)dataDic {
    if (self = [super init]) {
        [self setInitialData];
    }
    self.strTemp = [NSString stringWithFormat:@"%@°C",[[dataDic valueForKey:@"main"]valueForKey:@"temp"]];
    self.strTempMinMax = [NSString stringWithFormat:@"Min:%@°C ~ Max:%@°C",[[dataDic valueForKey:@"main"]valueForKey:@"temp_min"],[[dataDic valueForKey:@"main"]valueForKey:@"temp_max"]];
    self.strDay =[NSString stringWithFormat:@"%@ (%@)",[self getTimeFromTheDate:[NSString stringWithFormat:@"%@",[dataDic valueForKey:@"dt"]]],[[[dataDic valueForKey:@"weather"]objectAtIndex:0] valueForKey:@"main"]];
    self.strIcon = [NSString stringWithFormat:@"%@",[[[dataDic valueForKey:@"weather"]objectAtIndex:0] valueForKey:@"icon"]];
    return self;
}


- (void)setInitialData {
    self.strTemp = @"";
    self.strDay = @"";
    self.strTempMinMax = @"";
    self.strIcon = @"";
}
- (NSString *)getTimeFromTheDate:(NSString *)date {
    NSTimeInterval seconds = [date doubleValue];
    NSDate * currentDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE"];
    NSString *stringFromDate = [formatter stringFromDate:currentDate];
    return stringFromDate;
}
@end
