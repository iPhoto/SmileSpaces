//
//  Parada.m
//  ValenciaBusLite
//
//  Created by Isaac Roldan Armengol on 30/07/13.
//  Copyright (c) 2013 Isaac Roldan Armengol. All rights reserved.
//

#import "Zone.h"

@implementation Zone

-(id)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if(self){
        self.zoneDict=dict;
        
        if(dict[@"centerLat"]&& ![dict[@"centerLat"] isEqual:[NSNull null]]){
            _lat=@([dict[@"centerLat"] doubleValue]);
            
        }
        if(dict[@"centerLon"]&& ![dict[@"centerLon"] isEqual:[NSNull null]]){
            _lon=@([dict[@"centerLon"] doubleValue]);
            
        }
        
        if(![dict[@"smileValue"] isEqual:[NSNull null]]){
            _smileValue=@([dict[@"smileValue"] intValue]);
            
        }
        if(![dict[@"id"] isEqual:[NSNull null]]){
            _zoneId=dict[@"id"];
            
        }

        self.coordinate = CLLocationCoordinate2DMake([dict[@"centerLat"] doubleValue], [dict[@"centerLon"] doubleValue]);
    }
    return self;
}



- (NSString *)title {
    return self.description;
}

- (NSString *)description {
    return @"";
}


@end
