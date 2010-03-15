/*
Licensed under the MIT License

Copyright (c) 2010 Sean Hellwig <seanhellwig@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package com.seanhellwig.preloaders{
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
* 	AS3 CirclePreloader class
* 	<p>Actionscript 3 dynamic circular preloader based on passed in percentage</p>
* 	@langversion ActionScript 3.0
*	@playerversion Flash 9.0
*	@author Sean Hellwig / seanhellwig@gmail.com
*/


public class CirclePreloader extends Sprite{
	private var _angle:Number = 0;
	
	private var _circle:Sprite;
	private var _lineColor:uint;
	private var _lineThickness:Number;
	private var _lineAlpha:Number;
	private var _circleRadius:Number;
	private var _text:TextField = null;
	
	private var _displayPercentage:Boolean;
	private var _textFormat:TextFormat;
	
	/**
	 * Constructor
	 * <p>Creates a new instance of the CirclePreloader class</p>
	 * @param	lineColor	Color of the circle
	 * @param	lineThickness	Thickness of circle outline 
	 * @param	lineAlph	Alpha of circle outline
	 * @param	circleRadius	Radius of circle outline
	 * @param	displayPercentage Flag to display percentage text
	 * @param	textFormat	TextFormat Object to format percentage text
	 */
	public function CirclePreloader(lineColor:uint = 0x000000, 
									lineThickness:Number = 1,
									lineAlpha:Number = 1,
									circleRadius:Number = 10, 
									displayPercentage:Boolean = true, 
									textFormat:TextFormat = null){
		trace("****CirclePreloader****");
		_lineColor = lineColor;
		_lineThickness = lineThickness;
		_lineAlpha = lineAlpha;
		_circleRadius = circleRadius;
		_displayPercentage = displayPercentage;
		
		textFormat ? _textFormat = textFormat : null;
		
		_circle = new Sprite();
		this.reset();
		this.addChild(_circle);
		
		
		if (_displayPercentage){
			_text = new TextField();
			_text.autoSize = TextFieldAutoSize.LEFT;
			_textFormat ? _text.defaultTextFormat = _textFormat : null;
			_text.htmlText = "000%";
			_text.x = _circleRadius - (_text.textWidth / 2);
			_text.y = _circleRadius - (_text.textHeight / 2);
			this.addChild(_text);
		}
		
	}
	
	/**
	 * @param bytesLoaded Number Current bytesLoaded used to calculate percentage
	 * @param bytesTotal Number  Current bytesTotal used to calculate percentage
	 */
	public function update(bytesLoaded:Number, bytesTotal:Number):void{
		_angle = Math.round(360 * (bytesLoaded / bytesTotal));
		
		_angle = _angle * Math.PI / 180;
		
		var newX:Number = _circleRadius + Math.cos(_angle) * _circleRadius;
		var newY:Number = _circleRadius + Math.sin(_angle) * _circleRadius;
		if (!isNaN(newY) && !isNaN(newX)){
		
			_circle.graphics.lineTo(newX, newY);
		}
		if (_displayPercentage){
			_text.htmlText = Math.round((bytesLoaded / bytesTotal) * 100) + "%";
		}
	}
	
	/**
	 * @param newColor uint New Color of circle outline
	 */
	public function changeColor(newColor:uint):void{
		_lineColor = newColor;
		_circle.graphics.lineStyle(_lineThickness, _lineColor);
	}
	/**
	 * Getter
	 * Returns current lineColor
	 */
	public function get lineColor():uint{
		return _lineColor;
	}
	
	/**
	 * Resets current outline / clears graphics
	 */
	public function reset():void{
		_circle.graphics.clear();
		_circle.graphics.lineStyle(_lineThickness, _lineColor, _lineAlpha);
		_circle.graphics.moveTo(_circleRadius * 2, _circleRadius);
	}
	
	
	
	
	
}

}

