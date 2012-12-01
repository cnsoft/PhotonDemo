package svelto.dbc
{
	/// <summary>
	/// Exception raised when a precondition fails.
	/// </summary>
	public class InvariantException extends DesignByContractException
	{
		public function InvariantException(message:String) { super(message);  }
	}
}