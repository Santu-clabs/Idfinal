//
//  UINoteView.m
//  idfinal
//
//  Created by Click Labs on 2/21/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "UINoteView.h"

@implementation UINoteView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:0.6f alpha:1.0f];
        self.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //Get the current drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    //Start a new Path
    CGContextBeginPath(context);
    
    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
    
    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
    CGFloat baselineOffset = 6.0f;
    
    //iterate over numberOfLines and draw each line
    for (int x = 0; x < numberOfLines; x++) {
        //0.5f offset lines up line with pixel boundary
        CGContextMoveToPoint(context, self.bounds.origin.x, self.font.leading*x + 0.5f + baselineOffset);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.font.leading*x + 0.5f + baselineOffset);
    }
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
