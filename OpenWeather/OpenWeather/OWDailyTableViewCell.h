//
//  OWDailyTableViewCell.h
//  OpenWeather
//
//  Created by Juliana Cipa on 03/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWDayCollectionView.h"

@interface OWDailyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet OWDayCollectionView *dayCollectionView;

@end
