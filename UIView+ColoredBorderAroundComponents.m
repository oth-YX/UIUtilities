//
//  UIView+ColoredBorderAroundComponents.m
//  
//
//  Created by oth on 4/13/14.
//
//

#import "UIView+ColoredBorderAroundComponents.h"
#import <objc/runtime.h>

@implementation UIView(ColoredBorderAroundComponents)

+ (void)load
{
    // The "+ load" method is called once, very early in the application life-cycle.
    // It's called even before the "main" function is called. Beware: there's no
    // autorelease pool at this point, so avoid Objective-C calls.
    
    return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1
        [self swizzleInstanceSelector:@selector(initWithFrame:)
                                  withNewSelector:@selector(swizzledInitWithFrame:)];
        //2
        [self swizzleInstanceSelector:@selector(initWithCoder:)
                                  withNewSelector:@selector(swizzledInitWithCoder:)];
    });

}

- (id)swizzledInitWithFrame:(CGRect)frame
{
    // This is the confusing part.
    id result = [self swizzledInitWithFrame:frame];
    
    // Safe guard: do we have an UIView (or something that has a layer)?
    if ([result respondsToSelector:@selector(layer)]) {
        // Get layer for this view.
        CALayer *layer = [result layer];
        // Set border on layer.
        layer.borderWidth = 1.1;
        layer.borderColor = [[UIColor redColor] CGColor];
    }
    
    // Return the modified view.
    return result;
}

- (id)swizzledInitWithCoder:(NSCoder *)aDecoder
{
    // This is the confusing part. initWithCoder components are created by the framework.
    id result = [self swizzledInitWithCoder:aDecoder];
    
    // Safe guard: do we have an UIView (or something that has a layer)?
    if ([result respondsToSelector:@selector(layer)]) {
        // Get layer for this view.
        CALayer *layer = [result layer];
        // Set border on layer.
        layer.borderWidth = 1.3;
        layer.borderColor = [[UIColor blueColor] CGColor];
    }
    
    // Return the modified view.
    return result;
}



#pragma mark ------------helpers------------

- (BOOL) view:(UIView *) view hasSuperviewOfClass:(Class) class {
    if(view.superview){
        if ([view.superview isKindOfClass:class]){
            return true;
        }
        return [self view:view.superview hasSuperviewOfClass:class];
    }
    return false;
}

//Alright! Now this is beautiful ;)
+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}
@end
