//
//  ZKRChoiceOnePicView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRChoiceOnePicView.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRChoiceOnePicView()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation ZKRChoiceOnePicView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
//    self.progressView.roundedCorners = 5;
//    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    // 让iamgeView可以交互
    self.picImageView.userInteractionEnabled = YES;
//    [self.picImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick:)]];
}
- (void)setItem:(ZKRCommentChoiceItem *)item
{
    _item = item;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:item.url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    if (self.item.isBigPicture) {
        [self.picImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.picImageView.clipsToBounds = YES;
    } else {
        self.picImageView.contentMode = UIViewContentModeScaleToFill;
        self.picImageView.clipsToBounds = NO;
    }
}

@end
