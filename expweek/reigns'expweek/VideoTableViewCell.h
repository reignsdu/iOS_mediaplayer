//
//  VideoTableViewCell.h
//  reigns'expweek
//
//  Created by reigns on 2017/7/3.
//  Copyright © 2017年 B14041316. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoTableViewCell : UITableViewCell

- (void)configCellWithData:(NSDictionary *)dict;

+(CGFloat)getCellHeight;

@end
