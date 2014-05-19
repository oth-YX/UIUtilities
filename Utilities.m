//
//  Utilities.m
//  
//
//  Created by oth on 5/19/14.
//
//

#import "Utilities.h"

@implementation Utilities


//This function returns a UIImage after cutom resizing
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
