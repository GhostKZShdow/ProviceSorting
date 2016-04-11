//
//  ViewController.m
//  1213
//
//  Created by kz on 15/8/12.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SchoolTableViewController.h"
#import "Header.h"
#define screenWidth [[UIScreen mainScreen]bounds].size.width
#define screenHeight [[UIScreen mainScreen]bounds].size.height
@interface ViewController ()
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *citysArray;
@property (strong,nonatomic) NSMutableDictionary *dic;
@property (strong,nonatomic) NSMutableArray *keys;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"city" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *cityDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSArray *cityArray=cityDic[@"city"];
    self.citysArray=[NSMutableArray arrayWithCapacity:30];
    for (int i=0; i<cityArray.count; i++)
    {
        NSString *str=cityArray[i][@"province_name"];
        [self.citysArray addObject:str];
    }
    // self.citysArray 里放的所有省
    self.dic=[NSMutableDictionary new];
    self.keys=[NSMutableArray new];
    //创建26个可变数组
    for (char character='a'; character<='z'; character++)
    {
        NSMutableArray *array=[NSMutableArray new];
        [self.dic setObject:array forKey:[NSString stringWithFormat:@"%c",character]];
    }
    //把省按拼音首字母分别放入数组
    for (NSString *city in self.citysArray)
    {
        if ([city isEqualToString:@"重庆市"])
        {
            NSMutableArray *array=[self.dic objectForKey:@"c"];
            [array addObject:city];
        }
        else
        {
            NSString *str=[NSString stringWithFormat:@"%c",pinyinFirstLetter([city characterAtIndex:0])];
            NSMutableArray *array=[self.dic objectForKey:str];
            [array addObject:city];
        }
    }

    //将空白数组去掉
    for (char character='a'; character<='z'; character++)
    {
        NSString *key=[NSString stringWithFormat:@"%c",character];
        NSArray *array=self.dic[key];
        if (array.count==0)
        {
            [self.dic removeObjectForKey:key];
        }
    }
    //按字母顺序进行排序
    self.keys=(NSMutableArray *)[self.dic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 24, screenWidth, screenHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    //设置标题栏的颜色为 orangColor
    self.tableView.backgroundColor=[UIColor orangeColor];
    //设置索引栏的背景颜色 greenColor
    self.tableView.sectionIndexBackgroundColor=[UIColor greenColor];
    
    [self.view addSubview:self.tableView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//一共有几个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keys.count;
}
//每个分区有几个单元格
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key=[self.keys objectAtIndex:section];
    NSArray *array=self.dic[key];
    return array.count;
}
//每个分区的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title=self.keys[section];
    return title;
}
//单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    //取出关键字:首字母
    NSString *key=self.keys[indexPath.section];
    //通过关键字在字典得到数组，通过indexpath.row取出内容一行的内容
    NSArray *array=self.dic[key];
    cell.textLabel.text=array[indexPath.row];
    //设置单元格的背景色为 lightGrayColor
    cell.backgroundColor=[UIColor lightGrayColor];
    return cell;
}
//添加索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.keys;
}
//对选中行进行的操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //取出关键字:首字母
    NSString *key=self.keys[indexPath.section];
    //通过关键字在字典得到数组
    NSArray *array=self.dic[key];
    //得到选中行的城市名
    NSString *city=array[indexPath.row];
    NSLog(@"%@",city);
    
//    FirstViewController *firVC=[FirstViewController new];
//    firVC.str=city;
//    firVC.dic=self.dic;
//    firVC.keys=self.keys;
//    [self presentViewController:firVC animated:YES completion:nil];
    
    SchoolTableViewController *schoolVC=[SchoolTableViewController new];
    schoolVC.str=city;
    schoolVC.dic=self.dic;
    schoolVC.keys=self.keys;
    [self presentViewController:schoolVC animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
