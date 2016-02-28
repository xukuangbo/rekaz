//
//  ZKRChoiceThreePicView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRChoiceThreePicView.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRChoiceThreePicView()
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end
@implementation ZKRChoiceThreePicView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //    self.progressView.roundedCorners = 5;
    //    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    // 让iamgeView可以交互
    self.firstImageView.userInteractionEnabled = YES;
    self.secondImageView.userInteractionEnabled = YES;
    self.thirdImageView.userInteractionEnabled = YES;
    //    [self.picImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick:)]];
}
- (void)setItem:(ZKRCommentChoiceItem *)item
{
    _item = item;
    
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:item.url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:item.sec_min_url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:item.thr_min_url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

@end
