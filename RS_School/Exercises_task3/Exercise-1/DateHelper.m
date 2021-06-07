#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    NSString *monthName = nil;
    
    switch (monthNumber) {
        case 1: {
            monthName = @"January";
            break;
        }
        case 2: {
            monthName = @"February";
            break;
        }
        case 3: {
            monthName = @"March";
            break;
        }
        case 4: {
            monthName = @"April";
            break;
        }
        case 5: {
            monthName = @"May";
            break;
        }
        case 6: {
            monthName = @"June";
            break;
        }
        case 7: {
            monthName = @"July";
            break;
        }
        case 8: {
            monthName = @"August";
            break;
        }
        case 9: {
            monthName = @"September";
            break;
        }
        case 10: {
            monthName = @"October";
            break;
        }
        case 11: {
            monthName = @"November";
            break;
        }
        case 12: {
            monthName = @"December";
            break;
        }
        default:
            break;
    }
    
    return monthName;
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *parseDate = [dateFormatter dateFromString:date];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [calendar components: NSCalendarUnitDay | NSCalendarUnitWeekday fromDate: parseDate];

    
    return dateComponents.day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSDateComponents *dateDay = [calendar components:NSCalendarUnitDay fromDate: date];
    
    long day = [dateDay day];
    long weekday = [dateComponents weekday] - 1;
    
    switch (weekday) {
        case 1:
            return @"Пн";
        case 2:
            return @"Вт";
        case 3:
            return @"Ср";
        case 4:
            return @"Чт";
        case 5:
            return @"Пт";
        case 6:
            return @"Сб";
        case 7:
            return @"Вс";
        default:
            break;
    }
    
    return nil;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *day = [calendar components:NSCalendarUnitDay fromDate:date];
    NSDateComponents *month = [calendar components:NSCalendarUnitMonth fromDate:date];
    NSDateComponents *year = [calendar components:NSCalendarUnitYear fromDate:date];
    
    NSLog(@"%ld", year.day);
    
    if(year.year == 2021 && month.month == 5)
    {
        if(day.day < 24 && day.day > 16)
            return YES;
    }
    return NO;
}

@end
