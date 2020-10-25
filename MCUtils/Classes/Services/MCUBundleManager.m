//
//  MCUBundleManager.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 24/10/20.
//

#import "MCUBundleManager.h"

@implementation MCUBundleManager

+ (NSBundle *)bundle
{
    static dispatch_once_t onceToken;
    __strong static NSBundle *sharedBundle = nil;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        sharedBundle = [NSBundle bundleWithURL:[bundle URLForResource:@"MCUtils" withExtension:@"bundle"]];
    });
    
    return sharedBundle;
}

@end
