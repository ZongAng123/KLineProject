//
//  ViewController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/24.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "ViewController.h"
#import "LineChartsController.h"//折线图1
#import "GWLLineChartViewController.h" //折线图2
#import "ZALineChartViewController.h" //折线图3
#import "PieChartsController.h"//饼图
#import "BarChartsController.h"//柱状图
#import "RadarChartController.h" //雷达图
#import "BubbleChartController.h" //散点图
#import "HorizontalBarChartController.h" //横向图
#import "ModelController.h"
#import "CandleStickChartController.h" //K线
#import "CombinedChartViewController.h" //组合图

#import "KLineProject-Bridging-Header.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *cell_array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Charts库";
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = NO;
    cell_array = [NSArray arrayWithObjects:@"折线图1",@"折线图2",@"折线图3",@"饼状图",@"柱状图",@"横向图",@"雷达图",@"散点图",@"Model",@"K线",@"组合图",  nil];
    [self.view addSubview:tableview];
    
    
#pragma mark - 获取当前位置
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cell_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"tableview";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    for (UIView *view in _cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    _cell.textLabel.text = cell_array[indexPath.row];
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LineChartsController *linevc = [[LineChartsController alloc]init];
            linevc.title = @"折线图1";
            [self.navigationController pushViewController:linevc animated:YES];
        }
            break;
        case 1:
        {
            GWLLineChartViewController *linevc = [[GWLLineChartViewController alloc]init];
            linevc.title = @"折线图2";
            [self.navigationController pushViewController:linevc animated:YES];
        }
            break;
        case 2:
        {
            ZALineChartViewController *linevc = [[ZALineChartViewController alloc]init];
            linevc.title = @"折线图3";
            [self.navigationController pushViewController:linevc animated:YES];
        }
            break;
        case 3:
        {
            PieChartsController *controll = [[PieChartsController alloc]init];
            controll.title = @"饼状图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 4:
        {
            BarChartsController *controll = [[BarChartsController alloc]init];
            controll.title = @"柱状图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 5:
        {
            HorizontalBarChartController *controll = [[HorizontalBarChartController alloc]init];
            controll.title = @"横向图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 6:
        {
            RadarChartController *controll = [[RadarChartController alloc]init];
            controll.title = @"雷达图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 7:
        {
            BubbleChartController *controll = [[BubbleChartController alloc]init];
            controll.title = @"散点图";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 8:
        {
            ModelController *controll = [[ModelController alloc]init];
            controll.title = @"Model";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        case 9:
        {
            CandleStickChartController *controll = [[CandleStickChartController alloc]init];
            controll.title = @"K线";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
        default:
        {
            CombinedChartViewController *controll = [[CombinedChartViewController alloc]init];
            controll.title = @"组合";
            [self.navigationController pushViewController:controll animated:YES];
        }
            break;
            
    }
}


@end
