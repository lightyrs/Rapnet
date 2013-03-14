//
//  GetPriceChangeParser.m
//  RapnetPriceModule
//
//  Created by Nikhil Bansal on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetPriceChangeParser.h"


@implementation GetPriceChangeParser

@synthesize webData,xmlParser,results,delegate;

-(void)GetPriceChange:(NSString *)ticket withPriceType:(NSString *)type{
    if(results == nil)
		results= [[NSMutableArray alloc] init];
	
	
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"%@"
                             "<SOAP-ENV:Header> \n"
                             "<AuthenticationTicketHeader xmlns=\"%@/\"> \n"
                             "<Ticket>%@</Ticket> \n"
                             "</AuthenticationTicketHeader> \n"
                             "</SOAP-ENV:Header> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetPriceChanges xmlns=\"%@/\"> \n"
                             "<PriceListType>%@</PriceListType> \n"                                                         
                             "<SoftwareCode>%@</SoftwareCode> \n"
                             "</GetPriceChanges> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>", SoapEnvelope, BaseUrl,ticket,BaseUrl, type, SoftwareCode];
    
   NSLog(@"%@", soapMessage);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/PricesWebService.asmx", BaseUrl]];               
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];             
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];          
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];       
    [theRequest addValue:[NSString stringWithFormat:@"%@/GetPriceChanges", BaseUrl] forHTTPHeaderField:@"Soapaction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];     
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[[NSURLConnection alloc] initWithRequest:theRequest delegate:self]autorelease];
    
    if( theConnection ){
		ReleaseObject(webData);
		webData = [[NSMutableData data] retain];
	}
	else{
		//NSLog(@"theConnection is NULL");
	}
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)mydata
{
	
	[webData appendData:mydata];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
	if(connection !=nil)
		ReleaseObject(connection);
	if(webData !=nil)
		ReleaseObject(webData);
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",theXML);
	[theXML release];
	[self connectToParser:webData];
	
}

-(void)connectToParser:(NSMutableData *)xmldata
{
	ReleaseObject(xmlParser);
	xmlParser = [[NSXMLParser alloc] initWithData: xmldata];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
    
    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    //NSLog(@"xml start");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	currentElement = [elementName copy];
	
     if ([elementName isEqualToString:@"Table1"]) 
     {
         ReleaseObject(data);
         
         data      = [[NSMutableDictionary alloc] init];
         
     
     }
     else if ([elementName isEqualToString:@"NewDataSet"])
     {
         ReleaseObject(results);
         results   = [[NSMutableArray alloc] init];
     }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	
	if ([currentElement isEqualToString:@"Color"] || [currentElement isEqualToString:@"Clarity"] || [currentElement isEqualToString:@"LowSize"] || [currentElement isEqualToString:@"HighSize"] || [currentElement isEqualToString:@"ChangeDollar"] || [currentElement isEqualToString:@"ChangePercent"] || [currentElement isEqualToString:@"OldPrice"] || [currentElement isEqualToString:@"NewPrice"]){
        [data setObject:string forKey:currentElement];
    }
    
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    	if ([elementName isEqualToString:@"Table1"])
     {
     	
         [results addObject:data];
         
     }		
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	//NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];	
}


-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"xml ended");
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObjectsFromArray:results];
    
    [delegate webserviceCallPriceChangeFinished:arr];
}

-(NSMutableArray*)getResults
{
	return results;
}

- (void)dealloc 
{   
	[xmlParser release];
	[results release];
	[webData release];
	[data release];
	[currentElement release];
	[super dealloc];
}

@end
