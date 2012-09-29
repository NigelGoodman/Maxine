package maxine 
{
	/**
	 * ...
	 * @author ...
	 */
	public class gameVariables 
	{
		public var mode:int;
		public var tickerCheck:int;
		public var patternLength:int;
		
		public const off:int = 0;
		public const example:int = 1;
		public const input:int = 2;
		public const wait:int = 3;
		
		public function gameVariables() 
		{
			initialise();
		}
		
		public function initialise():void
		{
			mode = 0;
			tickerCheck = 10;
			patternLength = 4;
		}
		
		
	}

}