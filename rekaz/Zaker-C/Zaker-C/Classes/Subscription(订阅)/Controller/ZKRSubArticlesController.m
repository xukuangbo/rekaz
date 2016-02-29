//
//  ZKRSubArticlesController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSubArticlesController.h"
#import "ZKRSubArticlesCell.h"
#import "ZKRRootTypeItem.h"
#import "ZKRHTTPSessionManager.h"

@interface ZKRSubArticlesController()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *nearTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *farTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) ZKRHTTPSessionManager *manager;
@end

@implementation ZKRSubArticlesController
static NSString *SubArticlesCell = @"SubArticlesCell";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    [self loadData];
}

 /** 初始化collectionview */
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 每一个网格的尺寸
    layout.itemSize = self.contentView.frame.size;
    // 每一行之间的间距
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 上下左右的间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSubArticlesCell class]) bundle:nil] forCellWithReuseIdentifier:SubArticlesCell];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    
    self.collectionView = collectionView;
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - ---| loadData |---
 /** 加载数据 */
- (void)loadData
{
//    NSLog(@"%@", self.item.api_url);
    
    self.manager = [ZKRHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:self.item.api_url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/CGL/Desktop/articles.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - ---| data source |---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (ZKRSubArticlesCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRSubArticlesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SubArticlesCell forIndexPath:indexPath];
    cell.item = self.item;
    
    return cell;
}


- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (IBAction)refreshButtonClick:(UIButton *)sender {
}



@end
