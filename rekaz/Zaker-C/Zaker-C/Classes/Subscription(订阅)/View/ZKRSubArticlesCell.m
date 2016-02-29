//
//  ZKRSubArticlesCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSubArticlesCell.h"
#import "UIImageView+WebCache.h"
#import "ZKRRootTypeItem.h"

@interface ZKRSubArticlesCell()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@end

@implementation ZKRSubArticlesCell

- (void)setItem:(ZKRRootTypeItem *)item
{
    _item = item;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:@"http://upload.myzaker.com/data/image/template/iphone/1057.png?1418985329"]];
//    NSLog(@"%@", item.pic);
}

@end
