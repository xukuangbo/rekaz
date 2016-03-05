//
//  ZKRArticleDetailController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleDetailController.h"
#import "ZKRArticleItem.h"
#import "UIImageView+WebCache.h"
#import "ZKRArticleDetailTopView.h"
#import "AFHTTPSessionManager.h"
#import "ZKRArticleContentItem.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#define TitleViewHeight 120
#define StatusBarHeight 20

/**
 *  订阅->分类->新闻详情页
 */
@interface ZKRArticleDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ZKRArticleContentItem *contentItem;
@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, strong) UIWebView *webView;
@end

static NSString *CommentCellID = @"CommentCellID";

@implementation ZKRArticleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:CommentCellID];
//    NSLog(@"%@", [self.item getAllPropertiesAndVaules]);
    [SVProgressHUD show];
    [self setupTableHeaderView];
    
    [self loadWebData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupTableHeaderView
{
    
    ZKRArticleDetailTopView *topView = [ZKRArticleDetailTopView cgl_viewFromXib];
    topView.frame = CGRectMake(0, -TitleViewHeight, CGLScreenW, TitleViewHeight);
    topView.item = self.item;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 350)];
    webView.delegate = self;
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(TitleViewHeight, 0, 0, 0);
    [webView.scrollView addSubview:topView];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;

    self.webView = webView;
}

- (void)loadWebData
{
    NSString *url = self.item.full_url;
    
    self.manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ZKRArticleContentItem *contentItem  = [ZKRArticleContentItem mj_objectWithKeyValues:responseObject[@"data"]];
        self.contentItem = contentItem ;
        
        [self loadWebView:self.contentItem];
        [self.webView reload];
//        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


 /** 加载网页 */
- (void)loadWebView:(ZKRArticleContentItem *)contentItem
{
    NSMutableString *html = [NSMutableString string];
    // 头部内容
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendString:@"</head>"];
    
    // 具体内容
    [html appendString:@"<body>"];
    
    [html appendString:[self setupBody:contentItem]];
    
    [html appendString:@"</body>"];
    
    // 尾部内容
    [html appendString:@"</html>"];
    
    // 显示网页
    [self.webView loadHTMLString:html baseURL:nil];
}

/**
 *  初始化网页body内容
 */
- (NSString *)setupBody:(ZKRArticleContentItem *)contentItem
{
    NSMutableString *body = [NSMutableString stringWithFormat:@"%@",contentItem.content];

    
    [contentItem.media enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableString *m_url = obj[@"m_url"];
        
        
        NSMutableString *div = [NSMutableString stringWithFormat:@"onclick='window.location.href=\"http://www.myzaker.com/?_zkcmd=open_media&index=%zd\"'", idx];
        NSMutableString *reDiv = [NSMutableString stringWithFormat:@"onclick='alert(this.src)'"];
        [body replaceOccurrencesOfString:div withString:reDiv options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        
        
        
        NSString *imgTargetString = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"article_html_content_loading.png\"", idx];
        NSString *imgReplaceString = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"%@\"", idx, m_url];

        [body replaceOccurrencesOfString:imgTargetString withString:imgReplaceString options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }];
//    NSLog(@"%@", body);
    return body;
}

#pragma mark - ---| webView delegate |---
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     /** 加载后的webView高度 */
    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
    
     /** webView新增底部view */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, webViewHeight + 20, CGLScreenW, 100)];
//    view.backgroundColor = ZKRRedColor;
    [webView.scrollView addSubview:view];

    webView.cgl_height = webViewHeight + TitleViewHeight + StatusBarHeight + 100;
    
    self.tableView.tableHeaderView = webView;
    
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

/**
 *  每当webView发送请求之前都会先调用的方法
 *
 *  @param webView
 *  @param request        即将发送的请求
 *  @param navigationType
 *
 *  @return 代理返回yes允许发送请求,返回no禁止发送这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 50)];
//    view.backgroundColor = [UIColor blueColor];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellID forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}


@end
