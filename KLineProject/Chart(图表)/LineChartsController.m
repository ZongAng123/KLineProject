//
//  LineChartsController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  折线图
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "LineChartsController.h"

@interface LineChartsController ()<ChartViewDelegate,IChartAxisValueFormatter>
@property (nonatomic ,strong)LineChartView *chartView;
@property (nonatomic ,strong)NSArray *xTitle;

@end

@implementation LineChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"折线图1";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chartView];
    [self setData:@[@59,@77,@23,@38,@90,@20]];
    [self setData:@[@33,@12,@80,@44]];
    
}

- (LineChartView *)chartView{
    if (_chartView == nil) {
        _chartView = [[LineChartView alloc]init];
        _chartView.frame = CGRectMake(0, 80, self.view.frame.size.width-10, 300);
        _chartView.noDataText = @"暂无数据";
        _chartView.scaleYEnabled = NO;//设置交互方式
        _chartView.dragDecelerationEnabled = YES;//启动拖拽图标
        _chartView.dragDecelerationFrictionCoef = 0.9;//拖拽后是否有惯性效果(0~1)，数值越小，惯性越不明显
        ChartXAxis *xAxis = _chartView.xAxis; // 设置 X 轴样式
        xAxis.labelPosition = XAxisLabelPositionBottom;// 设置 X 轴的显示位置，默认是显示在上面的
        xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;// 设置 X 轴线宽
        xAxis.axisLineColor = [UIColor blackColor];
        xAxis.granularityEnabled = YES;// 设置重复的值不显示
        xAxis.valueFormatter = self; // label 文字样式，自定义格式，默认时不显示特殊符号
        xAxis.labelTextColor = [UIColor blackColor];// label 文字颜色
        xAxis.drawGridLinesEnabled = NO;// // 不绘制网格线
        xAxis.axisMinimum = -0.4;
        _chartView.rightAxis.enabled = NO;// 设置 Y 轴样式不绘制右边轴
        ChartYAxis *leftAxis = _chartView.leftAxis;// 获取左边 Y 轴
        leftAxis.inverted = NO; // 是否将 Y 轴进行上下翻转
        leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;// 设置 Y 轴线宽
        leftAxis.axisLineColor = [UIColor orangeColor];// 设置 Y 轴颜色
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;// label 文字位置 YAxisLabelPositionInsideChart:在里面，YAxisLabelPositionOutsideChart:在外面
        leftAxis.labelTextColor = [UIColor blackColor]; // label 文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f]; // 不强制绘制指定数量的 label
        leftAxis.forceLabelsEnabled = NO; // 不强制绘制指定数量的 label
        leftAxis.gridLineDashLengths = @[@3.0f,@3.0f];// 设置虚线样式的网格线 网格线的大小
        leftAxis.gridColor = [UIColor redColor]; // 网格线颜色
        leftAxis.gridAntialiasEnabled = YES;// 网格线开启抗锯齿
        _chartView.chartDescription.enabled = NO;// 设置折线图描述
        _chartView.legend.enabled = NO; // 设置折线图图例
        [_chartView animateWithXAxisDuration:1.0f];// 设置动画效果，可以设置 X 轴和 Y 轴的动画效果
    }
    return _chartView;
}

#pragma mark -
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    //    return self.xTitle[(NSInteger)value];
    return [NSString stringWithFormat:@"11"];//x轴数据
}
- (void)setData:(NSArray *)dataArr{
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.axisMinimum = self.xTitle.count-0.5;
    NSMutableArray *valueArray = [NSMutableArray array];
    [valueArray addObject:dataArr];
    NSMutableArray *dataSets = [NSMutableArray array];
    double leftAxisMin = 0;
    double leftAxisMax = 0;
    for (int i = 0; i<valueArray.count; i++) {
        NSArray *values = valueArray[i];
        NSMutableArray *yVals = [NSMutableArray array];
        for (int j = 0; j<values.count; j++) {
            NSString *valStr = [NSString stringWithFormat:@"%@",values[j]];
            double val = [valStr doubleValue];
            leftAxisMax = MAX(val, leftAxisMax);
            leftAxisMin = MIN(val, leftAxisMax);
            ChartDataEntry *entry = [[ChartDataEntry alloc]initWithX:j y:val];
            [yVals addObject:entry];
        }
        [_chartView setVisibleXRangeWithMinXRange:1 maxXRange:4];
        LineChartDataSet * dataSet = [[LineChartDataSet alloc]initWithEntries:yVals];
        dataSet.lineWidth = 2.0f;//折线宽度
        dataSet.drawValuesEnabled = YES;//是否在拐点处显示数据
        dataSet.valueColors = @[[UIColor orangeColor],[UIColor redColor]];//折线拐点处显示数据的颜色
        dataSet.drawCirclesEnabled = NO;//是否开启绘制阶梯样式的折线图
        dataSet.cubicIntensity = 0.2;// 曲线弧度
        dataSet.circleRadius = 3.0f;//拐点半径
        dataSet.mode = LineChartModeCubicBezier;// 模式为曲线模式
        dataSet.axisDependency = AxisDependencyLeft;
        dataSet.circleHoleRadius = 2.0f;//空心的半径
        dataSet.circleColors = @[[UIColor blueColor]];//空心的圈的颜色
        dataSet.circleHoleColor = [UIColor grayColor];//空心的颜色
        dataSet.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        dataSet.highlightColor = [UIColor clearColor];
        dataSet.valueFont = [UIFont systemFontOfSize:12];
        dataSet.drawFilledEnabled = YES;//是否填充颜色
        // 设置渐变效果
        [dataSet setColor:[UIColor colorWithRed:0.114 green:0.812 blue:1.0 alpha:1.0]];//折线颜色
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,(id)[ChartColorTemplates colorFromString:@"#C4F3FF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        dataSet.fillAlpha = 1.0f;//透明度
        dataSet.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
        
        [dataSets addObject:dataSet];
    }
    double leftDiff = leftAxisMax - leftAxisMin;
    if (leftAxisMax == 0 && leftAxisMin == 0) {
        leftAxisMax = 100.0;
        leftAxisMin = 0;
    } else {
        leftAxisMax = (leftAxisMax + leftDiff * 0.2);
        leftAxisMin = (leftAxisMin - leftDiff * 0.1);
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.multiplier   = @0.001;
    numberFormatter.positiveSuffix = @"K";
    self.chartView.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    self.chartView.leftAxis.axisMinimum = 0;//设置Y轴的最小值
    self.chartView.leftAxis.axisMaximum = leftAxisMax;//设置Y轴的最大值
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.chartView.data = data;
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    pFormatter.maximumFractionDigits = 2; // 小数位数(销量小数位0)
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [self.chartView animateWithYAxisDuration:0.3f];
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
