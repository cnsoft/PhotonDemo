package svelto.efw.plugins.keyboard.enums 
{
	
	import flash.ui.Keyboard
	
	/**
	 * Holds Key Set info, treat as enum in any other language
	 * @author Stephen Smith
	 */
	public final class KeySets
	{
		//Contains a template for use with arrow keys
		public static const ARROW_TEMPLATE_SET:Object = 
			{
				"UP":Keyboard.UP,
				"LEFT":Keyboard.LEFT,
				"RIGHT":Keyboard.RIGHT,
				"DOWN":Keyboard.DOWN,
				"PAUSE":Keyboard.P
			};
			
		//Contains a template for use with WASD
		public static const WASD_TEMPLATE_SET:Object = 
			{
				"UP":Keyboard.W,
				"LEFT":Keyboard.A,
				"RIGHT":Keyboard.D,
				"DOWN":Keyboard.S,
				"PAUSE":Keyboard.P
			};
		
		//Contains a default setup for use with arrow keys
		public static const ARROW_SET:Object = 
			{
				"UP":Keyboard.UP,
				"LEFT":Keyboard.LEFT,
				"RIGHT":Keyboard.RIGHT,
				"DOWN":Keyboard.DOWN,
				"PAUSE":Keyboard.P,
				"ACTION":Keyboard.SPACE,
				"PRIMARY":Keyboard.A,
				"SECONDARY":Keyboard.S,
				"TERTIARY":Keyboard.C
			};
			
		//Contains a default setup for use with WASD
		public static const WASD_SET:Object = 
			{
				"UP":Keyboard.W,
				"LEFT":Keyboard.A,
				"RIGHT":Keyboard.D,
				"DOWN":Keyboard.S,
				"PAUSE":Keyboard.P,
				"ACTION":Keyboard.SPACE,
				"PRIMARY":Keyboard.J,
				"SECONDARY":Keyboard.K,
				"TERTIARY":Keyboard.L
			};
			
		//Contains a default setup for use with WASD and Arrows 
		public static const DUAL_ARROWS_SET:Object = 
			{
				"UP":Keyboard.W,
				"LEFT":Keyboard.A,
				"RIGHT":Keyboard.D,
				"DOWN":Keyboard.S,
				"PAUSE":Keyboard.P,
				"ACTION":Keyboard.SPACE,
				"UP_2":Keyboard.UP,
				"LEFT_2":Keyboard.LEFT,
				"RIGHT_2":Keyboard.RIGHT,
				"DOWN_2":Keyboard.DOWN
			};
			
		//Contains a default setup for use with Shooters
		public static const SHOOTER_SET:Object = 
			{
				"UP":Keyboard.W,
				"LEFT":Keyboard.A,
				"RIGHT":Keyboard.D,
				"DOWN":Keyboard.S,
				"PAUSE":Keyboard.P,
				"ACTION":Keyboard.SPACE,
				"RELOAD":Keyboard.R,
				"USE":Keyboard.E,
				"SWITCH":Keyboard.Q
			};
			
		//Contains a default setup for use with the Numpad (ideal for Roguelikes)
		public static const NUMPAD_SET:Object = 
			{
				"UP":Keyboard.NUMPAD_8,
				"LEFT":Keyboard.NUMPAD_4,
				"RIGHT":Keyboard.NUMPAD_6,
				"DOWN":Keyboard.NUMPAD_2,
				"UP_LEFT":Keyboard.NUMPAD_7,
				"UP_RIGHT":Keyboard.NUMPAD_9,
				"DOWN_LEFT":Keyboard.NUMPAD_1,
				"DOWN_RIGHT":Keyboard.NUMPAD_3,
				"USE":Keyboard.NUMPAD_0,
				"SEARCH":Keyboard.NUMPAD_5,
				"PAUSE":Keyboard.P,
				"ACTION":Keyboard.SPACE,
				"PRIMARY":Keyboard.A,
				"SECONDARY":Keyboard.S,
				"TERTIARY":Keyboard.D
			};
		
		//Empty Set for a custom setup
		public static const EMPTY_SET:Object = 
			{ };
	}

}