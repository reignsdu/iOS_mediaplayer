//
//  MyDefines.h
//  reigns'expweek
//
//  Created by reigns on 2017/7/3.
//  Copyright © 2017年 B14041316. All rights reserved.
//

#ifndef MyDefines_h
#define MyDefines_h

#pragma mark - UI
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height


#pragma mark - common
#define WeakSelf  __weak __typeof(self) weakSelf = self;
#define StrongSelf  __strong __typeof(weakSelf) strongSelf = weakSelf;
#define NullObj(obj) (obj?obj:@"")
#define NSStringFormat(obj) ([NSString stringWithFormat:@"%@",obj])



#endif /* MyDefines_h */
