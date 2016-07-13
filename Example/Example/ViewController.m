//
//  ViewController.m
//  Example
//
//  Created by WLY on 16/7/12.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ViewController.h"
#import "ICEWaterfallVC.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datasource = @[@"瀑布流", @"标签类布局"];
}


#pragma mark - UITableViewDelegate&& UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"     %@", self.datasource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ICEWaterfallVC *collectionVC = [[ICEWaterfallVC alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
}

@end
