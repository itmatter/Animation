//
//  RootTableViewController.m
//  Animation
//
//  Created by 李礼光 on 2017/8/21.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "RootTableViewController.h"
#import "BaseAnimation.h"
#import "GroupAnimation.h"
#import "AdvancedAnimation.h"


static NSString *cellIdentify = @"contentCell";

@interface RootTableViewController ()
@property (nonatomic, strong) NSArray *contentArr;
@end

@implementation RootTableViewController

#pragma mark - 懒加载
- (NSArray *)contentArr {
    if (_contentArr ==nil) {
        _contentArr = [NSArray arrayWithObjects:[BaseAnimation class],[GroupAnimation class],[AdvancedAnimation class], nil];
    }
    return _contentArr;
}


#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Animation";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentify];
    
    //● 多出利用绘图技术，采用贝塞尔曲线进行界面绘制。
    //● 合理利用 CAGradientLayer、CAShapeLayer、CAKeyframeAnimation 进行折线图、曲线图的绘制。

}



#pragma mark - 代理方法
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    
    cell.textLabel.text = NSStringFromClass(self.contentArr[indexPath.row]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[self.contentArr[indexPath.row] alloc] init]
                                         animated:YES];
}

@end
