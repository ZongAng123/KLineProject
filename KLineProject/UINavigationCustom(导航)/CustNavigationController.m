//
//  CustNavigationController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//

#import "CustNavigationController.h"

@interface CustNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CustNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    
//     无效果
//   self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
/*
 这样修改的是navigationBar的背景色，而navigationBar里面添加了UIView和UIImageView，UILabel等控件，覆盖了navigationBar
 */

    
//     可行
   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 自定义导航栏左侧按钮
       UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       leftBtn.frame = CGRectMake(0, 7, 83, 30);
       leftBtn.backgroundColor = [UIColor orangeColor];
       [leftBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
       self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}

// 点击事件处理
- (void)onTap {
    NSLog(@"点击了导航栏左侧按钮");
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
