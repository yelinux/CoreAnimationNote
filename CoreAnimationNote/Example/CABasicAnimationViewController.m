//
//  CABasicAnimationViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (strong, nonatomic) CAShapeLayer *layerExample;

@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _layerExample = [CAShapeLayer layer];
    _layerExample.path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)].CGPath;
    _layerExample.backgroundColor = UIColor.clearColor.CGColor;
    _layerExample.strokeColor = UIColor.blackColor.CGColor;
    _layerExample.fillColor = UIColor.grayColor.CGColor;
    _layerExample.lineWidth = 5;
    [self.viewContainer.layer addSublayer:_layerExample];
}

- (IBAction)clickStart:(id)sender {
    //步骤1：创建动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"path";
    animation.delegate = self;
    //步骤2：设定动画属性
    animation.autoreverses = NO;//动画结束后，是否反向动画恢复动画前
    animation.duration = 1;//动画持续时间
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//动画缓冲属性
    
    //特别注意：removedOnCompletion需要设置为NO，否则fillMode不起作用；
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//详情参照：fillMode详细说明↓
    
    animation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath);
    //步骤3：添加动画到图层
    [self.layerExample addAnimation:animation forKey:@"keyPathName"];
}

#pragma mark - CAAnimationDelegate

/* Called when the animation begins its active duration. */
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%s", __func__);
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%s", __func__);
}

/*
 
 CAPropertyAnimation基类
 CAPropertyAnimation是一个抽象类，不能直接用于实现CALayer动画操作，但是它的类定义中增加用于设置CALayer可被实现动画的属性keyPath，总结这些属性如下：
 属性                                         解读
 transform.rotation                          默认围绕z轴旋转，相当于transform.rotation.z
 transform.rotation.x
 transform.rotation.y                        分别围绕x轴、y轴、z轴旋转；
 transform.rotation.z
 transform.scale                             在所有方向上进行缩放
 transform.scale.x
 transform.scale.y                           分别在x轴、y轴、z轴方向上缩放；
 transform.scale.z
 transform.translation                       平移到指定坐标点
 transform.translation.x
 transform.translation.y                     分别在x轴、y轴、z轴方向上平移；
 transform.translation.z
 zPosition                                   z轴位置
 opacity                                     透明度
 backgroundColor                             背景颜色
 cornerRadius                                圆角大小
 borderWidth                                 边框宽度
 bounds                                      图层大小
 contents                                    寄宿图内容
 contentsRect                                可视内容
 position                                    图层位置，类似transform.translation
 shadowColor                                 阴影颜色
 shadowOffset                                阴影偏移
 shadowOpacity                               阴影透明度
 shadowRadius                                阴影角度
 
 
fillMode详细说明
试想这样一个问题：在beginTime非0(即动画未真正执行之前)，以及removeOnCompletion被设置为NO的动画结束时，我们会遇到这样一个问题：被设置动画的属性应该是什么值？
一种可能是属性与动画没被添加之前保持一致，还有一种可能是保持动画开始之前那一帧或者动画结束那一帧，这就是所谓的填充。
CAMediaTiming的fillMode用来控制填充效果，它是一个NSString类型，有四种常量可供使用：
 
fillMode类型                          参数类型       具体描述
 
kCAFillModeRemoved (default)         NSString      默认值，动画开始前和结束后，动画对图层都没有影响，图层依然保持初始值
 
kCAFillModeForwards                  NSString      动画结束后，图层一直保持动画后的最终状态
 
kCAFillModeBackwards                 NSString      动画开始前，只要加入动画就会处于动画的初始状态
 
kCAFillModeBoth                      NSString      综合了kCAFillModeForwards与kCAFillModeBackwards特性;
                                                   (动画加入图层到真正执行动画的时间段里，图层保持动画初始状态；动画结束之后保持动画最终状态）
 
 
CAMediaTiming协议
CAMediaTiming协议定义了一段动画内用于控制时间的属性的集合，CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制，有关CAMediaTimg协议具体的属性如下：
 
属性                  参数类型                    具体描述
 
beginTime            CFTimeInterval             动画开始之前的延迟时间，这里的延迟从动画添加到可见图层上那一刻开始测量；
                                                (设置动画beginTime为1，动画将延时1秒后开始执行)
 
duration             CFTimeInterval             动画持续时间；
                                                (默认值为0，但是实际动画默认持续时间为0.25秒)
 
speed                float                      动画执行的速度；
                                                (默认值为0，减少它会减慢动画的时间，增加它会加快速度)
                                                (设置speed为2时，则动画实际执行时间是duration的一半)
 
timeOffset           CFTimeInterval             动画时间偏移量；
                                                (设置时长3秒动画的timeOffset为1时，动画会从1秒位置执到最后，再执行之前跳过的部分)
 
repeatCount          float                      动画重复次数；默认值是0，但是实际默认动画执行1次；
                                                (设置为INFINITY，则一直执行)；
                                                (duration是2，repeatCount设置为3.5，则完整动画时长7秒)
 
repeatDuration       CFTimeInterval             动画重复的时间，让动画重复执行一个指定的时间;
                                                (设置为INFINITY，一直执行)
                                                repeatCount和repeatDuration可能会相互冲突，所以你只需要对其中一个指定非零值，对两个属性都设置非0值的行为没有被定义；
 
autoreverses         BOOL                       动画从初始值执行到最终值，是否会反向回到初始值；
                                                (设置为YES，动画完成后将以动画的形式回到初始位置)
 
fillMode             NSStrinng                  决定当前对象在非动画时间端段的动画属性值，如动画开始之前和动画结束之后
 
*/
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.layerExample.frame = self.viewContainer.bounds;
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
