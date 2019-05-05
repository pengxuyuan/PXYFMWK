//
//  PXYDispalyView.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/19.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYDispalyView.h"

#import "CoreText/CoreText.h"

#import "UIView+FrameAdjust.h"

#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

@implementation PXYDispalyView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //1.获取上下文，用于后续将内容绘制到画布上
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.翻转画布坐标轴
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //4.
    NSAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"现代人太着急了，看一眼照片，听一段语音，道两天晚安，就喜欢上了。不过讨厌得也很快，喜欢了两三年，最后因为一个眼神，一句话，不到一秒就决定放弃了，多情又冷酷也挺好的，速战速决总是好过暧昧不清。就只怕杀伐决断的遇上了藕断丝连的，情意绵绵的遇上了见异思迁。 这世上，赢得多半是薄情人 。"];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
    
    //5.
    CTFrameDraw(frame, context);
    
    //6.
    CFRelease(frame);
    CFRelease(frameSetter);
    CFRelease(path);

}


@end
