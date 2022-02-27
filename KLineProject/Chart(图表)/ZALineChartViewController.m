//
//  ZALineChartViewController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "ZALineChartViewController.h"

@interface ZALineChartViewController ()<ChartViewDelegate>
@property (strong, nonatomic) LineChartView *chatView;

@end

@implementation ZALineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title = @"折线图3";
    _chatView = [[LineChartView alloc]init];
    _chatView.frame = CGRectMake(0, 80, self.view.frame.size.width-10, 300);
    [self.view addSubview:_chatView];
//    设置间隙
    [_chatView setExtraOffsetsWithLeft:10 top:10 right:10 bottom:10];
//    设置边框
    _chatView.borderColor =[UIColor blueColor];
    _chatView.borderLineWidth = 0.5;
    _chatView.drawBordersEnabled = YES;
//    绘制网格背景
    _chatView.drawGridBackgroundEnabled = NO;
    _chatView.gridBackgroundColor = [UIColor grayColor];
//    关于图表的描述
    _chatView.chartDescription.enabled = NO;
    _chatView.chartDescription.text = @"tiny`s charts demo";
//    是否显示图例
    _chatView.legend.enabled = NO;
//    没有数据时显示
    _chatView.noDataText = @"暂无数据";
//    x y轴是否支持拖拽
    _chatView.scaleXEnabled = YES;
    _chatView.scaleYEnabled = NO;
//    是否支持xy轴同时缩放
    _chatView.pinchZoomEnabled = NO;
//    是否支持双击缩放
    _chatView.doubleTapToZoomEnabled = NO;
//    高亮点击
    _chatView.highlightPerTapEnabled = YES;
//    高亮拖拽
    _chatView.highlightPerDragEnabled = YES;
//    自动缩放
    _chatView.autoScaleMinMaxEnabled  = YES;
//    启用拖拽
    _chatView.dragEnabled = YES;
//    代理方法
    _chatView.delegate = self;
#pragma mark - 是否支持marker功能 这里可以自定义一个点击弹窗的marker
    _chatView.drawMarkers = YES;
    ChartMarkerView * makerView = [[ChartMarkerView alloc]init];
    makerView.chartView = _chatView;
    _chatView.marker = makerView;
    
#pragma mark - lineChartView可以设置坐标轴的属性 leftAxis,rightAxis,xAxis
    ChartYAxis * leftAxis = _chatView.leftAxis;
//    是否使能left坐标轴
    leftAxis.enabled = YES;
//    坐标值在外部还是内部
    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
//    最多显示的点数 默认为6
    leftAxis.labelCount = 5;
//    小数位
    leftAxis.decimals = 2;
//    是否要画网格线
    leftAxis.drawGridLinesEnabled = YES;
//    虚线相位
    leftAxis.gridLineDashLengths = @[@2,@5];
//    是否显示顶部底部坐标值
    leftAxis.drawTopYLabelEntryEnabled = YES;
    leftAxis.drawBottomYLabelEntryEnabled = YES;
//    虚线宽度
//    leftAxis.gridLineWidth = 20;
//    设置重复不显示
    leftAxis.granularityEnabled = YES;
    leftAxis.granularity = YES;
//    强制显示指定个数 使能了这个属性
//    leftAxis.forceLabelsEnabled = YES;
//    抗锯齿功能是否打开 默认打开状态
    leftAxis.gridAntialiasEnabled = NO;
//    坐标点居中
    leftAxis.centerAxisLabelsEnabled = NO;
//    绘制零线
//    leftAxis.drawZeroLineEnabled = YES;
//    leftAxis.zeroLineColor = [UIColor blueColor];
    
//    轴线颜色 字体 线宽
    leftAxis.axisLineColor = [UIColor redColor];
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.labelTextColor = [UIColor redColor];
    leftAxis.axisLineWidth = 5;
    
//    leftAxis.yOffset = -5;
//    设置y轴上面显示格式 需要注意的是自定义的LeftAxisFormatter必须遵守IChartAxisValueFormatter协议，还需要重写-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis方法 具体后面会再讲解
    
//    leftAxis.valueFormatter = [LeftAxisFormatter new];
    
//    bottom Axis
    ChartXAxis *bmxAxis = _chatView.xAxis;
    bmxAxis.enabled = YES;
    bmxAxis.labelPosition = XAxisLabelPositionBottom;
//  bmxAxis.valueFormatter = [NSListFormatter new];
    bmxAxis.drawGridLinesEnabled = YES;
//  bmxAxis.xOffset = 10;
    bmxAxis.labelCount = 5;
    bmxAxis.forceLabelsEnabled = YES;
    bmxAxis.avoidFirstLastClippingEnabled = YES;  //避免文字显示不全 这个属性很重要
//    设置最多显示点数
    bmxAxis.axisMaximum = 40;
    bmxAxis.axisMinimum = 0;
    
    NSArray *datas = @[@30,@40,@80,@70,@20,@20,@30,@9,@19,@99,@7,@89,@67,@56,@150];

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < datas.count; i++) {
        //创建ChartDataEntry对象并将每个点对应的值与x轴 y轴进行绑定
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[datas[i] integerValue]];
        [array addObject:entry];
    }
    
//    创建一个集合并为这个集合赋值 label的值可为空
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithEntries:array label:@"Line DataSet"];
    //折线颜色
    [set setColor:[UIColor blueColor]];
    set.lineWidth = 1.5;
//    这里模式可以用来设置线条的类型：比如折线，平滑曲线等
    set.mode = LineChartModeLinear;
//    使能小圆圈 默认使能 通过圆圈和Hole可以画出空心圆的效果，这个在k线指标DKBY图中会用到的
    set.drawCirclesEnabled = NO;
//    圆圈半径
    set.circleRadius = 2.5;
//    圆圈颜色
    set.circleColors = @[UIColor.redColor];
//    使能圆圈孔
    set.drawCircleHoleEnabled = YES;
//    圆圈孔中心颜色
    set.circleHoleColor = [UIColor clearColor];
//    圆孔孔中心半径 这个半径要比圆圈半径小才可以看到空心圆效果
    set.circleHoleRadius = 2.f;
    set.lineDashPhase = .5f;
    set.lineDashLengths = @[@.5f];
    set.axisDependency = AxisDependencyRight;
//    set.lineCapType = kCGLineCapRound;
//    使能填充 填充效果可以达到股票交易软件中分时图的效果
    set.drawFilledEnabled = NO;
    set.drawValuesEnabled = NO;
//    取消高亮点击，如果设置为NO则线上所有点将无法点击 这个属性设置一定要注意
    set.highlightEnabled = NO;
//    取消横向纵向辅助线
//    set.drawHorizontalHighlightIndicatorEnabled = NO;
//    set.drawVerticalHighlightIndicatorEnabled = NO;
//    设置填充颜色
    set.fillColor = [UIColor redColor];
    
//   创建容器
    LineChartData *chartData = [[LineChartData alloc] initWithDataSet:set];
//   将数据添加到图中 注意这里可以是多条线  [chartData addDataSet:set]
    _chatView.data = chartData;

    
//     是否支持marker功能
    _chatView.drawMarkers = YES;
//    ChartMarkerView * makerView = [[ChartMarkerView alloc]init];
//    makerView.chartView = _chatView;
//    _chatView.marker = makerView;
////   maskView是自定义的UI
//    MaskView *masker = [[MaskView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    [makerView addSubview:masker];
//    self.maskView = masker;
    
    
    
    
    
}

#pragma mark 图表中数值被选中
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    
//    NSLog(@"图表中数值被选中");
//    [self.maskView updateMaskValue:entry.y];
}

#pragma mark 图表中的空白区域被选中
-(void)chartValueNothingSelected:(ChartViewBase *)chartView{
//    NSLog(@"空白区域被选中");
}

#pragma mark 图表被缩放
-(void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
//    NSLog(@"图表被缩放");
}

#pragma mark 图表被移动
-(void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
//    NSLog(@"图表被移动");
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
