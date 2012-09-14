package maxine 
{
	import flash.display.*;
	import flash.display.SimpleButton;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Jackpot
	 */
	public class textButton extends SimpleButton 
	{
		private var _text:TextField;
		private var _shape:Sprite;
		
		public function textButton(displayText:String) 
		{
			_text = new TextField;
			_text.x = 0;
			_text.y = 0;
			//_text.backgroundColor = 0x0000FF;
			//_text.background = true;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.width = 0;
			_text.height = 0;
			_text.text = displayText;
			_text.textColor = 0xFFFF00;
			
			_text.visible = true;
			_shape = new Sprite();
			_shape.addChild(_text);
			
			_shape.graphics.beginFill(0xFFFFFF);
			_shape.graphics.drawRect(0, 0, 75, 75);
			_shape.alpha = 0.3
			_shape.visible = true;
			//_text.visible = true;
			
						
			super(_shape, _shape, _shape, _shape);	
		}
		
		public function get currentText():String
		{
			return _text.text;
		}
		
	}

}