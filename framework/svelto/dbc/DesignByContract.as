 /**
 *   A collection that maps keys to one or more values
 *   @author Sebastiano Mandalà
 */

package svelto.dbc
{
	// Porting of this code: http://www.codeproject.com/Articles/1863/Design-by-Contract-Framework
	// Provides support for Design By Contract
	// as described by Bertrand Meyer in his seminal book,
	// Object-Oriented Software Construction (2nd Ed) Prentice Hall 1997
	// (See chapters 11 and 12).
	//
	// See also Building Bug-free O-O Software: An Introduction to Design by Contract
	// http://www.eiffel.com/doc/manuals/technology/contract/
	// 
	/// <summary>
	/// Design By Contract Checks.
	/// 
	/// Each method generates an exception or
	/// a trace assertion statement if the contract is broken.
	/// </summary>
	/// <remarks>
	/// If you wish to use trace assertion statements, intended for Debug scenarios,
	/// rather than exception handling then set 
	/// 
	/// <code>Check.UseAssertions = true</code>
	/// 
	/// </remarks>
	/// 
	public final class DesignByContract
	{
		private namespace checkall;
		private namespace checkprecondition;
		
		public static function get CheckAll():Namespace { return checkall; }
		public static function get CheckPrecondition():Namespace { return checkprecondition; }
		
		/// <summary>
		/// Precondition check.
		/// </summary>
		checkall static function Require(assertion:Boolean, message:String = "Precondition failed."):void
		{
			if (UseExceptions) 
			{
				if (!assertion)	throw new PreconditionException(message);
			}
			else
				trace(message);
		}
		
		checkprecondition static function Require(assertion:Boolean, message:String = null):void
		{
			checkall::Require(assertion);
		}
	
		/// <summary>
		/// Postcondition check.
		/// </summary>
		checkall static function Ensure(assertion:Boolean, message:String = "Postcondition failed."):void
		{
			if (UseExceptions) 
			{
				if (!assertion)	throw new PostconditionException(message);
			}
			else
				trace(message);
		}
		
		checkprecondition static function Ensure(assertion:Boolean, message:String = null):void
		{}
		/// <summary>
		/// Invariant check.
		/// </summary>
		checkall static function Invariant(assertion:Boolean, message:String = "Invariant failed."):void
		{
			if (UseExceptions) 
			{
				if (!assertion)	throw new InvariantException(message);
			}
			else
				trace( message);
		}
		
		checkprecondition static function Invariant(assertion:Boolean, message:String = null):void
		{}

		/// <summary>
		/// Assertion check.
		/// </summary>
		static checkall function Assert(assertion:Boolean, message:String = "Assert failed."):void
		{
			if (UseExceptions) 
			{
				if (!assertion)	throw new AssertionException(message);
			}
			else
				trace(message);
		}
		
		checkprecondition static function Assert(assertion:Boolean, message:String = null):void
		{}

		/// <summary>
		/// Set this if you wish to use Trace Assert statements 
		/// instead of exception handling. 
		/// (The Check class uses exception handling by default.)
		/// </summary>
		public static function get UseAssertions():Boolean { return useAssertions; }
		public static function set UseAssertions(value:Boolean):void { useAssertions = value; }

		/// <summary>
		/// Is exception handling being used?
		/// </summary>
		private static function get UseExceptions():Boolean { return !useAssertions; }

		// Are trace assertion statements being used? 
		// Default is to use exception handling.
		private static var useAssertions:Boolean = false;

	} // End Check
} // End Design By Contract