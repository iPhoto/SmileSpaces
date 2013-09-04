package com.trobi.abstractclasses;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

public class FlickrImageXMLParser implements ContentHandler {

	private ArrayList<FlickrImage> parsedImages;
	private long totalImagesToParse = 0;
	
	@Override
	public void startDocument() throws SAXException {
		parsedImages = new ArrayList<FlickrImage>();
	}
	@Override
	public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException {
		if(localName.equals("photos")){
			totalImagesToParse = Long.parseLong(atts.getValue("total"));
		}else if(localName.equals("photo")) {
			parsedImages.add(new FlickrImage(
					atts.getValue("farm"),
					atts.getValue("server"),
					atts.getValue("id"),
					atts.getValue("secret"))
			);
		}
	}
	public ArrayList<FlickrImage> getParsedImages(){
		return parsedImages;
	}
	public boolean isCorrectlyParsed(){
		return (totalImagesToParse == parsedImages.size());
	}
	
	// Empty callbacks
	@Override
	public void endDocument() throws SAXException {}
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {}
	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException {}
	@Override
	public void endPrefixMapping(String prefix) throws SAXException {}
	@Override
	public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {}
	@Override
	public void processingInstruction(String target, String data) throws SAXException {}
	@Override
	public void setDocumentLocator(Locator locator) {}
	@Override
	public void skippedEntity(String name) throws SAXException {}
	@Override
	public void startPrefixMapping(String prefix, String uri) throws SAXException {}

}
