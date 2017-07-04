//
//  VideoViewController.m
//  reigns'expweek
//
//  Created by reigns on 2017/7/3.
//  Copyright © 2017年 B14041316. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTabView;
@property (nonatomic, strong) NSMutableArray *listArray;    //列表数据
@property (nonatomic) NSInteger pageNumber;                //当前页码

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupProperty];
    [self setupViews];
    [self setupLayout];
}

#pragma mark - load data
//刷新页面
- (void)loadNewData{
    
    //设置当前页面为0
    self.pageNumber = 0;
    
    //拼接请求参数
    NSString *domainStr = @"http://c.m.163.com/nc/video/home/20-20.html";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:domainStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //停止刷新
        [self.listTabView.mj_header endRefreshing];
        
        //移除历史数据
        [self.listArray removeAllObjects];
        
        //json解析新数据
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray * dataArray = resultDic[@"videoList"];
        //获取列表的数据
        [self.listArray addObjectsFromArray:dataArray];
        
        //刷新当前页面
        [self.listTabView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.listTabView.mj_header endRefreshing];
        [self.listTabView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        
    }];
    
}

//加载更多
- (void)loadMoreData{
    
    //设置当前页面为0
    self.pageNumber++;
    
    //拼接请求参数
    NSString *domainStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-20.html",(int)self.pageNumber*20];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:domainStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //停止刷新
        [self.listTabView.mj_footer endRefreshing];
        
        //json解析新数据
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray * dataArray = resultDic[@"videoList"];
        
        //获取列表视频数据
        [self.listArray addObjectsFromArray:dataArray];
        
        //刷新当前页面
        [self.listTabView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.pageNumber--;
        [self.listTabView.mj_header endRefreshing];
        [self.listTabView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        
    }];
    
}


#pragma mark - setup views
- (void)setupViews{
    [self.view addSubview:self.listTabView];
}

- (void)setupLayout{
    self.listTabView.frame = self.view.bounds;
}

//设置的当前viewController的属性
- (void)setupProperty{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - tableview datasource and delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listArray.count == 0) {
        return;
    }
    
    NSDictionary * dict = self.listArray[indexPath.section];
    
    //获取视频播放源
    NSURL * url = [NSURL URLWithString:dict[@"mp4_url"]];
    
    //视频播放
    MPMoviePlayerViewController * videoVc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    
    [self presentMoviePlayerViewControllerAnimated:videoVc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *videoListCellID = @"VideoTableViewCellID";
    VideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:videoListCellID];
    if (!cell) {
        cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoListCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell configCellWithData:self.listArray[indexPath.section]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [VideoTableViewCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

#pragma mark - lazy load
- (UITableView *)listTabView{
    if (_listTabView == nil) {
        _listTabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _listTabView.dataSource = self;
        _listTabView.delegate = self;
        
        //给tableview添加下拉刷新和上拉加载更多的事件
        WeakSelf;
        _listTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
        
        _listTabView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        
        //立即刷新
        [_listTabView.mj_header beginRefreshing];
        
    }
    return _listTabView;
}

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}

@end

