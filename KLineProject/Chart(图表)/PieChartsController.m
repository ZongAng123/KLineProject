//
//  PieChartsController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//  饼图
//

#import "PieChartsController.h"

@interface PieChartsController ()
@property (nonatomic ,strong)PieChartView *pieChartView;

@end

@implementation PieChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    _pieChartView = [[PieChartView alloc] initWithFrame:CGRectZero];
    _pieChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieChartView];
    self.pieChartView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);
//-------------------- 饼状图的配置----------------------
//     动画
    [self.pieChartView animateWithXAxisDuration:1];
    [self.pieChartView animateWithYAxisDuration:1];
//     饼状图距离边缘的间隙
    [_pieChartView setExtraOffsetsWithLeft:35 top:10 right:35 bottom:10];
//     是否根据所提供的数据, 将显示数据转换为百分比格式
    _pieChartView.usePercentValuesEnabled = NO;
//     拖拽饼状图后是否有惯性效果
    _pieChartView.dragDecelerationEnabled = YES;
//     是否显示区块文本
    _pieChartView.drawCenterTextEnabled = NO;
//     饼状图是否是空心
    _pieChartView.drawHoleEnabled = YES;
//     空心半径占比
    _pieChartView.holeRadiusPercent = 0.5;
//     空心颜色
    _pieChartView.holeColor = [UIColor clearColor];
//     半透明空心半径占比
    _pieChartView.transparentCircleRadiusPercent = 0.52;
//     半透明空心的颜色
    _pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];
//      设置空心文字
    if (_pieChartView.isDrawHoleEnabled == YES) {
//     是否显示中间文字
        _pieChartView.drawCenterTextEnabled = YES;
//      普通文本
//     中间文字
        _pieChartView.centerText = @"西瓜";
//      富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"西瓜详情"];
        [centerText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, centerText.length)];
        _pieChartView.centerAttributedText = centerText;
    }
//       设置饼状图描述
//      是否开启描述label
    _pieChartView.chartDescription.enabled = NO;
//    -------------------------legend图例的属性配置-------------------------------
//     是否开启图例
    _pieChartView.legend.enabled = NO;
//     图例在饼状图中的大小占比, 这会影响图例的宽高
    _pieChartView.legend.maxSizePercent = 1;
//      文本间隔
    _pieChartView.legend.formToTextSpace = 5;
//       图例间隔大小
    _pieChartView.legend.yEntrySpace = 5;//10;
//       字体大小
    _pieChartView.legend.font = [UIFont systemFontOfSize:20];
//      字体颜色
    _pieChartView.legend.textColor = [UIColor grayColor];
//       图例在饼状图中的位置
//        图示样式: 方形、线条、圆形
    _pieChartView.legend.form = ChartLegendFormSquare;
//        图示大小
    _pieChartView.legend.formSize =10;
//    ------------------------饼状图的数据配置----------------------
//       每个区块的金额数
    NSMutableArray* moneyArray =[NSMutableArray arrayWithArray:@[@10,@20,@30,@40,@50]];

//      每个区块的颜色
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor colorWithRed:141/255.f green:116/255.f blue:244/255.f alpha:1]];
    [colors addObject:[UIColor colorWithRed:245/255.f green:101/255.f blue:103/255.f alpha:1]];
    [colors addObject:[UIColor orangeColor]];
    [colors addObject:[UIColor greenColor]];
    [colors addObject:[UIColor redColor]];
    // 每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for(int i =0; i < moneyArray.count; i++) {
        double randomVal = [moneyArray[i] doubleValue];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:randomVal];
        [yVals addObject:entry];
    }
//    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
    PieChartDataSet * dataSet =[[PieChartDataSet alloc]initWithEntries:yVals label:@""];
//     是否绘制显示数据
    dataSet.drawValuesEnabled = YES;
//     区块颜色
    dataSet.colors= colors;
//     相邻区块之间的间距
    dataSet.sliceSpace=0;
//     选中区块时, 放大的半径
    dataSet.selectionShift=12;
//     名称位置
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;
//     数据位置
//     数据与区块之间的用于指示的折线样式
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
//     折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1OffsetPercentage = 0.85;
//     折线中第一段长度占比
    dataSet.valueLinePart1Length = 0.4;
//     折线中第二段长度最大占比
    dataSet.valueLinePart2Length = 0.6;
//     折线的粗细
    dataSet.valueLineWidth=1.0;
//     折线颜色
    dataSet.valueLineColor= [UIColor redColor];
    dataSet.valueLineVariableLength = YES;
    dataSet.valueTextColor= [UIColor blackColor];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;//NSNumberFormatterPercentStyle;
    [formatter setPositiveFormat:@"###,##0.00;"];
//     小数位数
    formatter.maximumFractionDigits = 2;
    formatter.multiplier=@1.f;
    formatter.paddingPosition = NSNumberFormatterPadBeforeSuffix;
//     数据设置上去
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    _pieChartView.data = data;

    
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
