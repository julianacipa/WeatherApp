//
//  OWDayCollectionViewCell.m
//  OpenWeather
//
//  Created by Juliana Cipa on 03/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import "OWDayCollectionViewCell.h"

@implementation OWDayCollectionViewCell

-(void)configureWithDefaultValues {
    self.weatherIcon.image = [UIImage imageNamed:@"placeholder"];
    self.timeLabel.text = @"";
    self.timeLabel.textColor = [UIColor darkGrayColor];
}

@end
