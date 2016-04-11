//
//  FirstViewController.h
//  1213
//
//  Created by kz on 15/8/12.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSString *str;
@property (strong,nonatomic) NSMutableArray *keys;
@property (strong,nonatomic) NSMutableDictionary *dic;
@end
