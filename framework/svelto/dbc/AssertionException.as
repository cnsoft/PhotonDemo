package svelto.dbc
{
	/// <summary>
	/// Exception raised when an assertion fails.
	/// </summary>
	public class AssertionException extends DesignByContractException
	{
		public function AssertionException(message:String = null) { super(message);  }
	}
}