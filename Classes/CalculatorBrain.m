//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize operand;
@synthesize memoryCell;
@synthesize useRadians;
@synthesize errMsg;

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
		} else {
			self.errMsg = @"Sorry, divide by zero!";
		}
	}
}


- (double)performOperation:(NSString *)operation
{
	double pi = 3.14159265;
	
	if ([operation isEqual:@"sqrt"]) {
		if (operand >= 0.0) {
			operand = sqrt(operand);
		} else {
			self.errMsg = @"Sorry, no square root from negative number!";
		}
	}
	else if ([@"+/-" isEqual:operation])
	{
		operand = -operand;
	} else if ([@"1/x" isEqual:operation]) {
		if (operand) {
			operand = 1 / operand;
		}
	} else if ([@"sin" isEqual:operation]) {
		if (useRadians) {
			operand = sin(operand);
		} else {
			operand = sin(operand * pi / 180);
		}
	} else if ([@"cos" isEqual:operation]) {
		if (useRadians) {
			operand = cos(operand);
		} else {
			operand = cos(operand * pi / 180);
		}
	} else if ([@"Store" isEqual:operation]) {
		memoryCell = operand;
	} else if ([@"Recall" isEqual:operation]) {
		operand = memoryCell;
	} else if ([@"Mem+" isEqual:operation]) {
		memoryCell = memoryCell + operand;
	} else if ([@"MC" isEqual:operation]) {
		memoryCell = 0;
	} else if ([@"PI" isEqual:operation]) {
		operand = pi;
	} else if ([@"Clear" isEqual:operation]) {
		operand = 0;
		waitingOperand = 0;
		memoryCell = 0;
		waitingOperation = nil;
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
