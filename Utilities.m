//
//  Utilities.m
//  evernote-sdk-ios
//
//  Created by A1@YX on 5/19/14.
//  Copyright (c) 2014 n/a. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities


//This function returns a UIImage after cutom resizing
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
