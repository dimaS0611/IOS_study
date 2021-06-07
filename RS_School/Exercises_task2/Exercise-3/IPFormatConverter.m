#import "IPFormatConverter.h"

@implementation IPFormatConverter

- (NSString *)ipFormatConverter:(NSArray *)numbersArray {
    
    NSMutableArray<NSString *> *ip = [NSMutableArray array];

    if([numbersArray count] != 0 && [numbersArray count] < 16)
    {
        [ip addObject:[[numbersArray objectAtIndex:0] stringValue]];
        
        for(int i = 1; i < [numbersArray count]; i++)
        {
            if([[numbersArray objectAtIndex:i] intValue] > 255)
                return @"The numbers in the input array can be in the range from 0 to 255.";
            
            if([[numbersArray objectAtIndex:i] intValue] < 0)
                return @"Negative numbers are not valid for input.";
            
            NSString *value  = @"";
            
            value = [value stringByAppendingString:@"."];
            value = [value stringByAppendingString:[[numbersArray objectAtIndex:i] stringValue]];
            
            [ip addObject: value];
        }
        
        if([ip count] != 4)
        {
            for(u_long i = [ip count]; i < 4; i++) {
                [ip addObject:@".0"];
            }
        }
    }
    
    NSString *result = @"";
    if([ip count] == 4)
    {
        for(int i = 0; i < 4; i++) {
            result = [result stringByAppendingString:[ip objectAtIndex:i]];
        }
    }
    
    return result;
}

@end
