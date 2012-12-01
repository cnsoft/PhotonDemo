package svelto.dbc
{
	
/// <summary>
/// Exception raised when a postcondition fails.
/// </summary>
	public class PostconditionException extends DesignByContractException
	{
		public function PostconditionException(message:String)
		{
			super(message);
		}
	}
}