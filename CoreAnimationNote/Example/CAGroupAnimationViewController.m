//
//  CAGroupAnimationViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "CAGroupAnimationViewController.h"

@interface CAGroupAnimationViewController ()

@end

@implementation CAGroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    //创建显示颜色的图层
    UIView *colorView = [UIView new];
    colorView.frame = CGRectMake(0, 0, 60, 60);
    colorView.center = CGPointMake(50, 200);
    colorView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:colorView];
    
    //创建贝塞尔曲线，即帧动画运动轨迹
    UIBezierPath *bezierPath  = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(50, 200)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 50, 200) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(CGRectGetWidth(self.view.bounds) - 150, 250)];
    
    //绘制绘制path，便于观察动画；
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //1.创建基础动画：修改背景色为紫色
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.toValue = (__bridge id _Nullable)([UIColor purpleColor].CGColor);
    
    //2.创建关键帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath = @"position";
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    
    //3.创建组动画：组合基础动画和关键帧动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[basicAnimation, keyFrameAnimation];
    groupAnimation.duration = 4.0;
    groupAnimation.repeatCount = MAXFLOAT; //重复执行
    [colorView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
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
