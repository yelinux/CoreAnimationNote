//
//  CATransform3DViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/9/7.
//

#import "CATransform3DViewController.h"

@interface CATransform3DViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnM11;
@property (weak, nonatomic) IBOutlet UIButton *btnM12;
@property (weak, nonatomic) IBOutlet UIButton *btnM13;
@property (weak, nonatomic) IBOutlet UIButton *btnM14;

@property (weak, nonatomic) IBOutlet UIButton *btnM21;
@property (weak, nonatomic) IBOutlet UIButton *btnM22;
@property (weak, nonatomic) IBOutlet UIButton *btnM23;
@property (weak, nonatomic) IBOutlet UIButton *btnM24;

@property (weak, nonatomic) IBOutlet UIButton *btnM31;
@property (weak, nonatomic) IBOutlet UIButton *btnM32;
@property (weak, nonatomic) IBOutlet UIButton *btnM33;
@property (weak, nonatomic) IBOutlet UIButton *btnM34;

@property (weak, nonatomic) IBOutlet UIButton *btnM41;
@property (weak, nonatomic) IBOutlet UIButton *btnM42;
@property (weak, nonatomic) IBOutlet UIButton *btnM43;
@property (weak, nonatomic) IBOutlet UIButton *btnM44;

@property (copy, nonatomic) NSArray *btnList;
@property (assign, nonatomic) NSInteger selection;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

@property (weak, nonatomic) IBOutlet UILabel *lbAnim;
@property (assign, nonatomic) CATransform3D trans3d;

@end

@implementation CATransform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnList = @[self.btnM11, self.btnM12, self.btnM13, self.btnM14,
                     self.btnM21, self.btnM22, self.btnM23, self.btnM24,
                     self.btnM31, self.btnM32, self.btnM33, self.btnM34,
                     self.btnM41, self.btnM42, self.btnM43, self.btnM44];
    self.trans3d = CATransform3DIdentity;
    [self.btnList enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.tag = idx;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.slider addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    self.lbAnim.userInteractionEnabled = YES;
    [self.lbAnim addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
    [self refreshUI];
}

-(void)clickBtn: (UIButton*)sender{
    self.selection = sender.tag;
    [self refreshUI];
}

-(void)sliderValueChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    NSMutableArray *mList = [NSMutableArray arrayWithArray:@[@(_trans3d.m11), @(_trans3d.m12), @(_trans3d.m13), @(_trans3d.m14),
                                                             @(_trans3d.m21), @(_trans3d.m22), @(_trans3d.m23), @(_trans3d.m24),
                                                             @(_trans3d.m31), @(_trans3d.m32), @(_trans3d.m33), @(_trans3d.m34),
                                                             @(_trans3d.m41), @(_trans3d.m42), @(_trans3d.m43), @(_trans3d.m44)]];
    [mList replaceObjectAtIndex:self.selection withObject:@(slider.value)];
    _trans3d.m11 = [[mList objectAtIndex:0] floatValue];
    _trans3d.m12 = [[mList objectAtIndex:1] floatValue];
    _trans3d.m13 = [[mList objectAtIndex:2] floatValue];
    _trans3d.m14 = [[mList objectAtIndex:3] floatValue];
    
    _trans3d.m21 = [[mList objectAtIndex:4] floatValue];
    _trans3d.m22 = [[mList objectAtIndex:5] floatValue];
    _trans3d.m23 = [[mList objectAtIndex:6] floatValue];
    _trans3d.m24 = [[mList objectAtIndex:7] floatValue];
    
    _trans3d.m31 = [[mList objectAtIndex:8] floatValue];
    _trans3d.m32 = [[mList objectAtIndex:9] floatValue];
    _trans3d.m33 = [[mList objectAtIndex:10] floatValue];
    _trans3d.m34 = [[mList objectAtIndex:11] floatValue];
    
    _trans3d.m41 = [[mList objectAtIndex:12] floatValue];
    _trans3d.m42 = [[mList objectAtIndex:13] floatValue];
    _trans3d.m43 = [[mList objectAtIndex:14] floatValue];
    _trans3d.m44 = [[mList objectAtIndex:15] floatValue];
    
    [self refreshUI];
}

-(void)tapClick: (UITapGestureRecognizer*)sender{
    _trans3d = CATransform3DIdentity;
    [UIView animateWithDuration:0.5 animations:^{
        [self refreshUI];
    }];
}

-(void)refreshUI{
    [self.btnList enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.selected = idx == self.selection;
    }];
    NSArray *mList = @[@(_trans3d.m11), @(_trans3d.m12), @(_trans3d.m13), @(_trans3d.m14),
                       @(_trans3d.m21), @(_trans3d.m22), @(_trans3d.m23), @(_trans3d.m24),
                       @(_trans3d.m31), @(_trans3d.m32), @(_trans3d.m33), @(_trans3d.m34),
                       @(_trans3d.m41), @(_trans3d.m42), @(_trans3d.m43), @(_trans3d.m44)];
    self.slider.value = [[mList objectAtIndex:self.selection] floatValue];
    
    NSMutableString *desc = [NSMutableString stringWithFormat:@""];
    [desc appendFormat:@"%f   %f   %f   %f \n", _trans3d.m11, _trans3d.m12, _trans3d.m13, _trans3d.m14];
    [desc appendFormat:@"%f   %f   %f   %f \n", _trans3d.m21, _trans3d.m22, _trans3d.m23, _trans3d.m24];
    [desc appendFormat:@"%f   %f   %f   %f \n", _trans3d.m31, _trans3d.m32, _trans3d.m33, _trans3d.m34];
    [desc appendFormat:@"%f   %f   %f   %f \n", _trans3d.m41, _trans3d.m42, _trans3d.m43, _trans3d.m44];
    
    self.lbDesc.text = desc;
    
    self.lbAnim.layer.transform = _trans3d;
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
