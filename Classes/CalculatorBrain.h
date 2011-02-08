//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
@private
	double memoryCell;
@private
	NSString *errMsg;
@private
	BOOL useRadians;
}

@property double operand;
@property double memoryCell;
@property BOOL useRadians;
@property (assign) NSString *errMsg;
- (double)performOperation:(NSString *)operation;

@end
