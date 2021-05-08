//
//  CAKeyframeAnimation1ViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "CAKeyframeAnimation1ViewController.h"

@interface CAKeyframeAnimation1ViewController ()

@end

@implementation CAKeyframeAnimation1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    //创建测试帧动画的紫色图层
    UIView *purpleView = [UIView new];
    purpleView.frame = CGRectMake(0, 0, 50, 50);
    purpleView.center = CGPointMake(50, 100);
    purpleView.backgroundColor = [UIColor purpleColor];
    [purpleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    [self.view addSubview:purpleView];
    
    //步骤1：创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    //步骤2：设置动画关键帧数据
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.bounds) -50, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.bounds) -50, CGRectGetWidth(self.view.bounds)- 100)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(50, CGRectGetWidth(self.view.bounds) -100)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    animation.values = @[value1,value2,value3,value4,value5];
    //步骤3：设定动画属性
    animation.repeatCount = MAXFLOAT; //重复执行
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.duration = 4;
    //animation.keyTimes = @[@(0), @(1 / 10.0), @(5 / 10.0), @(9 / 10.0), @(1) ];
    animation.timingFunctions  = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
 
    [purpleView.layer addAnimation:animation forKey:nil];
}

//实验证明，view本身没有移动
-(void)clickTap: (UITapGestureRecognizer*)sender{
    NSLog(@"%s", __func__);
}

/*
 
 关键帧动画常用属性总结
 关键帧动画相对于基础动画的具有一些独特的属性
 
 属性                      具体描述
 values                   用于提供关键帧数据的数组，数组中每一个值都对应一个关键帧属性值；
                          数组中的数据类型根据动画类型(KeyPath)而不同；
                          当使用path的时候，values的值将会被自动忽略；
 path                     用于提供关键帧数据的路径；
                          path与values属性作用相同，但是两者互斥，同时指定values和path，path会覆盖values的效果；
 keyTimes                 ktyTimes与Values中的值具有一一对应的关系，用于指定关键帧在动画的时间点，取值范围是[0,1];
                          若没有设置keyTimes，则每个关键帧的时间是平分动画总时长(duration);
 timingFunctions          用于指定每个关键帧之间的动画缓冲效果，这类似于物体运动的加速度；
                          注意：存在几个子路径就应该在此数组中传入几个元素；
 calculationMode          该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似；
 rotationMode             设置帧动画是否需要按照路径切线的方向运动；
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
