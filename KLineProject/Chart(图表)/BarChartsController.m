//
//  BarChartsController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  柱状图
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "BarChartsController.h"


@interface BarChartsController ()<ChartViewDelegate,IChartAxisValueFormatter>
@property (nonatomic ,strong)BarChartView *barChartView;

@end

@implementation BarChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.barChartView = [[BarChartView alloc] init];
    self.barChartView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.barChartView.delegate = self;//设置代理
    [self.view addSubview:self.barChartView];
    
    //二、设置barChartView的外观样式
    //    1.基本样式
        self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
        self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
    //    2.barChartView的交互设置
        self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.barChartView.dragEnabled = YES;//启用拖拽图表
        self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //    3.设置barChartView的X轴样式
    //    首先需要先获取到barChartView的X轴，然后进行设置.
    //    通过barChartView的xAxis属性获取到X轴，代码如下：
    //    设置X轴样式的代码如下：
        ChartXAxis *xAxis = self.barChartView.xAxis;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.valueFormatter = self;
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.labelWidth = 4;
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    
    //    4.设置barChartView的Y轴样式
    //    barChartView默认样式中会绘制左右两侧的Y轴，首先需要先隐藏右侧的Y轴，代码如下：
        self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    //    接着开始设置左侧Y轴的样式.
    //    首先设置Y轴轴线的样式，代码如下：
        ChartYAxis *leftAxis = self.barChartView.leftAxis;
        leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
        leftAxis.axisMinimum = 0;//设置Y轴的最小值
        leftAxis.drawZeroLineEnabled = YES;
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    //    通过labelCount属性设置Y轴要均分的数量.
    //    在这里要说明一下，设置的labelCount的值不一定就是Y轴要均分的数量，这还要取决于forceLabelsEnabled属性，如果forceLabelsEnabled等于YES, 则强制绘制指定数量的label, 但是可能不是均分的.代码如下：
        leftAxis.labelCount = 5;
        leftAxis.forceLabelsEnabled = NO;
    //    设置Y轴上标签的样式，代码如下：
    
    
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
//    设置Y轴上标签显示数字的格式，代码如下：
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
//    设置Y轴上网格线的样式，代码如下：
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
//    在Y轴上添加限制线，代码如下：
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor greenColor];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionTopRight;//位置
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
//    5.设置barChartView的其它样式
//    通过legend获取到图例对象，然后把它隐藏掉，代码如下：
    self.barChartView.legend.enabled = NO;//不显示图例说明
    self.barChartView.data = [self setData];
    //设置动画效果，可以设置X轴和Y轴的动画效果
    [self.barChartView animateWithYAxisDuration:1.0f];
    
    
}

//为柱形图设置数据

- (BarChartData *)setData{
    int xVals_count = 12;//X轴上要显示多少条数据
    NSArray *maxYVal = @[@10,@9,@8,@7,@6,@5,@7,@8,@9,@10,@9,@8];
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = [maxYVal[i] doubleValue];
        double val = (double)mult;
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i+1 y:val];
        NSLog(@"%@",entry);
        [yVals addObject:entry];
    }
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
    set1.barBorderWidth = 1;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc]initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.multiplier   = @10;
    numberFormatter.positiveSuffix = @"K";
    self.barChartView.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    self.barChartView.leftAxis.axisMinimum = 0;//设置Y轴的最小值
    self.barChartView.leftAxis.axisMaximum = 12;
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.positiveSuffix = @"月";
    self.barChartView.xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:pFormatter];
    self.barChartView.xAxis.axisMaximum = 13;
    self.barChartView.xAxis.axisMinimum = 0;

    return data;
}
#pragma delegate
//1.点击选中柱形图时的代理方法，代码如下：
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
    NSLog(@"---chartValueSelected---value: %ld", (long)dataSetIndex);
}
//2.没有选中柱形图时的代理方法，代码如下：
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
//当选中一个柱形图后，在空白处双击，就可以取消选择，此时会回调此方法.
//3.捏合放大或缩小柱形图时的代理方法，代码如下：
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
//4.拖拽图表时的代理方法
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
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
