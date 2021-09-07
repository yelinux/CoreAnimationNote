//
//  CGAffineTransformViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/9/7.
//

#import "CGAffineTransformViewController.h"

@interface CGAffineTransformViewController ()

@property (weak, nonatomic) IBOutlet UISlider *sliderA;
@property (weak, nonatomic) IBOutlet UISlider *sliderC;
@property (weak, nonatomic) IBOutlet UISlider *sliderTx;
@property (weak, nonatomic) IBOutlet UISlider *sliderB;
@property (weak, nonatomic) IBOutlet UISlider *sliderD;
@property (weak, nonatomic) IBOutlet UISlider *sliderTy;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;


@property (weak, nonatomic) IBOutlet UILabel *lb;

@end

@implementation CGAffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lb.userInteractionEnabled = YES;
    [self.lb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
    
    [self.sliderA addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self.sliderC addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self.sliderTx addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self.sliderB addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self.sliderD addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self.sliderTy addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    
    [self sliderValueChanged:nil forEvent:nil];
}

-(void)sliderValueChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    CGFloat a = self.sliderA.value;
    CGFloat c = self.sliderC.value;
    CGFloat tx = self.sliderTx.value;
    CGFloat b = self.sliderB.value;
    CGFloat d = self.sliderD.value;
    CGFloat ty = self.sliderTy.value;
    self.lbDesc.text = [NSString stringWithFormat:@"x' = %fx + %fy + %f\ny' = %fx + %fy + %f", a, c, tx, b, d, ty];
    
    self.lb.layer.affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);
}

-(void)tapClick: (UITapGestureRecognizer*)sender{
    [UIView animateWithDuration:0.25 animations:^{
        self.lb.layer.affineTransform = CGAffineTransformIdentity;

        self.sliderA.value = self.lb.layer.affineTransform.a;
        self.sliderC.value = self.lb.layer.affineTransform.c;
        self.sliderTx.value = self.lb.layer.affineTransform.tx;
        self.sliderB.value = self.lb.layer.affineTransform.b;
        self.sliderD.value = self.lb.layer.affineTransform.d;
        self.sliderTy.value = self.lb.layer.affineTransform.ty;

        [self sliderValueChanged:nil forEvent:nil];
    }];
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, 10, -10);
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//    self.lb.layer.affineTransform = transform;
//    [UIView animateWithDuration:0.2 animations:^{
//        self.lb.layer.affineTransform = CGAffineTransformIdentity;
//    }];
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
