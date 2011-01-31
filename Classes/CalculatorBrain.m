//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

- (void)setOperand:(double)aDouble
{
	operand = aDouble;
}

- (void)performWaitingOperation
{
	if ([@"+" isEqual:waitingOperation])
	{
		operand = waitingOperand + operand;
	}
	else if ([@"*" isEqual:waitingOperation])
	{
		operand = waitingOperand * operand;
	}
	else if ([@"-" isEqual:waitingOperation])
	{
		operand = waitingOperand - operand;
	}
	else if ([@"/" isEqual:waitingOperation])
	{
		if (operand) {
			operand = waitingOperand / operand;
		}
	}
}


- (double)performOperation:(NSString *)operation
{
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ([@"+/-" isEqual:operation])
	{
		operand = -operand;
	} else if ([@"1/x" isEqual:operation]) {
		if (operand) {
			operand = 1 / operand;
		}
	} else if ([@"sin" isEqual:operation]) {
		operand = sin(operand);
	} else if ([@"cos" isEqual:operation]) {
		operand = cos(operand);
	} else if ([@"Store" isEqual:operation]) {
		memoryCell = operand;
	} else if ([@"Recall" isEqual:operation]) {
		operand = memoryCell;
	} else if ([@"Mem+" isEqual:operation]) {
		memoryCell = memoryCell + operand;
	}
	else
	{
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
	
	return operand;
}

@end
