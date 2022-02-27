//
//  RadarChartController.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//

#import "RadarChartController.h"


@interface RadarChartController ()<ChartViewDelegate>
{
    ChartXAxis *xAxis;
}
@property (nonatomic ,strong)RadarChartView *radarChartView;


@end

@implementation RadarChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.radarChartView = [[RadarChartView alloc] init];
    [self.view addSubview:self.radarChartView];
    self.radarChartView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.radarChartView.delegate = self;
    self.radarChartView.chartDescription.text = @"描述";//描述
    self.radarChartView.rotationEnabled = YES;//是否允许转动
    self.radarChartView.highlightPerTapEnabled = YES;//是否能被选中
//    设置雷达图样式
//    1. 设置雷达图线条样式
        self.radarChartView.webLineWidth = 0.5;//主干线线宽
        self.radarChartView.webColor = [UIColor orangeColor];//主干线线宽
        self.radarChartView.innerWebLineWidth = 0.375;//边线宽度
        self.radarChartView.innerWebColor = [UIColor greenColor];//边线颜色
        self.radarChartView.webAlpha = 1;//透明度
//    2. 设置X轴label样式
        xAxis = self.radarChartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:15];//字体
        xAxis.labelTextColor = [UIColor redColor];//颜色
//    3. 设置Y轴label样式
        ChartYAxis *yAxis = self.radarChartView.yAxis;
        yAxis.axisMinimum = 0.0;//最小值
        yAxis.axisMaximum = 150.0;//最大值
        yAxis.drawLabelsEnabled = NO;//是否显示 label
        yAxis.labelCount = 6;// label 个数
        yAxis.labelFont = [UIFont systemFontOfSize:9];// label 字体
        yAxis.labelTextColor = [UIColor lightGrayColor];// label 颜色
        _radarChartView.data= [self setData];
}

//三、提供数据
- (RadarChartData *)setData{
    double mult = 100;
    int count = 12;//维度的个数
    
    //每个维度的名称或描述
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d 月", i+1]];
    }
    
    //每个维度的数据
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        double randomVal = arc4random_uniform(mult) + mult / 2;//产生 50~150 的随机数
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i+1 y:randomVal];
        [yVals1 addObject:entry];
    }
    // dataSet
//    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:yVals1 label:@"set 1"];
    RadarChartDataSet * set1 =[[RadarChartDataSet alloc]initWithEntries:yVals1 label:@"set1"];
    set1.lineWidth = 0.5;//数据折线线宽
    [set1 setColor:[UIColor blueColor]];//数据折线颜色
    set1.drawFilledEnabled = YES;//是否填充颜色
    set1.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];//填充颜色
    set1.fillAlpha = 0.25;//填充透明度
    set1.drawValuesEnabled = NO;//是否绘制显示数据
    set1.valueFont = [UIFont systemFontOfSize:9];//字体
    set1.valueTextColor = [UIColor grayColor];//颜色
    //data
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1]];
    
    return data;
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
