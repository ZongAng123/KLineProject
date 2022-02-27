//
//  CandleStickChartController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//

#import "CandleStickChartController.h"

@interface CandleStickChartController ()<ChartViewDelegate>
@property (nonatomic ,strong)CandleStickChartView *chartView;

@end

@implementation CandleStickChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ssRGB(32, 50, 71);
    
    _chartView = [[CandleStickChartView alloc]init];
    self.chartView.frame = CGRectMake(0, 164, self.view.frame.size.width, 400);
    _chartView.delegate = self;
    [self.view addSubview:_chartView];
//    如果需要显示选中图表位置进行数据展示 需要设置代理 可选项 chartView.delegate = self;
    _chartView.backgroundColor = ssRGB(32, 50, 71);
//    chartView.descriptionTextColor = [UIColor blackColor];
    _chartView.noDataTextColor =[UIColor whiteColor];
//    如果不想要描述文字就直接赋值为空字串
//    chartView.descriptionText = @"";
    //无内容显示
    _chartView.noDataText = @"好";
//    取消双击缩放
    _chartView.doubleTapToZoomEnabled = NO;
//    画板以及边框颜色
    _chartView.gridBackgroundColor =[UIColor clearColor];
    _chartView.borderColor =[UIColor clearColor];
    _chartView.pinchZoomEnabled = NO;
//    根据需要显示或隐藏边框以及画板
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBordersEnabled = NO;
//    设置X轴相关参数
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.forceLabelsEnabled = NO;
    [_chartView animateWithYAxisDuration:1.5];
    [_chartView animateWithXAxisDuration:1.5];
//    设置y轴相关参数 将坐标轴显示在左边
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelCount = 7;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawAxisLineEnabled = YES;
//    label位置
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//    文字颜色
    leftAxis.labelTextColor = [UIColor whiteColor];
//    文字字体
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = NO;
    
//    这里的数据为随机数据
//    横轴数据
    NSMutableArray *xValues = [NSMutableArray array];
        for (int i = 0; i <= 100; i++) {
        [xValues addObject:[NSString stringWithFormat:@"%d", i + 1993]];
        }
    _chartView.maxVisibleCount = 10;
    _chartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];
    
//    初始化CandleChartDataEntry数组
    NSMutableArray *yValues = [NSMutableArray array];
    for (int i=0; i<= 100; i++) {
        CGFloat val = (arc4random_uniform(40));
        CGFloat high = (arc4random_uniform(9)) + 8.0;
        CGFloat low = (arc4random_uniform(9)) + 8.0;
        CGFloat open = (arc4random_uniform(6)) + 1.0;
        CGFloat close = (arc4random_uniform(6)) + 1.0;
        CGFloat even = i % 2 == 0;
        CandleChartDataEntry *y = [[CandleChartDataEntry alloc] initWithX:i shadowH:val + high shadowL:val - low open:even ? val + open : val - open close:even ? val + close : val - close];
        [yValues addObject:y];
    }
    
    CandleChartDataSet * set1 =[[CandleChartDataSet alloc]initWithEntries:yValues label:@"data set"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor blueColor]];
//    这是用于显示最高最低值区间的立线
    set1.shadowColor = [UIColor whiteColor];
//    不在面板上直接显示数值
    set1.drawValuesEnabled = NO;
//    立线的宽度
    set1.shadowWidth = 0.7;
//     close >= open
    set1.increasingColor = [UIColor redColor];
//    内部是否充满颜色
    set1.decreasingFilled = true;
//    open > close
    set1.decreasingColor = [UIColor greenColor];
//    内部是否充满颜色
    set1.increasingFilled = true;
//    赋值数据
    CandleChartData *data = [[CandleChartData alloc] initWithDataSet:set1];
    _chartView.data = data;
    
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
