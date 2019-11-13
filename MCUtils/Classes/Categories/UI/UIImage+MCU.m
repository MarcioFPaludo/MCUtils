//
//  UIImage+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/06/19.
//

#import "UIImage+MCU.h"

@implementation UIImage (MCU)

- (UIImage *)imageByColorizingWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextClipToMask(context, rect, self.CGImage);
    
    [color setFill];
    
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

@end
