//
//  ViewController.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import "ViewController.h"
#import "OWWeatherService.h"
#import "OWDailyTableViewCell.h"
#import "OWDayCollectionView.h"
#import "OWDayCollectionViewCell.h"
#import "OWWeatherItem.h"

static NSString *const kThumbnaleEndPoint = @"http://openweathermap.org/img/w/";
static NSString *const kWeatherItemCollectionViewCell = @"weatherItemCell";

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSDictionary *weatherData;

@end

@implementation ViewController

#pragma mark - Internal Methods

-(void)fetchLondonWeatherForecast {
    [OWWeatherService getFiveDaysLondonWeatherWithCompletionHandler:^(NSDictionary *weatherItems, NSError *error) {
        self.weatherData = error ? @{} : weatherItems;
        [self.tableView reloadData];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchLondonWeatherForecast];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OWDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dayWeatherCell" forIndexPath:indexPath];
    
    cell.dayCollectionView.indexPath = indexPath;
    [cell.dayCollectionView reloadData];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section {
    return self.weatherData.allKeys[section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor whiteColor];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    NSInteger dayWeatherIndex = [(OWDayCollectionView *)collectionView indexPath].section;
    NSArray *weatherItems = self.weatherData.allValues[dayWeatherIndex];
    
    return weatherItems.count;
}

- (void) runSpinAnimationOnView:(UIView*)view
                       duration:(CGFloat)duration
                        toValue:(CGFloat)toValue
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OWDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWeatherItemCollectionViewCell
                                                                                forIndexPath:indexPath];
    NSInteger collectionViewSection = [(OWDayCollectionView *)collectionView indexPath].section;
    
    cell.collectionViewSection = collectionViewSection;
    cell.indexPath = indexPath;
    
    [cell configureWithDefaultValues];
    
    NSArray *allWeatherItems = self.weatherData.allValues[collectionViewSection];
    OWWeatherItem *weatherItem = allWeatherItems[indexPath.row];
    
    [self runSpinAnimationOnView:cell.apArrowImage duration:5.0 toValue:DegreesToRadians([weatherItem.windDegree floatValue])];
    
    //cell.apArrowImage.transform = CGAffineTransformMakeRotation(DegreesToRadians([weatherItem.windDegree floatValue]));
    
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@.png", kThumbnaleEndPoint, weatherItem.iconName];
    NSURL *imageURL = [NSURL URLWithString:completeUrlString];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cell.indexPath.row == indexPath.row && cell.collectionViewSection == [(OWDayCollectionView *)collectionView indexPath].section) {
                cell.weatherIcon.image = image;
                cell.timeLabel.text = [weatherItem readableWeatherTime];
            }
        });
    });
    
    return cell;
}

#pragma mark - Settings

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
