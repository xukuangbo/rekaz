//
//  ZKRFunViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//
#import "ZKRAccountBarButtonItem.h"
#import "ZKRFunViewController.h"
#import "ZKRBarButtonItem.h"

#import "UIBarButtonItem+CGLExtension.h"

#import "AFHTTPSessionManager.h"
#import "ZKRFunGroupItem.h"
#import "ZKRFunCellItem.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "ZKRColoumnsViewController.h"
@interface ZKRFunViewController ()

@property (nonatomic, strong) NSMutableArray *groupsArray;
 /** 轮播图数组 */
@property (nonatomic, strong) NSString *cycleURLString;

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) ZKRColoumnsViewController *tableVC;
@end

@implementation ZKRFunViewController

#pragma mark - ---| lazy load |---
- (NSMutableArray *)groupsArray
{
    if (!_groupsArray) {
        _groupsArray = [NSMutableArray array];
    }
    return _groupsArray;
}

- (ZKRColoumnsViewController *)tableVC
{
    if (!_tableVC) {
        ZKRColoumnsViewController *tableVC = [[ZKRColoumnsViewController alloc] init];
        _tableVC = tableVC;
        _tableVC.groupsArray = self.groupsArray;
        _tableVC.cycleURLString = self.cycleURLString;
    }
    return _tableVC;
}

#pragma mark - ---| init |---
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self loadData];
}

- (void)setNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"玩乐";
    
    // 左
    self.navigationItem.leftBarButtonItem = [ZKRAccountBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" navigationController:self.navigationController];
    
    //右
    ZKRBarButtonItem *btn = [[ZKRBarButtonItem alloc] init];
    [btn setImage:[UIImage imageNamed:@"nav_location"] forState:UIControlStateNormal];
    [btn setTitle:@"广州" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    //让按钮的大小自适应.
    [btn sizeToFit];
    //自定义UIView,必须得要设置尺寸.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)setupTableView
{
    UIView *columnsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, CGLScreenH)];
    
    self.tableVC.tableView.frame = columnsView.bounds;
    
    [columnsView addSubview:self.tableVC.tableView];
    
    [self.view addSubview:columnsView];
}

#pragma mark - ---| data |---
 /** 加载数据 */
- (void)loadData
{
    //http: //wl.myzaker.com/?_appid=iphone&_version=6.46&c=columns
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_version"] = @"6.46";
    para[@"c"] = @"columns";
    
    [manager GET:@"http://wl.myzaker.com/" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/CGL/Desktop/hehe.plist" atomically:YES];
        NSArray *groups = [ZKRFunGroupItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"columns"]];
        
        // 用来保存一个组的cell
        NSMutableArray *newCellArray = [NSMutableArray array];
        
        for (ZKRFunGroupItem *group in groups) {
            NSArray *cells = [ZKRFunCellItem mj_objectArrayWithKeyValuesArray:group.items];
            for (ZKRFunCellItem *cellItem in cells) {
                [newCellArray addObject:cellItem];
            }
            group.itemsArray = newCellArray;
            // 保存数组
            [self.groupsArray addObject:group];
            // 清空数组
            newCellArray = [NSMutableArray array];
        }
        
//        ZKRFunGroupItem *group = self.groupsArray[0];
//        NSLog(@"%@", group.itemsArray);
        
        // 轮播图
        self.cycleURLString = responseObject[@"data"][@"promote"][0][@"promotion_img"];
        self.tableVC.groupsArray = self.groupsArray;
        [self setupTableView];
        
//        [self.tableVC.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - ---| event |---
- (void)locationClick
{
    CGLFunc
}

@end
