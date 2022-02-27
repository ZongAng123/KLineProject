//
//  HorizontalBarChartController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  水平方向的柱状图
//

#import "HorizontalBarChartController.h"


@interface HorizontalBarChartController ()<ChartViewDelegate>
@property (nonatomic ,strong)HorizontalBarChartView *chartView;

@end

@implementation HorizontalBarChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _chartView = [[HorizontalBarChartView alloc]init];
    _chartView.frame = CGRectMake(5, 64+40, self.view.frame.size.width-40, self.view.frame.size.height-64-80);
    _chartView.delegate = self;
    [self.view addSubview:self.chartView];

    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    _chartView.maxVisibleCount = 60;
//    竖着的为x轴
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelFont = [UIFont systemFontOfSize:10.f];
        xAxis.drawAxisLineEnabled = YES;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.granularity = 10.0;
//    横向为y轴
        ChartYAxis *leftAxis = _chartView.leftAxis;//上面
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.drawAxisLineEnabled = YES;
        leftAxis.drawGridLinesEnabled = YES;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.enabled = YES;
        rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
        rightAxis.drawAxisLineEnabled = YES;//轴线
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        ChartLegend *l = _chartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        l.orientation = ChartLegendOrientationHorizontal;
        l.drawInside = NO;
        l.form = ChartLegendFormSquare;
        l.formSize = 1.0;
        l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        l.xEntrySpace = 4.0;
        
        _chartView.fitBars = YES;
        
        [_chartView animateWithYAxisDuration:1.0];
        [self setData];
}
#pragma mark - 简书地址:https://www.jianshu.com/u/88de89f5cc2c
#pragma mark - 加载数据
- (void)setData{
    double barWidth = 7.0;
    double spaceForBar = 10.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++){
        double mult = (10 + 1);
        double val = (double) (arc4random_uniform(mult));
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0){
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set1.visible = yVals;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }else{
        set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
        set1.drawIconsEnabled = NO;
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = barWidth;
        _chartView.data = data;
    }
}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
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
