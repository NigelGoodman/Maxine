package maxine
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import maxine.textButton;
	import org.si.sion.*;
	
	/**
	 * ...
	 * @author Jackpot
	 */
	[Frame(factoryClass = "maxine.Preloader")]
	[SWF(width="480", height="320",  frameRate = 30, backgroundColor="#000033")]
	public class Main extends Sprite 
	{
		private var noteButtons:Vector.<textButton>;
		private var noteStrings:Vector.<String>;
		private var onButton:textButton;
		private var mode:int = 0;
		private var ticker:int = 0;
		private var tickerCheck:int = 10;
		private var patternLength:int = 4;
		private var startButton:textButton;
		private var playRoot:Boolean = true;
		private var expectedList:Vector.<int>;
		public var driver:SiONDriver = new SiONDriver();
		
		private var announcer:TextField;
		//enums
		
		private const off:int = 0;
		private const example:int = 1;
		private const input:int = 2;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			noteStrings = new Vector.<String>;
			noteButtons = new Vector.<textButton>;
			
			noteStrings.push("Root");
			noteStrings.push("Minor Second");
			noteStrings.push("Major Second");
			noteStrings.push("Minor Third");
			noteStrings.push("Perfect Fourth");
			noteStrings.push("Tritone");
			noteStrings.push("Perfect Fifth");
			noteStrings.push("Minor Sixth");
			noteStrings.push("Major Sixth");
			noteStrings.push("Minor Seventh");
			noteStrings.push("Major Seventh");
			noteStrings.push("Octave");
			
			
			
			for (var i:int = 0; i <12 ; i++)
			{
				//trace(i);
				var spacing:int = 90;
				noteButtons.push(new textButton(noteStrings[i]));
				
				if (i < 4)
				{
					noteButtons[i].x = (i *spacing);
							
					noteButtons[i].y = 320-spacing;	
				
					
				}
				else if (i < 8)
				{
					noteButtons[i].x = ((i-4) *spacing);
							
					noteButtons[i].y = 320-spacing-spacing;	
				}
				else
				{
					noteButtons[i].x = ((i - 8) * spacing);
							
					noteButtons[i].y = 320-spacing-spacing-spacing;	
				}
				
				noteButtons[i].visible = true;
				noteButtons[i].addEventListener(MouseEvent.CLICK, clickedNote);
				this.addChild(noteButtons[i]);
			}
			
						
			startButton = new textButton("START/STOP");
			startButton.visible = true;
			startButton.x = 480 - 75;
			startButton.y = 0;
			startButton.visible = true;
			startButton.addEventListener(MouseEvent.CLICK, startClicked);
			
			this.addChild(startButton);
			
			mode = off;
			
			announcer = new TextField();
			
			announcer.x = 0;
			announcer.y = 0;
			announcer.textColor = 0x00FF00;
			announcer.text = "CLICK START";
			announcer.visible = true;
			this.addChild(announcer);
			
			expectedList = new Vector.<int>
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			ticker++;
			if (ticker > tickerCheck)
			{
				switch (mode)
				{
					case off:
					{
						for each (var button:textButton in noteButtons)
						{
							button.alpha = 0.3;
						}
						break;
					}
					case example:
					{
						if (patternLength > 0)
						{						
							demonstratePattern();
							patternLength--;
						}
						else
						{
							blankAllButtons();
							mode = input;
						}
						break;
					}
					case input:
					{
						inputPattern();
						break;
					}
					default:
					{
						break;
					}
				}
				ticker = 0;
			}
		}
		
		private function demonstratePattern():void
		{
			blankAllButtons();		
			if (playRoot == true)
			{
				playButton(something);
				playRoot = false;
			}
			else
			{
				var something:int = Math.floor(Math.random() * (noteButtons.length-1))+1;
				playButton(something);
				playRoot = true;
			}			
		}
		
		private function inputPattern():void
		{
			
		}
		
		private function clickedNote(event:Event):void
		{
			if (mode == input && expectedList.length >0 )
			{
				if (expectedList[0] == noteButtons.indexOf(event.currentTarget))
				{
					announcer.text = "CORRECT!";
					expectedList.shift();
				}
				else
				{
					announcer.text = "WRONG!";
					expectedList.shift();
				}
			}
			
			if (expectedList.length <= 0)
			{
				patternLength = 4;
				mode = example;
			}
		}
		
		private function playButton(buttonIndex:int):void
		{
			noteButtons[buttonIndex].alpha = 0.7;
			expectedList.push(buttonIndex);
		}
		
		private function blankAllButtons():void
		{
			for each (var button:textButton in noteButtons)
			{
				button.alpha = 0.3;
			}
		}
		
		private function startClicked(event:Event):void
		{
			switch(mode)
			{
				case off:
				{
					mode = example;
					break;
				}
				case example:
				{
					mode = off;
					patternLength = 4;
					break;
				}
				case input:
				{
					mode = off;
					patternLength = 4;
					break;
				}
				default:
				{
					break;
				}
			}
		}

	}

}