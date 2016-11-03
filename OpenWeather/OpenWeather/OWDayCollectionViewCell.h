//
//  OWDayCollectionViewCell.h
//  OpenWeather
//
//  Created by Juliana Cipa on 03/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWDayCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) NSInteger collectionViewSection;
@property (nonatomic, strong) NSIndexPath *indexPath;

-(void)configureWithDefaultValues;

@end
