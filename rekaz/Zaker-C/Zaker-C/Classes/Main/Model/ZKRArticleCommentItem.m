//
//  ZKRArticleCommentItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/7.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleCommentItem.h"

#define CGLMargin 10
@implementation ZKRArticleCommentItem

- (CGFloat)cellHeight
{
    // 如果计算过了，就直接返回以前计算的值
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 70;
    
    // 文字
    CGFloat textMaxW = CGLScreenW - 80 - 20;
    CGSize textMaxSize = CGSizeMake(textMaxW, 200);
    _cellHeight += [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + CGLMargin;
    //    _cellHeight += 54;
    //    NSLog(@"%lf", [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height);
    
    // 中间内容
    
    
//    if (self.m_url) { // 如果不是纯文字帖子（不是段子）
//        // 图片的真实宽度 self.width
//        // 图片的真实高度 self.height
//        // 图片显示出来的宽度
//        CGFloat centerW = CGLScreenW;
//        // 图片显示出来的高度
//        
//        CGFloat centerH = 0.0;
//        if ([self.item_type intValue] == CGLItemTypeOne) {
//            centerH = centerW * [self.medias_height intValue] / [self.medias_weight intValue];
//        } else if ([self.item_type intValue] == CGLItemTypeTwo) {
//            centerH = 183;
//        } else if ([self.item_type intValue] == CGLItemTypeThree) {
//            centerH = 123;
//        }
//        
//        if (centerH > 300) {
//            self.bigPicture = YES;
//            centerH = 300;
//        }
//        
//        CGFloat centerY = _cellHeight;
//        // 图片显示出来的X
//        CGFloat centerX = 0;
//        self.centerFrame = CGRectMake(centerX, centerY, centerW, centerH);
//        
//        // 累加中间内容的高度
//        _cellHeight += centerH;
//        
//        /*
//         centerW    self.width
//         -------  = -----------
//         centerH    self.height
//         */
//    }
    
    // 工具条
//    _cellHeight += 50 + CGLMargin;
    
    return _cellHeight;
}
@end
