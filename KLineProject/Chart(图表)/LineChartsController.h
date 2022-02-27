//
//  LineChartsController.h
//  KLineProject
//
//  Created by 纵昂 on 2022/2/25.
//  折线图
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LineChartsController : UIViewController

@end

NS_ASSUME_NONNULL_END

/*
 
 iOS - 引用Charts库及使用
 可以绘制柱状图、折线图、K线图、饼状图等Charts，且和Android一致的图表界面MPAndroidChart。
 Charts是一套非常漂亮的开源图表组件，它是MPAndroidChart在苹果端的移植版本，同时支持iOS/tvOS/OSX平台。
 Charts是用 Swift语言编写的，能够同时在 Swift 和 Objc 工程中使用。
 
 特性（Features）
 核心功能：
 支持8种不同的图表类型
 1、支持两轴缩放（支持触摸手势,两轴单独或同时的放缩）
 2、支持使用触摸手势进行 拖拽/平移。
 3、组合图表（线状，柱状，散点图，蜡烛图，气泡图等）
 4、多个（或单独）的轴
 5、可自定义坐标轴 （包括x 轴和 y 轴）
 6、高亮显示值（支持自定义popup-view来显示选中的值）
 7、可保存图表到 Camera-roll, 支持导出为 PNG 和 JPEG格式
 8、预定义的颜色模板
 9、图例（可自动生成，或者自定义）
 9、动画（支持在x和y轴上建立动画）
 10、限制线（用来提供附加信息，最大值...）
 11、完全自定义（paints，字体，图例，颜色，背景，手势，虚线，...）
 可直接从 Realm.io 移动数据库绘制数据

 图表类型示例：
 LineChart -（线状图、渐变填充）
 Combined-Chart - 组合图表（下图为线状图和柱状图）
 BarChart - (柱状图、多个数据集）
 Horizontal-BarChart(水平方向的柱状图)
 PieChart - (饼图)
 ScatterChart - 散点图（带正方形，三角形，圆形,等等）
 CandleStickChart - 蜡烛图（用于财务数据）
 BubbleChart - 气泡图（气泡覆盖的区域表示该值）
 RadarChart - 雷达图（蜘蛛网图）
 
 
 一、下载Charts框架
 下载地址：https://github.com/danielgindi/Charts.
 二、Pod导入Charts
 1、创建桥接文件引入
 2、创建图表
 3、示例代码
 
 
 */
