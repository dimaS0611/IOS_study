#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSMutableArray<NSString *> *)strToArray:(NSString *)str
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for(int i = 0; i < [str length]; ++i)
    {
        [arr addObject:[NSString stringWithFormat:@"%C", [str characterAtIndex:i]]];
    }
    
    return arr;
}

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableArray *str1 = [NSMutableArray arrayWithArray: [self strToArray:string1]];
    NSMutableArray *str2 = [NSMutableArray arrayWithArray: [self strToArray:string2]];
    
    NSString *result = @"";
    
    while([str1 count] != 0 && [str2 count] != 0)
    {
        if(([[str2 objectAtIndex:0] compare: [str1 objectAtIndex:0]]) == NSOrderedAscending)
        {
            result = [result stringByAppendingString: [str2 objectAtIndex:0]];
            [str2 removeObjectAtIndex:0];
        }
        else if([[str1 objectAtIndex:0] compare: [str2 objectAtIndex:0]] == NSOrderedAscending)
        {
            result = [result stringByAppendingString: [str1 objectAtIndex:0]];
            [str1 removeObjectAtIndex:0];
        }
        else
        {
            result = [result stringByAppendingString: [str1 objectAtIndex:0]];
            [str1 removeObjectAtIndex:0];
        
        }
    }
    while([str1 count] != 0)
    {
        result = [result stringByAppendingString: [str1 objectAtIndex:0]];
        [str1 removeObjectAtIndex:0];
    }
    while([str2 count] != 0)
    {
        result = [result stringByAppendingString: [str2 objectAtIndex:0]];
        [str2 removeObjectAtIndex:0];
    }
    
    return result;
}

@end
