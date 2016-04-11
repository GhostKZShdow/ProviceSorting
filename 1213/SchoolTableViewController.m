//
//  SchoolTableViewController.m
//  1213
//
//  Created by kz on 15/8/12.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import "SchoolTableViewController.h"
#import "SchoolTableViewCell.h"
#define screenWidth [[UIScreen mainScreen]bounds].size.width
#define screenHeight [[UIScreen mainScreen]bounds].size.height
@interface SchoolTableViewController ()
@property (strong,nonatomic) NSMutableArray *oneCitySchoolsArray;
@property (strong,nonatomic) NSMutableArray *oneCitySchoolNameArray;
@property (strong,nonatomic) NSMutableArray *oneCitySchoolImageNameArray;
@end

@implementation SchoolTableViewController

- (void)viewDidLoad {
    //设置返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 24, screenWidth, 20);
    backBtn.backgroundColor=[UIColor lightGrayColor];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%@",self.str);
    NSLog(@"%@",self.dic);
    NSLog(@"%@",self.keys);
    //取出schoolData.json文件放入Array数组中
    NSString *path=[[NSBundle mainBundle]pathForResource:@"schoolData" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",Array);
    self.oneCitySchoolsArray=[NSMutableArray new];
    self.oneCitySchoolNameArray=[NSMutableArray new];
    self.oneCitySchoolImageNameArray=[NSMutableArray new];
    for (int i=0; i<array.count; i++)
    {
        //取出上一页选择的省
        if ([self.str isEqualToString:array[i][@"provinceName"] ])
        {
            NSLog(@"%d",i);
            //取出该省的schools
            self.oneCitySchoolsArray=array[i][@"schools"];
            NSLog(@"%@",self.oneCitySchoolsArray);
        }
    }
    //取出该省的schools数组里的name放在数组self.oneCitySchoolNameArray中
    //self.oneCitySchoolNameArray中存放的是选中省的所有大学名字
    for (int i=0; i<self.oneCitySchoolsArray.count; i++)
    {
        NSString *schoolName=self.oneCitySchoolsArray[i][@"name"];
        [self.oneCitySchoolNameArray addObject:schoolName];
        NSString *schoolImageName=self.oneCitySchoolsArray[i][@"school_image"];
        [self.oneCitySchoolImageNameArray addObject:schoolImageName];
    }
//    for (NSString *a in self.oneCitySchoolNameArray) {
//        NSLog(@"%@",a);
//    }
    NSLog(@"%@",self.oneCitySchoolImageNameArray);
    [self.view addSubview:backBtn];
    
    
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"schoolCell"];
    self.view.frame=CGRectMake(0, 44, screenWidth, screenHeight-44);
    NSLog(@"%@",self.view);
    NSLog(@"%@",self.tableView);
    
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.oneCitySchoolNameArray.count;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier=@"schoolCell";
//    SchoolTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell==nil)
//    {
//        cell=[[SchoolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    cell.imageView.image=[UIImage imageNamed:self.oneCitySchoolImageNameArray[indexPath.row]];
//    cell.textLabel.text=self.oneCitySchoolNameArray[indexPath.row];
////    cell.textLabel.frame=CGRectMake(150, 0, 100, 50);
////    cell.textLabel.backgroundColor=[UIColor lightGrayColor];
////    cell.textLabel.text=self.oneCitySchoolNameArray[indexPath.row];
//    
//    return cell;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer=@"cell";
    SchoolTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil)
    {
        cell=[[SchoolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.img.image=[UIImage imageNamed:self.oneCitySchoolImageNameArray[indexPath.row]];
//    cell.img.image=[UIImage imageNamed:@"2.jpg"];
    cell.text.text=self.oneCitySchoolNameArray[indexPath.row];
    //多行显示
    cell.text.numberOfLines=0;
    //
    //    CGSize size=CGSizeMake(100, 262);
    //按内容换行，以及换行方式
    //    CGSize requireSize=[cell.text.text sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    //重新计算，得到新的frame
    //    cell.text.frame=CGRectMake(160, 25, 200, requireSize.height);
    //    CGRect rect=cell.frame;
    //    rect.size.height=size.height;
    //    cell.frame=rect;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
