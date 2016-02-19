//
//  ZKRColoumnsViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

/**
 未做: 上拉刷新/下拉加载
 点击跳转
 */

#import "ZKRColoumnsViewController.h"

#import "ZKRFunGroupItem.h"
#import "ZKRFunCellItem.h"
#import "ZKRColumnsViewCell.h"
#import "UIImageView+WebCache.h"

static NSString *CGLColumnsCellID = @"CGLColumnsCellID";
@interface ZKRColoumnsViewController ()

@end

@implementation ZKRColoumnsViewController

#pragma mark - ---| init |---
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 150)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.cycleURLString]];
    
    [self.tableView setTableHeaderView:imageView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRColumnsViewCell class]) bundle:nil] forCellReuseIdentifier:CGLColumnsCellID];
    
    
    // cell底部分割线去除
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] init];
    
    ZKRFunGroupItem *group = self.groupsArray[section];
    [view sd_setImageWithURL:[NSURL URLWithString:group.banner[@"url"]]];
    

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer setBackgroundColor:[UIColor whiteColor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZKRFunGroupItem *group = self.groupsArray[section];
    return group.itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRColumnsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CGLColumnsCellID];
    
    ZKRFunGroupItem *group = self.groupsArray[indexPath.section];
    ZKRFunCellItem *cellItem = group.itemsArray[indexPath.row];
    
    cell.cellItem = cellItem;
    
    return cell;
}
@end
