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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

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

#pragma mark - Settings

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
