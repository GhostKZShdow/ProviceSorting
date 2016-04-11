//
//  FirstViewController.m
//  1213
//
//  Created by kz on 15/8/12.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import "FirstViewController.h"
#define screenWidth [[UIScreen mainScreen]bounds].size.width
#define screenHeight [[UIScreen mainScreen]bounds].size.height
@interface FirstViewController ()
@property (nonatomic,strong) NSMutableArray *countryArray;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    //设置返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 24, screenWidth, 20);
    backBtn.backgroundColor=[UIColor lightGrayColor];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //取json文件
    NSString *path=[[NSBundle mainBundle]pathForResource:@"city" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    //json文件放入cityDic字典中
    NSDictionary *cityDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //从cityDic字典中取出内容放入cityArray中
    NSArray *cityArray=cityDic[@"city"];
    
    self.countryArray=[NSMutableArray new];
    for (int i=0; i<cityArray.count; i++)
    {
        //循环取出省:cityArray[i]是一个字典 从该字典中根据关键字@“province_name”取出省
        NSString *city=cityArray[i][@"province_name"];
        
        //判断选中的cell的内容（省，从上个页面取出的）与上一步取出的省是否相等
        if ([self.str isEqualToString:city])
        {
            //相等，根据关键字city取出该省中的数组，包含city_id和city_name;
            NSArray *array=cityArray[i][@"city"];
            //循环取出该省里面的市区，放入self.countryArray中
            for (int j=0; j<array.count; j++)
            {
                NSString *country=array[j][@"city_name"];
                [self.countryArray addObject:country];
            }
        }
    }
    
    //初始化tableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, screenWidth, screenHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:backBtn];
    [self.view addSubview:self.tableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//有几个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每个分区有几个单元格
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countryArray.count;
}
//每个单元格的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    cell.textLabel.text=self.countryArray[indexPath.row];
    return cell;
}
//返回上一页
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
