//
//  VideoTableViewCell.m
//  reigns'expweek
//
//  Created by reigns on 2017/7/3.
//  Copyright © 2017年 B14041316. All rights reserved.
//

#import "VideoTableViewCell.h"

@interface VideoTableViewCell ()
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *loadImgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *ptimeLab;
@end


#define KVideoCellHeight 260.0f


@implementation VideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void)configCellWithData:(NSDictionary *)dict{
    //获取视频封面
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"cover"]]];
    
    //获取视频标题
    self.titleLab.text = dict[@"title"];
    
    //获取视频时长
    self.timeLab.text = [self getTimeString:dict[@"length"]];
    
    //获取视频上传时间
    NSString *ptimeStr = [NSString stringWithFormat:@"上传时间:%@",dict[@"ptime"]];
   
    self.ptimeLab.text = ptimeStr;
    
}

- (NSString *)getTimeString:(NSString *)time{
    NSString * mStr;
    NSString * sStr;
    //将视频时长规格化为xx分:xx秒
    if ([time integerValue]/60 > 9) {
        mStr = [NSString stringWithFormat:@"%d",(int)[time integerValue]/60];
    }else{
        mStr = [NSString stringWithFormat:@"0%d",(int)[time integerValue]/60];
    }
    
    if ([time integerValue]%60 > 9) {
        sStr = [NSString stringWithFormat:@"%d",(int)[time integerValue]%60];
    }else{
        sStr = [NSString stringWithFormat:@"0%d",(int)[time integerValue]%60];
    }
    return [NSString stringWithFormat:@"时长:%@:%@",mStr,sStr];
    
}

#pragma mark - setup views
- (void)setupViews{
    [self.contentView addSubview:self.bgImgView];
    [self.contentView addSubview:self.loadImgView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.ptimeLab];
}

- (void)setupLayout{
    //视频布局
    self.bgImgView.frame = CGRectMake(5, 30, KScreenWidth - 10, KVideoCellHeight -60);
    self.loadImgView.frame = CGRectMake(KScreenWidth / 2 - 20, KVideoCellHeight /2 -20, 40, 40);
    self.titleLab.frame = CGRectMake(10, 0, KScreenWidth, 30);
    self.timeLab.frame = CGRectMake(5, KVideoCellHeight - 25, 80, 20);
    self.ptimeLab.frame = CGRectMake(KScreenWidth-190, KVideoCellHeight - 25, 190, 20);
}

#pragma mark - lazy load
//懒加载

//视频封面布局
- (UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.frame = CGRectMake(10, 10, 80, 80);
        _bgImgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgImgView;
}

//视频加载图标布局
- (UIImageView *)loadImgView{
    if (!_loadImgView) {
        _loadImgView = [UIImageView new];
        _loadImgView.backgroundColor = [UIColor clearColor];//透明色
        _loadImgView.image = [UIImage imageNamed:@"icon_video_load"];
        _loadImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _loadImgView;
}

//视频标题布局
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.numberOfLines = 3;
    }
    return _titleLab;
}

//视频时长信息布局
- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:13];
        _timeLab.textColor = [UIColor darkGrayColor];
        _timeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLab;
}

//视频上传时间布局
- (UILabel *)ptimeLab{
    if (!_ptimeLab) {
        _ptimeLab = [UILabel new];
        _ptimeLab.font = [UIFont systemFontOfSize:13];
        _ptimeLab.textColor = [UIColor darkGrayColor];
        _ptimeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _ptimeLab;
}

#pragma mark - public
//获取视频Cell高度
+(CGFloat)getCellHeight{
    return KVideoCellHeight;
}

@end

