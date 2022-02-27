//
//  CombinedChartViewController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//

#import "CombinedChartViewController.h"

@interface CombinedChartViewController ()<ChartViewDelegate>
{
@protected
    NSArray *months;
    NSArray *parties;
}

@property (nonatomic ,strong)CombinedChartView *chartView;
@property (nonatomic ,strong)NSArray *options;
@end

@implementation CombinedChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"组合图";
    
    _chartView = [[CombinedChartView alloc]init];
    _chartView.frame = CGRectMake(0, 164, self.view.frame.size.width, 400);
    _chartView.delegate = self;
    [self.view addSubview:_chartView];
    self.options = @[
                     @{@"key": @"toggleLineValues", @"label": @"Toggle Line Values"},
                     @{@"key": @"toggleBarValues", @"label": @"Toggle Bar Values"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     ];
    _chartView.noDataText = @"You need to provide data for the chart.";
//    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
//    _chartView.drawOrder = @[@(DrawOrderBar), @(DrawOrderLine)];
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    
    CombinedChartData *data = [[CombinedChartData alloc] initWithDataSets:months];
    data.lineData = [self generateLineData];
    data.barData = [self generateBarData];
    
    _chartView.data = data;
    
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleLineValues"])
    {
        for (ChartDataSet *set in _chartView.data.dataSets)
        {
            if ([set isKindOfClass:LineChartDataSet.class])
            {
                set.drawValuesEnabled = !set.isDrawValuesEnabled;
            }
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleBarValues"])
    {
        for (ChartDataSet *set in _chartView.data.dataSets)
        {
            if ([set isKindOfClass:BarChartDataSet.class])
            {
                set.drawValuesEnabled = !set.isDrawValuesEnabled;
            }
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"saveToGallery"])
    {
//        [_chartView saveToCameraRoll];
    }
}

- (LineChartData *)generateLineData
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < 12; index++)
    {
        [entries addObject:[ChartDataEntry alloc]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithEntries:entries label:@"Line DataSet"];
    [set setColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.lineWidth = 2.5f;
    [set setCircleColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.fillColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    set.drawIconsEnabled = YES;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData
{
    BarChartData *d = [[BarChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < 12; index++)
    {
//        [entries addObject:[[BarChartDataEntry alloc] initWithValue:(arc4random_uniform(15) + 30) xIndex:index]];
        [entries addObject:[BarChartDataEntry alloc]];
    }
    
//    BarChartDataSet *set = [[BarChartDataSet alloc] initWithYVals:entries label:@"Bar DataSet"];
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:entries label:@"Bar DataSet"];
    [set setColor:[UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f]];
    set.valueTextColor = [UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f];
    set.valueFont = [UIFont systemFontOfSize:10.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
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
