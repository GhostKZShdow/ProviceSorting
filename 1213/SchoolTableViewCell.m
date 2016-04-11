//
//  SchoolTableViewCell.m
//  1213
//
//  Created by kz on 15/8/13.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import "SchoolTableViewCell.h"

@implementation SchoolTableViewCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self)
//    {
//        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 35, 35)];
//        self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 20, 100, 30)];
//        self.imageView.backgroundColor=[UIColor redColor];
//        self.textLabel.backgroundColor=[UIColor orangeColor];
//        
//        [self.contentView addSubview:self.imageView];
//        [self.contentView addSubview:self.textLabel];
//    }
//    return self;
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.img=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 35, 35)];

        self.text=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 20)];
        
        [self.contentView addSubview:self.img];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.text];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
