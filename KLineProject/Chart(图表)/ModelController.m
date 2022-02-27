//
//  ModelController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "ModelController.h"

@interface ModelController ()<ChartViewDelegate>
@property (nonatomic ,strong)LineChartView *chartView;

@end

@implementation ModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _chartView = [[LineChartView alloc]init];
    self.chartView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100);
    _chartView.delegate = self;
    [self.view addSubview:_chartView];
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
#pragma mark - 界限、限制线、警戒线  2022-2-25  zongang
    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
    llXAxis.lineWidth = 4.0;
    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
    llXAxis.labelPosition = ChartLimitLabelPositionBottomRight;
    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
//    [_chartView.xAxis addLimitLine:llXAxis];
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.f;
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionTopRight;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.lineDashLengths = @[@5.f, @5.f];
    ll2.labelPosition = ChartLimitLabelPositionBottomRight;
    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = -50.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
#pragma mark - 指示是否应绘制零线而不考虑其他网格线的标志
    leftAxis.drawZeroLineEnabled = NO;
//    Are the LimitLines drawn behind the data or in front of the data?
#pragma mark - 界限是在数据后面还是在数据前面画的？
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
#pragma mark - The right y-axis object. In the horizontal bar-chart, this is the bottom axis.
#pragma mark - 右y轴对象。在水平条形图中，这是底轴。
    _chartView.rightAxis.enabled = NO;
    
#pragma mark -
}

- (void)setData{
    int count = 15;
    double range = 20;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count - 1; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 450;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 500;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil, *set2 = nil, *set3 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        set3 = (LineChartDataSet *)_chartView.data.dataSets[2];
        set1.visible = yVals1;
        set2.visible = yVals2;
        set3.visible = yVals3;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {

        set1 =[[LineChartDataSet alloc]initWithEntries:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        set2 = [[LineChartDataSet alloc]initWithEntries:yVals1 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:UIColor.redColor];
        [set2 setCircleColor:UIColor.whiteColor];
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 65/255.0;
        set2.fillColor = UIColor.redColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
        
        set3 = [[LineChartDataSet alloc] initWithEntries:yVals3 label:@"DataSet 3"];
        set3.axisDependency = AxisDependencyRight;
        [set3 setColor:UIColor.yellowColor];
        [set3 setCircleColor:UIColor.whiteColor];
        set3.lineWidth = 2.0;
        set3.circleRadius = 3.0;
        set3.fillAlpha = 65/255.0;
        set3.fillColor = [UIColor.yellowColor colorWithAlphaComponent:200/255.f];
        set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set3.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
    }
}
- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [NSMutableArray array];
    NSMutableArray *yVals2 = [NSMutableArray array];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 450;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil;
    LineChartDataSet *set2 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        set1.visible = yVals1;
        set2.visible = yVals2;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }else{
        set1 =[[LineChartDataSet alloc]initWithEntries:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:255/255.0 green:241/255.0 blue:46/255.0 alpha:1.0]];
        set1.drawCirclesEnabled = NO;
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 1.0;
        set1.drawFilledEnabled = YES;
        set1.fillColor = UIColor.whiteColor;
        set1.highlightColor = [UIColor colorWithRed:244/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = NO;
        set1.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
            return self.chartView.leftAxis.axisMinimum;
        }];
        
        set2 =[[LineChartDataSet alloc]initWithEntries:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyLeft;
        [set2 setColor:[UIColor colorWithRed:255/255.0 green:241/255.0 blue:46/255.0 alpha:1.0]];
        set2.drawCirclesEnabled = NO;
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 1.0;
        set2.drawFilledEnabled = YES;
        set2.fillColor = UIColor.whiteColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set2.drawCircleHoleEnabled = NO;
        set2.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
            return self.chartView.leftAxis.axisMaximum;
        }];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setDrawValues:NO];
        
        _chartView.data = data;
    }
}
- (void)set2DataCount:(int)count range:(double)range
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval hourSeconds = 3600.0;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSTimeInterval from = now - (count / 2.0) * hourSeconds;
    NSTimeInterval to = now + (count / 2.0) * hourSeconds;
    
    for (NSTimeInterval x = from; x < to; x += hourSeconds)
    {
        double y = arc4random_uniform(range) + 50;
        [values addObject:[[ChartDataEntry alloc] initWithX:x y:y]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0){
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.visible = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }else{
        set1 =[[LineChartDataSet alloc]initWithEntries:values label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        set1.valueTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.lineWidth = 1.5;
        set1.drawCirclesEnabled = NO;
        set1.drawValuesEnabled = NO;
        set1.fillAlpha = 0.26;
        set1.fillColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.highlightColor = [UIColor colorWithRed:224/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
        
        _chartView.data = data;
    }
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
