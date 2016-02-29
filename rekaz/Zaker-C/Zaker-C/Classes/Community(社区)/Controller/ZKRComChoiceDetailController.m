//
//  ZKRComChoiceDetailController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComChoiceDetailController.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRComChoiceDetailController()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZKRComChoiceDetailController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 顶部view 加载
    [self setupTopView];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.mainScrollView.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]];
    [webView loadRequest:request];
//    webView.delegate = self;
    self.webView = webView;
    [self.mainScrollView addSubview:webView];
    
}

 /** 加载顶部视图 */
- (void)setupTopView
{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.item.icon]];
    //    NSLog(@"%@", item.icon);
    self.userNameLabel.text = self.item.name;
    self.timeLabel.text = self.item.date;
}

- (IBAction)returnButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView { //webview 自适应高度
    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    self.mainScrollView.contentSize = newFrame.size;
}

- (IBAction)settingButtonClick:(UIButton *)sender {
    
//    NSLog(@"settingButtonClick" );
}
@end
