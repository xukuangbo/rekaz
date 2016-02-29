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
    
    [self setImageView:self.firstImageView];
    [self setImageView:self.secondImageView];
    [self setImageView:self.thirdImageView];
    
}

- (void)setImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = NO;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 0.5;
    imageView.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor;
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
