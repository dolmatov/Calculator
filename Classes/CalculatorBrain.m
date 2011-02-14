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
@synthesize errMsg;

- (id)init
{
	internalExpression = [[NSMutableArray alloc] init];
	return self;
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
		operand = sin(operand);
	} else if ([@"cos" isEqual:operation]) {
		operand = cos(operand);
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
		[internalExpression removeAllObjects];
	}
	else
	{
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
	
	if (![operation isEqual:@"Clear"]) {
		[internalExpression addObject:operation];
	}
	
	return operand;
}

- (void)setVariableAsOperand:(NSString *)variableName
{
	NSString *vp = VARIABLE_PREFIX;
	[internalExpression addObject:[NSString stringWithFormat:@"%@%@", vp, variableName]];
}

- (void)setOperand:(double)anOperand
{
	operand = anOperand;
	[internalExpression addObject:[NSNumber numberWithDouble:operand]];
}

- (NSString *)expression
{
	return [internalExpression copy];
}

+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables
{
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	double result;
	for (id val in anExpression) {
		if ([val isKindOfClass:[NSNumber class]]) {
			[brain setOperand:[val doubleValue]];
		} else if ([val isKindOfClass:[NSString class]]) {
			if ([CalculatorBrain isVariable:val]) {
				NSString *varName = [val substringFromIndex:1];
				double varValue = [[variables objectForKey:varName] doubleValue];
				brain.operand = varValue;
			} else {
				result = [brain performOperation:val];
			}
		}
	}
	return result;
}

+ (BOOL)isVariable:(NSString *)aValue
{
	return [aValue isKindOfClass:[NSString class]] &&
	[aValue hasPrefix:VARIABLE_PREFIX] &&
	([aValue length] > 1);
}

+ (NSSet *)variablesInExpression:(id)anExpression
{
	NSMutableSet *vars = [[NSMutableSet alloc] init];
	for (id val in anExpression) {
		if ([CalculatorBrain isVariable:val]) {
			[vars addObject:val];
		}
	}

	if ([vars count] > 0) {
		return vars;
	} else {
		return nil;
	}
}

+ (NSString *)descriptionOfExpression:(id)anExpression
{
	NSString *exprString = @"";
	for (id val in anExpression) {
		if ([CalculatorBrain isVariable:val]) {
			val = [val substringFromIndex:1];
		}
		exprString = [exprString stringByAppendingString:[val description]];
	}
	return exprString;
}

+ (NSDictionary *)tempVariables
{
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:2], @"x",
			[NSNumber numberWithDouble:3], @"a",
			[NSNumber numberWithDouble:4], @"b",
			[NSNumber numberWithDouble:5], @"c",
			nil];
}

- (void)dealloc
{
	[errMsg release];
	[waitingOperation release];
	[super dealloc];
}

@end
